import { notFound } from 'next/navigation';
import Link from 'next/link';
import { query, queryOne } from '@/lib/db';
import { Category, Product } from '@/lib/types';
import { ProductCard } from '@/components/ProductCard';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Separator } from '@/components/ui/separator';

// Ensure category pages reflect live DB updates (manual inserts in Neon)
export const dynamic = 'force-dynamic';

interface PageProps {
  params: { slug: string };
  searchParams: {
    brand?: string;
    q?: string;
    minPrice?: string;
    maxPrice?: string;
    minRating?: string;
    inStock?: string;
    sort?: string;
    limit?: string;
    socket?: string;
    ramType?: string;
    storageType?: string;
    minVram?: string;
    minWattage?: string;
    formFactor?: string;
  };
}

async function getCategory(slug: string) {
  return queryOne<Category>('SELECT * FROM Category WHERE slug = $1', [slug]);
}

type CategoryFilters = PageProps['searchParams'];

function normalizeString(v?: string) {
  const t = v?.trim();
  return t ? t : undefined;
}

type FilterOptions = {
  sockets?: string[];
  ramTypes?: string[];
  formFactors?: string[];
  vramOptions?: number[];
  wattageOptions?: number[];
  storageTypes?: string[];
};

async function getProducts(slug: string, filters: CategoryFilters) {
  let sql = `
    SELECT p.*, c.name AS category_name, c.slug AS category_slug
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
  `;

  // Category-specific spec joins (only for the current category page)
  if (slug === 'cpu') sql += ` LEFT JOIN CPU_Spec cpu ON cpu.product_id = p.product_id`;
  if (slug === 'motherboard') sql += ` LEFT JOIN MOBO_Spec mobo ON mobo.product_id = p.product_id`;
  if (slug === 'gpu') sql += ` LEFT JOIN GPU_Spec gpu ON gpu.product_id = p.product_id`;
  if (slug === 'ram') sql += ` LEFT JOIN RAM_Spec ram ON ram.product_id = p.product_id`;
  if (slug === 'psu') sql += ` LEFT JOIN PSU_Spec psu ON psu.product_id = p.product_id`;
  if (slug === 'case') sql += ` LEFT JOIN CASE_Spec cs ON cs.product_id = p.product_id`;
  if (slug === 'storage') sql += ` LEFT JOIN Storage_Spec st ON st.product_id = p.product_id`;

  sql += ` WHERE c.slug = $1`;
  const params: (string | number)[] = [slug];
  let paramIndex = 2;

  const brand = normalizeString(filters.brand);
  const q = normalizeString(filters.q);
  const socket = normalizeString(filters.socket);
  const ramType = normalizeString(filters.ramType);
  const storageType = normalizeString(filters.storageType);
  const formFactor = normalizeString(filters.formFactor);

  const minPrice = normalizeString(filters.minPrice);
  const maxPrice = normalizeString(filters.maxPrice);
  const minRating = normalizeString(filters.minRating);
  const minVram = normalizeString(filters.minVram);
  const minWattage = normalizeString(filters.minWattage);

  if (brand) {
    sql += ` AND p.brand = $${paramIndex++}`;
    params.push(brand);
  }

  if (q) {
    sql += ` AND (
      p.name ILIKE $${paramIndex}
      OR p.brand ILIKE $${paramIndex}
      OR COALESCE(p.model, '') ILIKE $${paramIndex}
      OR COALESCE(p.description, '') ILIKE $${paramIndex}
    )`;
    params.push(`%${q}%`);
    paramIndex++;
  }

  if (minPrice) {
    sql += ` AND p.price >= $${paramIndex++}`;
    params.push(parseFloat(minPrice));
  }

  if (maxPrice) {
    sql += ` AND p.price <= $${paramIndex++}`;
    params.push(parseFloat(maxPrice));
  }

  if (minRating) {
    sql += ` AND p.rating >= $${paramIndex++}`;
    params.push(parseFloat(minRating));
  }
  if (filters.inStock === 'true') {
    sql += ' AND p.stock_qty > 0';
  }

  // Category-specific filters
  if ((slug === 'cpu' || slug === 'motherboard') && socket) {
    const col = slug === 'cpu' ? 'cpu.socket' : 'mobo.socket';
    sql += ` AND ${col} = $${paramIndex++}`;
    params.push(socket);
  }
  if ((slug === 'ram' || slug === 'motherboard') && ramType) {
    const col = slug === 'ram' ? 'ram.ram_type' : 'mobo.ram_type';
    sql += ` AND ${col} = $${paramIndex++}`;
    params.push(ramType);
  }
  if (slug === 'storage' && storageType) {
    sql += ` AND st.storage_type = $${paramIndex++}`;
    params.push(storageType);
  }
  if (slug === 'gpu' && minVram) {
    const v = parseInt(minVram, 10);
    if (!Number.isNaN(v)) {
      sql += ` AND gpu.vram_gb >= $${paramIndex++}`;
      params.push(v);
    }
  }
  if (slug === 'psu' && minWattage) {
    const w = parseInt(minWattage, 10);
    if (!Number.isNaN(w)) {
      sql += ` AND psu.wattage >= $${paramIndex++}`;
      params.push(w);
    }
  }
  if (slug === 'case' && formFactor) {
    sql += ` AND cs.supported_form_factor = $${paramIndex++}`;
    params.push(formFactor);
  }

  // Sorting (safe mapping)
  switch (filters.sort) {
    case 'price_asc':
      sql += ' ORDER BY p.price ASC, p.rating DESC, p.name ASC';
      break;
    case 'price_desc':
      sql += ' ORDER BY p.price DESC, p.rating DESC, p.name ASC';
      break;
    case 'name_asc':
      sql += ' ORDER BY p.name ASC, p.rating DESC';
      break;
    case 'newest':
      sql += ' ORDER BY p.created_at DESC, p.rating DESC';
      break;
    case 'stock_desc':
      sql += ' ORDER BY p.stock_qty DESC, p.rating DESC, p.name ASC';
      break;
    case 'rating_desc':
    default:
      sql += ' ORDER BY p.rating DESC, p.price ASC';
      break;
  }

  // Limit
  const limit = Math.min(Math.max(parseInt(filters.limit || '60', 10) || 60, 1), 200);
  sql += ` LIMIT $${paramIndex++}`;
  params.push(limit);

  return query<Product[]>(sql, params);
}

async function getBrands(slug: string) {
  return query<{ brand: string; count: number }[]>(`
    SELECT p.brand, COUNT(*) as count
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE c.slug = $1
    GROUP BY p.brand
    ORDER BY count DESC
  `, [slug]);
}

async function getFilterOptions(slug: string): Promise<FilterOptions> {
  // Returns per-category options needed to render "amplified" filters.
  if (slug === 'cpu') {
    const sockets = await query<{ value: string }[]>(
      `
      SELECT DISTINCT cpu.socket AS value
      FROM CPU_Spec cpu
      JOIN Product p ON p.product_id = cpu.product_id
      JOIN Category c ON c.category_id = p.category_id
      WHERE c.slug = $1
      ORDER BY cpu.socket ASC
      `,
      [slug]
    );
    return { sockets: sockets.map(s => s.value) };
  }
  if (slug === 'motherboard') {
    const [sockets, ramTypes, formFactors] = await Promise.all([
      query<{ value: string }[]>(
        `
        SELECT DISTINCT m.socket AS value
        FROM MOBO_Spec m
        JOIN Product p ON p.product_id = m.product_id
        JOIN Category c ON c.category_id = p.category_id
        WHERE c.slug = $1
        ORDER BY m.socket ASC
        `,
        [slug]
      ),
      query<{ value: string }[]>(
        `
        SELECT DISTINCT m.ram_type AS value
        FROM MOBO_Spec m
        JOIN Product p ON p.product_id = m.product_id
        JOIN Category c ON c.category_id = p.category_id
        WHERE c.slug = $1
        ORDER BY m.ram_type ASC
        `,
        [slug]
      ),
      query<{ value: string }[]>(
        `
        SELECT DISTINCT m.form_factor AS value
        FROM MOBO_Spec m
        JOIN Product p ON p.product_id = m.product_id
        JOIN Category c ON c.category_id = p.category_id
        WHERE c.slug = $1
        ORDER BY m.form_factor ASC
        `,
        [slug]
      ),
    ]);
    return {
      sockets: sockets.map(s => s.value),
      ramTypes: ramTypes.map(r => r.value),
      formFactors: formFactors.map(f => f.value),
    };
  }
  if (slug === 'gpu') {
    const vram = await query<{ value: number }[]>(
      `
      SELECT DISTINCT gpu.vram_gb AS value
      FROM GPU_Spec gpu
      JOIN Product p ON p.product_id = gpu.product_id
      JOIN Category c ON c.category_id = p.category_id
      WHERE c.slug = $1
      ORDER BY gpu.vram_gb ASC
      `,
      [slug]
    );
    return { vramOptions: vram.map(v => v.value) };
  }
  if (slug === 'ram') {
    const ramTypes = await query<{ value: string }[]>(
      `
      SELECT DISTINCT r.ram_type AS value
      FROM RAM_Spec r
      JOIN Product p ON p.product_id = r.product_id
      JOIN Category c ON c.category_id = p.category_id
      WHERE c.slug = $1
      ORDER BY r.ram_type ASC
      `,
      [slug]
    );
    return { ramTypes: ramTypes.map(r => r.value) };
  }
  if (slug === 'psu') {
    const wattage = await query<{ value: number }[]>(
      `
      SELECT DISTINCT psu.wattage AS value
      FROM PSU_Spec psu
      JOIN Product p ON p.product_id = psu.product_id
      JOIN Category c ON c.category_id = p.category_id
      WHERE c.slug = $1
      ORDER BY psu.wattage ASC
      `,
      [slug]
    );
    return { wattageOptions: wattage.map(w => w.value) };
  }
  if (slug === 'case') {
    const formFactors = await query<{ value: string }[]>(
      `
      SELECT DISTINCT cs.supported_form_factor AS value
      FROM CASE_Spec cs
      JOIN Product p ON p.product_id = cs.product_id
      JOIN Category c ON c.category_id = p.category_id
      WHERE c.slug = $1
      ORDER BY cs.supported_form_factor ASC
      `,
      [slug]
    );
    return { formFactors: formFactors.map(f => f.value) };
  }
  if (slug === 'storage') {
    const storageTypes = await query<{ value: string }[]>(
      `
      SELECT DISTINCT st.storage_type AS value
      FROM Storage_Spec st
      JOIN Product p ON p.product_id = st.product_id
      JOIN Category c ON c.category_id = p.category_id
      WHERE c.slug = $1
      ORDER BY st.storage_type ASC
      `,
      [slug]
    );
    return { storageTypes: storageTypes.map(s => s.value) };
  }
  return {};
}

async function getCategories() {
  return query<Category[]>('SELECT * FROM Category ORDER BY name');
}

export default async function CategoryPage({ params, searchParams }: PageProps) {
  const { slug } = params;
  const filters = searchParams;
  
  const [category, products, brands, categories, options] = await Promise.all([
    getCategory(slug),
    getProducts(slug, filters),
    getBrands(slug),
    getCategories(),
    getFilterOptions(slug),
  ]);

  if (!category) {
    notFound();
  }

  return (
    <div className="min-h-screen">
      {/* Header */}
      <div className="border-b border-border">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8">
          <nav className="flex items-center gap-2 text-sm text-muted-foreground mb-4 font-mono">
            <Link href="/" className="hover:text-foreground transition-colors">~</Link>
            <span>/</span>
            <span className="text-foreground">{category.slug}</span>
          </nav>
          <h1 className="text-3xl font-semibold">{category.name}</h1>
          <p className="text-muted-foreground mt-2 font-mono text-sm">
            {category.description ? `// ${category.description}` : null}
          </p>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8">
        <div className="flex flex-col lg:flex-row gap-8">
          {/* Sidebar */}
          <aside className="lg:w-56 flex-shrink-0 space-y-6">
            {/* Categories */}
            <div>
              <h3 className="text-xs font-mono text-muted-foreground mb-3">./categories</h3>
              <nav className="space-y-1">
                {categories.map((cat) => (
                  <Link
                    key={cat.category_id}
                    href={`/category/${cat.slug}`}
                    className={`block px-3 py-1.5 text-sm transition-colors ${
                      cat.slug === slug
                        ? 'bg-foreground text-background'
                        : 'text-muted-foreground hover:text-foreground'
                    }`}
                  >
                    {cat.slug === slug && '→ '}{cat.name.toLowerCase()}
                  </Link>
                ))}
              </nav>
            </div>

            <Separator />

            {/* Filters */}
            <div>
              <h3 className="text-xs font-mono text-muted-foreground mb-3">./filters</h3>
              
              <form method="GET" className="space-y-4">
                {/* Search */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    search
                  </label>
                  <Input
                    type="text"
                    name="q"
                    placeholder="name, model, brand..."
                    defaultValue={filters.q || ''}
                    className="text-sm"
                  />
                </div>

                {/* Brand Filter */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    brand
                  </label>
                  <select 
                    name="brand"
                    defaultValue={filters.brand || ''}
                    className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                  >
                    <option value="">all</option>
                    {brands.map((b) => (
                      <option key={b.brand} value={b.brand}>
                        {b.brand} ({b.count})
                      </option>
                    ))}
                  </select>
                </div>

                {/* Category-specific filters */}
                {slug === 'cpu' && options.sockets && options.sockets.length > 0 && (
                  <div>
                    <label className="block text-xs font-mono text-muted-foreground mb-2">
                      socket
                    </label>
                    <select
                      name="socket"
                      defaultValue={filters.socket || ''}
                      className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                    >
                      <option value="">all</option>
                      {options.sockets.map((s) => (
                        <option key={s} value={s}>{s}</option>
                      ))}
                    </select>
                  </div>
                )}

                {slug === 'motherboard' && (
                  <>
                    {options.sockets && options.sockets.length > 0 && (
                      <div>
                        <label className="block text-xs font-mono text-muted-foreground mb-2">socket</label>
                        <select
                          name="socket"
                          defaultValue={filters.socket || ''}
                          className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                        >
                          <option value="">all</option>
                          {options.sockets.map((s) => (
                            <option key={s} value={s}>{s}</option>
                          ))}
                        </select>
                      </div>
                    )}
                    {options.ramTypes && options.ramTypes.length > 0 && (
                      <div>
                        <label className="block text-xs font-mono text-muted-foreground mb-2">ram_type</label>
                        <select
                          name="ramType"
                          defaultValue={filters.ramType || ''}
                          className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                        >
                          <option value="">all</option>
                          {options.ramTypes.map((t) => (
                            <option key={t} value={t}>{t}</option>
                          ))}
                        </select>
                      </div>
                    )}
                    {options.formFactors && options.formFactors.length > 0 && (
                      <div>
                        <label className="block text-xs font-mono text-muted-foreground mb-2">form_factor</label>
                        <select
                          name="formFactor"
                          defaultValue={filters.formFactor || ''}
                          className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                        >
                          <option value="">all</option>
                          {options.formFactors.map((f) => (
                            <option key={f} value={f}>{f}</option>
                          ))}
                        </select>
                      </div>
                    )}
                  </>
                )}

                {slug === 'gpu' && options.vramOptions && options.vramOptions.length > 0 && (
                  <div>
                    <label className="block text-xs font-mono text-muted-foreground mb-2">
                      min_vram_gb
                    </label>
                    <select
                      name="minVram"
                      defaultValue={filters.minVram || ''}
                      className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                    >
                      <option value="">any</option>
                      {options.vramOptions.map((v) => (
                        <option key={v} value={v}>{v} GB+</option>
                      ))}
                    </select>
                  </div>
                )}

                {slug === 'ram' && options.ramTypes && options.ramTypes.length > 0 && (
                  <div>
                    <label className="block text-xs font-mono text-muted-foreground mb-2">
                      ram_type
                    </label>
                    <select
                      name="ramType"
                      defaultValue={filters.ramType || ''}
                      className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                    >
                      <option value="">all</option>
                      {options.ramTypes.map((t) => (
                        <option key={t} value={t}>{t}</option>
                      ))}
                    </select>
                  </div>
                )}

                {slug === 'psu' && options.wattageOptions && options.wattageOptions.length > 0 && (
                  <div>
                    <label className="block text-xs font-mono text-muted-foreground mb-2">
                      min_wattage
                    </label>
                    <select
                      name="minWattage"
                      defaultValue={filters.minWattage || ''}
                      className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                    >
                      <option value="">any</option>
                      {options.wattageOptions.map((w) => (
                        <option key={w} value={w}>{w}W+</option>
                      ))}
                    </select>
                  </div>
                )}

                {slug === 'case' && options.formFactors && options.formFactors.length > 0 && (
                  <div>
                    <label className="block text-xs font-mono text-muted-foreground mb-2">
                      form_factor
                    </label>
                    <select
                      name="formFactor"
                      defaultValue={filters.formFactor || ''}
                      className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                    >
                      <option value="">all</option>
                      {options.formFactors.map((f) => (
                        <option key={f} value={f}>{f}</option>
                      ))}
                    </select>
                  </div>
                )}

                {slug === 'storage' && options.storageTypes && options.storageTypes.length > 0 && (
                  <div>
                    <label className="block text-xs font-mono text-muted-foreground mb-2">
                      storage_type
                    </label>
                    <select
                      name="storageType"
                      defaultValue={filters.storageType || ''}
                      className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                    >
                      <option value="">all</option>
                      {options.storageTypes.map((t) => (
                        <option key={t} value={t}>{t}</option>
                      ))}
                    </select>
                  </div>
                )}

                {/* Price Range */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    price_range
                  </label>
                  <div className="flex gap-2">
                    <Input
                      type="number"
                      name="minPrice"
                      placeholder="min"
                      defaultValue={filters.minPrice || ''}
                      className="text-sm"
                    />
                    <Input
                      type="number"
                      name="maxPrice"
                      placeholder="max"
                      defaultValue={filters.maxPrice || ''}
                      className="text-sm"
                    />
                  </div>
                </div>

                {/* Min Rating */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    min_rating
                  </label>
                  <select
                    name="minRating"
                    defaultValue={filters.minRating || ''}
                    className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                  >
                    <option value="">any</option>
                    <option value="3.0">3.0+</option>
                    <option value="4.0">4.0+</option>
                    <option value="4.5">4.5+</option>
                    <option value="4.8">4.8+</option>
                  </select>
                </div>

                {/* In Stock */}
                <div className="flex items-center gap-2">
                  <input
                    type="checkbox"
                    name="inStock"
                    id="inStock"
                    value="true"
                    defaultChecked={filters.inStock === 'true'}
                    className="rounded-none border-border"
                  />
                  <label htmlFor="inStock" className="text-sm">
                    in_stock only
                  </label>
                </div>

                {/* Sort */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    sort
                  </label>
                  <select
                    name="sort"
                    defaultValue={filters.sort || 'rating_desc'}
                    className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                  >
                    <option value="rating_desc">rating ↓</option>
                    <option value="price_asc">price ↑</option>
                    <option value="price_desc">price ↓</option>
                    <option value="name_asc">name A→Z</option>
                    <option value="newest">newest</option>
                    <option value="stock_desc">stock ↓</option>
                  </select>
                </div>

                {/* Limit */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    limit
                  </label>
                  <select
                    name="limit"
                    defaultValue={filters.limit || '60'}
                    className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                  >
                    <option value="24">24</option>
                    <option value="60">60</option>
                    <option value="120">120</option>
                    <option value="200">200</option>
                  </select>
                </div>

                <Button type="submit" className="w-full font-mono text-sm">
                  apply()
                </Button>
                
                <Link href={`/category/${slug}`} className="block">
                  <Button variant="outline" className="w-full font-mono text-sm">
                    reset()
                  </Button>
                </Link>
              </form>
            </div>
          </aside>

          {/* Products Grid */}
          <main className="flex-1">
            <div className="flex items-center justify-between mb-6">
              <p className="text-sm text-muted-foreground font-mono">
                found: <span className="text-foreground">{products.length}</span> results
              </p>
            </div>

            {products.length > 0 ? (
              <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
                {products.map((product) => (
                  <ProductCard key={product.product_id} product={product} />
                ))}
              </div>
            ) : (
              <Card className="p-12 text-center">
                <div className="text-4xl mb-4">∅</div>
                <h3 className="font-semibold mb-2">no results</h3>
                <p className="text-sm text-muted-foreground mb-4">
                  try adjusting your filters
                </p>
                <Link href={`/category/${slug}`}>
                  <Button variant="outline" className="font-mono text-sm">
                    reset_filters()
                  </Button>
                </Link>
              </Card>
            )}
          </main>
        </div>
      </div>
    </div>
  );
}
