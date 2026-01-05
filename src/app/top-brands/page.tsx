import Link from 'next/link';
import { query } from '@/lib/db';
import { StarRating } from '@/components/ProductCard';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';

export const dynamic = 'force-dynamic';

interface TopBrand {
  category_name: string;
  category_slug: string;
  brand: string;
  num_products: number;
  avg_rating: number;
  avg_price: number;
  min_price: number;
  max_price: number;
  total_stock: number;
}

async function getTopBrands() {
  return query<TopBrand[]>(`
    SELECT 
      c.name AS category_name,
      c.slug AS category_slug,
      p.brand,
      COUNT(*)::int AS num_products,
      ROUND(AVG(p.rating)::numeric, 2)::float8 AS avg_rating,
      ROUND(AVG(p.price)::numeric, 2)::float8 AS avg_price,
      MIN(p.price)::float8 AS min_price,
      MAX(p.price)::float8 AS max_price,
      SUM(p.stock_qty)::int AS total_stock
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE p.stock_qty > 0
    GROUP BY c.category_id, c.name, c.slug, p.brand
    HAVING COUNT(*) >= 3 AND AVG(p.rating) >= 4.0
    ORDER BY c.name ASC, avg_rating DESC, num_products DESC
  `);
}

export default async function TopBrandsPage() {
  const topBrands = await getTopBrands();

  // Group by category
  const brandsByCategory = topBrands.reduce((acc, brand) => {
    if (!acc[brand.category_name]) acc[brand.category_name] = [];
    acc[brand.category_name].push(brand);
    return acc;
  }, {} as Record<string, TopBrand[]>);

  return (
    <div className="min-h-screen">
      {/* Header */}
      <div className="border-b border-border">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 py-12">
          <nav className="flex items-center gap-2 text-sm text-muted-foreground mb-4 font-mono">
            <Link href="/" className="hover:text-foreground transition-colors">~</Link>
            <span>/</span>
            <span className="text-foreground">top-brands</span>
          </nav>
          <h1 className="text-3xl font-semibold mb-2">./top_brands</h1>
          <p className="text-muted-foreground font-mono text-sm">
            {'// brands with 3+ products and 4.0+ rating'}
          </p>
          <div className="mt-4 p-3 bg-muted text-sm font-mono">
            <span className="text-muted-foreground">query:</span> GROUP BY + HAVING with COUNT/AVG filters
          </div>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8">
        {/* Stats */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">{topBrands.length}</div>
            <div className="text-xs text-muted-foreground font-mono">total_brands</div>
          </Card>
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">{Object.keys(brandsByCategory).length}</div>
            <div className="text-xs text-muted-foreground font-mono">categories</div>
          </Card>
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">
              {topBrands.length > 0 ? Math.max(...topBrands.map(b => b.avg_rating)).toFixed(1) : 0}
            </div>
            <div className="text-xs text-muted-foreground font-mono">highest_rating</div>
          </Card>
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">
              {topBrands.reduce((sum, b) => sum + Number(b.num_products), 0)}
            </div>
            <div className="text-xs text-muted-foreground font-mono">total_products</div>
          </Card>
        </div>

        <Separator className="mb-8" />

        {/* Brands by Category */}
        {Object.entries(brandsByCategory).map(([category, brands]) => (
          <section key={category} className="mb-12">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-xl font-semibold">./{category.toLowerCase()}</h2>
              <Link 
                href={`/category/${brands[0]?.category_slug || ''}`}
                className="text-sm text-muted-foreground hover:text-foreground transition-colors font-mono"
              >
                view_all →
              </Link>
            </div>
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
              {brands.map((brand, index) => (
                <Card 
                  key={brand.brand} 
                  className={`p-5 ${index === 0 ? 'border-foreground/50' : ''}`}
                >
                  {index === 0 && (
                    <div className="text-xs font-mono text-muted-foreground mb-3">
                      {'// top rated'}
                    </div>
                  )}
                  
                  <div className="flex items-start justify-between mb-4">
                    <div>
                      <h3 className="font-semibold">{brand.brand}</h3>
                      <p className="text-xs text-muted-foreground font-mono">
                        {brand.num_products} products
                      </p>
                    </div>
                    <div className="text-right">
                      <StarRating rating={Math.round(brand.avg_rating)} />
                      <p className="text-xs text-muted-foreground font-mono mt-1">
                        {brand.avg_rating}/5
                      </p>
                    </div>
                  </div>

                  <div className="grid grid-cols-3 gap-4 text-xs font-mono mb-4">
                    <div>
                      <p className="text-muted-foreground">avg</p>
                      <p>${Number(brand.avg_price).toFixed(0)}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">range</p>
                      <p>${Number(brand.min_price).toFixed(0)}-{Number(brand.max_price).toFixed(0)}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">stock</p>
                      <p>{brand.total_stock}</p>
                    </div>
                  </div>

                  <Link href={`/category/${brand.category_slug}?brand=${encodeURIComponent(brand.brand)}`}>
                    <Button variant="outline" className="w-full font-mono text-sm">
                      view_products()
                    </Button>
                  </Link>
                </Card>
              ))}
            </div>
          </section>
        ))}
      </div>
    </div>
  );
}
