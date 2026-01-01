import { notFound } from 'next/navigation';
import Link from 'next/link';
import { query, queryOne } from '@/lib/db';
import { Category, Product } from '@/lib/types';
import { ProductCard } from '@/components/ProductCard';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Separator } from '@/components/ui/separator';

interface PageProps {
  params: { slug: string };
  searchParams: { brand?: string; minPrice?: string; maxPrice?: string; inStock?: string };
}

async function getCategory(slug: string) {
  return queryOne<Category>('SELECT * FROM Category WHERE slug = ?', [slug]);
}

async function getProducts(slug: string, filters: { brand?: string; minPrice?: string; maxPrice?: string; inStock?: string }) {
  let sql = `
    SELECT p.*, c.name AS category_name, c.slug AS category_slug
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE c.slug = ?
  `;
  const params: (string | number)[] = [slug];

  if (filters.brand) {
    sql += ' AND p.brand = ?';
    params.push(filters.brand);
  }
  if (filters.minPrice) {
    sql += ' AND p.price >= ?';
    params.push(parseFloat(filters.minPrice));
  }
  if (filters.maxPrice) {
    sql += ' AND p.price <= ?';
    params.push(parseFloat(filters.maxPrice));
  }
  if (filters.inStock === 'true') {
    sql += ' AND p.stock_qty > 0';
  }

  sql += ' ORDER BY p.rating DESC, p.price ASC';

  return query<Product[]>(sql, params);
}

async function getBrands(slug: string) {
  return query<{ brand: string; count: number }[]>(`
    SELECT p.brand, COUNT(*) as count
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE c.slug = ?
    GROUP BY p.brand
    ORDER BY count DESC
  `, [slug]);
}

async function getCategories() {
  return query<Category[]>('SELECT * FROM Category ORDER BY name');
}

export default async function CategoryPage({ params, searchParams }: PageProps) {
  const { slug } = params;
  const filters = searchParams;
  
  const [category, products, brands, categories] = await Promise.all([
    getCategory(slug),
    getProducts(slug, filters),
    getBrands(slug),
    getCategories(),
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
              
              <form className="space-y-4">
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
