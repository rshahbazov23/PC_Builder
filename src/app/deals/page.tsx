import Link from 'next/link';
import { query } from '@/lib/db';
import { Product, Category } from '@/lib/types';
import { ProductCard } from '@/components/ProductCard';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Separator } from '@/components/ui/separator';

export const dynamic = 'force-dynamic';

interface DealProduct extends Product {
  savings_percentage: number;
  category_avg_price: number;
  savings_amount: number;
}

interface PageProps {
  searchParams: {
    brand?: string;
    category?: string;
    q?: string;
    minPrice?: string;
    maxPrice?: string;
    minRating?: string;
    minDiscount?: string;
    sort?: string;
    limit?: string;
  };
}

function normalizeString(v?: string) {
  const t = v?.trim();
  return t ? t : undefined;
}

async function getDeals(filters: PageProps['searchParams']) {
  let sql = `
    SELECT 
      p.*, c.name AS category_name, c.slug AS category_slug,
      (SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id) AS category_avg_price,
      ((SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id) - p.price) AS savings_amount,
      ROUND(
        (
          (SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id) - p.price
        ) / (SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id) * 100
      , 1) AS savings_percentage
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE p.stock_qty > 0
      AND p.price < (SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id)
  `;

  const params: (string | number)[] = [];
  let paramIndex = 1;

  const brand = normalizeString(filters.brand);
  const category = normalizeString(filters.category);
  const q = normalizeString(filters.q);
  const minPrice = normalizeString(filters.minPrice);
  const maxPrice = normalizeString(filters.maxPrice);
  const minRating = normalizeString(filters.minRating);
  const minDiscount = normalizeString(filters.minDiscount);

  if (brand) {
    sql += ` AND p.brand = $${paramIndex++}`;
    params.push(brand);
  }

  if (category) {
    sql += ` AND c.slug = $${paramIndex++}`;
    params.push(category);
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

  if (minDiscount) {
    sql += ` AND ROUND(
      (
        (SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id) - p.price
      ) / (SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id) * 100
    , 1) >= $${paramIndex++}`;
    params.push(parseFloat(minDiscount));
  }

  // Sorting
  switch (filters.sort) {
    case 'discount_desc':
      sql += ' ORDER BY savings_percentage DESC, p.rating DESC';
      break;
    case 'savings_desc':
      sql += ' ORDER BY savings_amount DESC, p.rating DESC';
      break;
    case 'price_asc':
      sql += ' ORDER BY p.price ASC, savings_percentage DESC';
      break;
    case 'price_desc':
      sql += ' ORDER BY p.price DESC, savings_percentage DESC';
      break;
    case 'rating_desc':
      sql += ' ORDER BY p.rating DESC, savings_percentage DESC';
      break;
    case 'name_asc':
      sql += ' ORDER BY p.name ASC';
      break;
    default:
      sql += ' ORDER BY savings_percentage DESC, p.rating DESC';
      break;
  }

  // Limit
  const limit = Math.min(Math.max(parseInt(filters.limit || '50', 10) || 50, 1), 200);
  sql += ` LIMIT $${paramIndex++}`;
  params.push(limit);

  return query<DealProduct[]>(sql, params);
}

async function getBrands() {
  return query<{ brand: string; count: number }[]>(`
    SELECT p.brand, COUNT(*) as count
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE p.stock_qty > 0
      AND p.price < (SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id)
    GROUP BY p.brand
    ORDER BY count DESC
  `);
}

async function getCategories() {
  return query<Category[]>('SELECT * FROM Category ORDER BY name');
}

async function getDealCategories() {
  return query<{ slug: string; name: string; count: number }[]>(`
    SELECT c.slug, c.name, COUNT(*) as count
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE p.stock_qty > 0
      AND p.price < (SELECT AVG(p2.price) FROM Product p2 WHERE p2.category_id = p.category_id)
    GROUP BY c.slug, c.name
    ORDER BY count DESC
  `);
}

export default async function DealsPage({ searchParams }: PageProps) {
  const filters = searchParams;
  
  const [deals, brands, categories, dealCategories] = await Promise.all([
    getDeals(filters),
    getBrands(),
    getCategories(),
    getDealCategories(),
  ]);

  // Stats
  const maxDiscount = deals.length > 0 ? Math.max(...deals.map(d => d.savings_percentage)) : 0;
  const maxSavings = deals.length > 0 ? Math.max(...deals.map(d => d.savings_amount)) : 0;
  const avgDiscount = deals.length > 0 ? deals.reduce((sum, d) => sum + d.savings_percentage, 0) / deals.length : 0;

  return (
    <div className="min-h-screen">
      {/* Header */}
      <div className="border-b border-border">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 py-12">
          <nav className="flex items-center gap-2 text-sm text-muted-foreground mb-4 font-mono">
            <Link href="/" className="hover:text-foreground transition-colors">~</Link>
            <span>/</span>
            <span className="text-foreground">deals</span>
          </nav>
          <h1 className="text-3xl font-semibold mb-2">./deals</h1>
          <p className="text-muted-foreground font-mono text-sm">
            {'// products priced below category average'}
          </p>
          <div className="mt-4 p-3 bg-muted text-sm font-mono">
            <span className="text-muted-foreground">query:</span> correlated subquery with AVG aggregate
          </div>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8">
        {/* Stats */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">{deals.length}</div>
            <div className="text-xs text-muted-foreground font-mono">total_deals</div>
          </Card>
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">{maxDiscount.toFixed(0)}%</div>
            <div className="text-xs text-muted-foreground font-mono">max_discount</div>
          </Card>
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">{avgDiscount.toFixed(0)}%</div>
            <div className="text-xs text-muted-foreground font-mono">avg_discount</div>
          </Card>
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">${maxSavings.toFixed(0)}</div>
            <div className="text-xs text-muted-foreground font-mono">max_savings</div>
          </Card>
        </div>

        <Separator className="mb-8" />

        <div className="flex flex-col lg:flex-row gap-8">
          {/* Sidebar */}
          <aside className="lg:w-56 flex-shrink-0 space-y-6">
            {/* Categories */}
            <div>
              <h3 className="text-xs font-mono text-muted-foreground mb-3">./categories</h3>
              <nav className="space-y-1">
                <Link
                  href="/deals"
                  className={`block px-3 py-1.5 text-sm transition-colors ${
                    !filters.category
                      ? 'bg-foreground text-background'
                      : 'text-muted-foreground hover:text-foreground'
                  }`}
                >
                  {!filters.category && '→ '}all deals
                </Link>
                {dealCategories.map((cat) => (
                  <Link
                    key={cat.slug}
                    href={`/deals?category=${cat.slug}`}
                    className={`block px-3 py-1.5 text-sm transition-colors ${
                      filters.category === cat.slug
                        ? 'bg-foreground text-background'
                        : 'text-muted-foreground hover:text-foreground'
                    }`}
                  >
                    {filters.category === cat.slug && '→ '}{cat.name.toLowerCase()} ({cat.count})
                  </Link>
                ))}
              </nav>
            </div>

            <Separator />

            {/* Filters */}
            <div>
              <h3 className="text-xs font-mono text-muted-foreground mb-3">./filters</h3>
              
              <form method="GET" className="space-y-4">
                {/* Preserve category filter */}
                {filters.category && (
                  <input type="hidden" name="category" value={filters.category} />
                )}

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

                {/* Min Discount */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    min_discount
                  </label>
                  <select
                    name="minDiscount"
                    defaultValue={filters.minDiscount || ''}
                    className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                  >
                    <option value="">any</option>
                    <option value="5">5%+</option>
                    <option value="10">10%+</option>
                    <option value="15">15%+</option>
                    <option value="20">20%+</option>
                    <option value="25">25%+</option>
                    <option value="30">30%+</option>
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

                {/* Sort */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    sort
                  </label>
                  <select
                    name="sort"
                    defaultValue={filters.sort || 'discount_desc'}
                    className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                  >
                    <option value="discount_desc">discount % ↓</option>
                    <option value="savings_desc">savings $ ↓</option>
                    <option value="price_asc">price ↑</option>
                    <option value="price_desc">price ↓</option>
                    <option value="rating_desc">rating ↓</option>
                    <option value="name_asc">name A→Z</option>
                  </select>
                </div>

                {/* Limit */}
                <div>
                  <label className="block text-xs font-mono text-muted-foreground mb-2">
                    limit
                  </label>
                  <select
                    name="limit"
                    defaultValue={filters.limit || '50'}
                    className="w-full px-3 py-1.5 text-sm bg-background border border-border focus:border-foreground outline-none transition-colors"
                  >
                    <option value="24">24</option>
                    <option value="50">50</option>
                    <option value="100">100</option>
                    <option value="200">200</option>
                  </select>
                </div>

                <Button type="submit" className="w-full font-mono text-sm">
                  apply()
                </Button>
                
                <Link href="/deals" className="block">
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
                found: <span className="text-foreground">{deals.length}</span> deals
              </p>
            </div>

            {deals.length > 0 ? (
              <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
                {deals.map((deal) => (
                  <div key={deal.product_id} className="relative">
                    <div className="absolute top-3 right-3 z-10 bg-foreground text-background text-xs font-mono px-2 py-1">
                      -{deal.savings_percentage}%
                    </div>
                    <ProductCard product={deal} />
                    <div className="mt-2 p-3 bg-muted text-xs font-mono">
                      <div className="flex justify-between">
                        <span className="text-muted-foreground">avg:</span>
                        <span className="line-through">${Number(deal.category_avg_price).toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-muted-foreground">save:</span>
                        <span>${Number(deal.savings_amount).toFixed(2)}</span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <Card className="p-12 text-center">
                <div className="text-4xl mb-4">∅</div>
                <h3 className="font-semibold mb-2">no deals found</h3>
                <p className="text-sm text-muted-foreground mb-4">
                  try adjusting your filters
                </p>
                <Link href="/deals">
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
