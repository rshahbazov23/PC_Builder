import Link from 'next/link';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';
import { ProductCard } from '@/components/ProductCard';
import { Card } from '@/components/ui/card';
import { Separator } from '@/components/ui/separator';

export const dynamic = 'force-dynamic';

interface DealProduct extends Product {
  savings_percentage: number;
  category_avg_price: number;
  savings_amount: number;
}

async function getDeals() {
  return query<DealProduct[]>(`
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
    ORDER BY savings_percentage DESC
    LIMIT 50
  `);
}

export default async function DealsPage() {
  const deals = await getDeals();

  // Group deals by category
  const dealsByCategory = deals.reduce((acc, deal) => {
    const cat = deal.category_name || 'Other';
    if (!acc[cat]) acc[cat] = [];
    acc[cat].push(deal);
    return acc;
  }, {} as Record<string, DealProduct[]>);

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
            <div className="text-2xl font-semibold mb-1">
              {deals.length > 0 ? Math.max(...deals.map(d => d.savings_percentage)).toFixed(0) : 0}%
            </div>
            <div className="text-xs text-muted-foreground font-mono">max_discount</div>
          </Card>
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">{Object.keys(dealsByCategory).length}</div>
            <div className="text-xs text-muted-foreground font-mono">categories</div>
          </Card>
          <Card className="p-4">
            <div className="text-2xl font-semibold mb-1">
              ${deals.length > 0 ? Math.max(...deals.map(d => d.savings_amount)).toFixed(0) : 0}
            </div>
            <div className="text-xs text-muted-foreground font-mono">max_savings</div>
          </Card>
        </div>

        <Separator className="mb-8" />

        {/* Deals by Category */}
        {Object.entries(dealsByCategory).map(([category, categoryDeals]) => (
          <section key={category} className="mb-12">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-xl font-semibold">./{category.toLowerCase()}</h2>
              <span className="text-sm text-muted-foreground font-mono">
                [{categoryDeals.length}]
              </span>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              {categoryDeals.slice(0, 8).map((deal) => (
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
          </section>
        ))}
      </div>
    </div>
  );
}
