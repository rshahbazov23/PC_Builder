import Link from 'next/link';
import Image from 'next/image';
import { query } from '@/lib/db';
import { Category, Product } from '@/lib/types';
import { ProductCard } from '@/components/ProductCard';
import { Button } from '@/components/ui/button';

// Ensure this page always reflects live DB data (important when you insert rows manually in Neon)
export const dynamic = 'force-dynamic';

async function getCategories() {
  try {
    return await query<Category[]>('SELECT * FROM Category ORDER BY name');
  } catch (error) {
    console.error('Error fetching categories:', error);
    return [];
  }
}

async function getDeals() {
  try {
    return await query<(Product & { savings_percentage: number })[]>(`
      SELECT 
        p.*, c.name AS category_name, c.slug AS category_slug,
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
      LIMIT 8
    `);
  } catch (error) {
    console.error('Error fetching deals:', error);
    return [];
  }
}

async function getTopRated() {
  try {
    return await query<Product[]>(`
      SELECT p.*, c.name AS category_name, c.slug AS category_slug
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      WHERE p.stock_qty > 0 AND p.rating >= 4.0
      ORDER BY p.rating DESC, p.price DESC
      LIMIT 8
    `);
  } catch (error) {
    console.error('Error fetching top rated:', error);
    return [];
  }
}

async function getBestSellers() {
  try {
    return await query<Product[]>(`
      SELECT p.*, c.name AS category_name, c.slug AS category_slug
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      WHERE p.stock_qty > 0
      ORDER BY p.rating DESC, p.stock_qty ASC
      LIMIT 8
    `);
  } catch (error) {
    console.error('Error fetching best sellers:', error);
    return [];
  }
}

async function getProductCounts() {
  try {
    const counts = await query<{ slug: string; count: number }[]>(`
      SELECT c.slug, COUNT(*) as count
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      GROUP BY c.slug
    `);
    return Object.fromEntries(counts.map(c => [c.slug, c.count]));
  } catch (error) {
    return {};
  }
}

const categoryData: Record<string, { icon: string; bg: string; image: string }> = {
  cpu: { icon: '⬡', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-CPU.png' },
  gpu: { icon: '▣', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-GPU.png' },
  motherboard: { icon: '⬢', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-MOTHERBOARD.png' },
  ram: { icon: '▤', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-RAM.png' },
  storage: { icon: '◉', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-STORAGE.png' },
  psu: { icon: '⚡', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-PSU.png' },
  case: { icon: '▢', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-CASE.png' },
  cooler: { icon: '❄', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-CPU-COOLER.png' },
  monitor: { icon: '🖥️', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-MONITOR.png' },
  keyboard: { icon: '⌨️', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-KEYBOARD.png' },
  mouse: { icon: '🖱️', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-MOUSE.png' },
  headset: { icon: '🎧', bg: 'bg-gradient-to-br from-zinc-100 to-zinc-200', image: '/images/categories/CATEGORY-HEADSET.png' },
};

export default async function HomePage() {
  const [categories, deals, topRated, bestSellers, productCounts] = await Promise.all([
    getCategories(),
    getDeals(),
    getTopRated(),
    getBestSellers(),
    getProductCounts(),
  ]);

  return (
    <div className="min-h-screen bg-muted/30">
      {/* Hero Banner */}
      <section className="bg-foreground text-background">
        <div className="max-w-7xl mx-auto px-4 py-8 md:py-12">
          <div className="grid md:grid-cols-2 gap-8 items-center">
            <div>
              <p className="text-sm text-background/70 mb-2">PC Builder Tool Available</p>
              <h1 className="text-3xl md:text-4xl font-bold mb-4">
                Build Your Dream PC
              </h1>
              <p className="text-background/80 mb-6">
                Automatic compatibility checking for CPU sockets, RAM types, and GPU clearance. 
                Get PSU recommendations based on your build.
              </p>
              <Link href="/builder">
                <Button variant="secondary" size="lg" className="font-semibold">
                  Start Building →
                </Button>
              </Link>
            </div>
            <div className="hidden md:grid grid-cols-3 gap-2">
              {bestSellers.slice(0, 6).map((product) => (
                <Link 
                  key={product.product_id}
                  href={`/product/${product.product_id}`}
                  className="aspect-square bg-background/10 hover:bg-background/20 transition-colors flex items-center justify-center text-3xl relative overflow-hidden"
                >
                  {product.image_url ? (
                    <Image src={product.image_url} alt={product.name} fill className="object-contain p-2" sizes="15vw" />
                  ) : (
                    categoryData[product.category_slug || '']?.icon || '◎'
                  )}
                </Link>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Category Strip */}
      <section className="bg-background border-b border-border">
        <div className="max-w-7xl mx-auto px-4">
          <div className="flex overflow-x-auto gap-1 py-2 scrollbar-hide">
            {categories.map((cat) => (
              <Link
                key={cat.category_id}
                href={`/category/${cat.slug}`}
                className="flex-shrink-0 px-4 py-2 text-sm hover:bg-muted transition-colors whitespace-nowrap"
              >
                {cat.name}
              </Link>
            ))}
            <Link
              href="/deals"
              className="flex-shrink-0 px-4 py-2 text-sm font-semibold text-red-600 hover:bg-muted transition-colors whitespace-nowrap"
            >
              Today&apos;s Deals
            </Link>
          </div>
        </div>
      </section>

      <div className="max-w-7xl mx-auto px-4 py-6 space-y-8">
        {/* Categories Grid + Promo */}
        <div className="grid md:grid-cols-4 gap-4">
          {/* Shop by Category Card */}
          <div className="md:col-span-2 bg-background border border-border p-5">
            <h2 className="font-bold text-lg mb-4">Shop by Category</h2>
            <div className="grid grid-cols-2 gap-3">
              {categories.slice(0, 4).map((cat) => (
                <Link
                  key={cat.category_id}
                  href={`/category/${cat.slug}`}
                  className={`${categoryData[cat.slug]?.bg || 'bg-muted'} p-4 hover:opacity-90 transition-opacity`}
                >
                  <div className="h-16 mb-2 relative">
                    {categoryData[cat.slug]?.image ? (
                      <Image src={categoryData[cat.slug].image} alt={cat.name} fill className="object-contain" sizes="15vw" />
                    ) : (
                      <div className="text-3xl">{categoryData[cat.slug]?.icon || '◎'}</div>
                    )}
                  </div>
                  <div className="text-sm font-medium">{cat.name}</div>
                </Link>
              ))}
            </div>
            <Link href="/category/cpu" className="text-sm text-blue-600 hover:underline mt-4 inline-block">
              See all categories
            </Link>
          </div>

          {/* Deals Card */}
          <div className="bg-background border border-border p-5">
            <h2 className="font-bold text-lg mb-4">Today&apos;s Deals</h2>
            <div className="grid grid-cols-2 gap-2">
              {deals.slice(0, 4).map((p) => (
                <Link key={p.product_id} href={`/product/${p.product_id}`} className="group">
                  <div className="aspect-square bg-muted flex items-center justify-center text-2xl mb-1 relative overflow-hidden">
                    {p.image_url ? (
                      <Image src={p.image_url} alt={p.name} fill className="object-contain p-2" sizes="25vw" />
                    ) : (
                      categoryData[p.category_slug || '']?.icon || '◎'
                    )}
                  </div>
                  <div className="text-xs text-red-600 font-semibold">-{p.savings_percentage}%</div>
                </Link>
              ))}
            </div>
            <Link href="/deals" className="text-sm text-blue-600 hover:underline mt-4 inline-block">
              See all deals
            </Link>
          </div>

          {/* PC Builder Card */}
          <div className="bg-background border border-border p-5">
            <h2 className="font-bold text-lg mb-4">PC Builder</h2>
            <div className="aspect-video bg-muted flex items-center justify-center mb-4">
              <div className="text-4xl">🖥️</div>
            </div>
            <p className="text-sm text-muted-foreground mb-4">
              Check part compatibility automatically
            </p>
            <Link href="/builder">
              <Button size="sm" className="w-full">Open Builder</Button>
            </Link>
          </div>
        </div>

        {/* Deals Row */}
        {deals.length > 0 && (
          <section className="bg-background border border-border p-5">
            <div className="flex items-center justify-between mb-4">
              <h2 className="font-bold text-lg">Today&apos;s Deals</h2>
              <Link href="/deals" className="text-sm text-blue-600 hover:underline">
                See all
              </Link>
            </div>
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4">
              {deals.slice(0, 5).map((product) => (
                <Link key={product.product_id} href={`/product/${product.product_id}`} className="group">
                  <div className="aspect-square bg-muted flex items-center justify-center text-4xl mb-2 group-hover:bg-muted/70 transition-colors relative overflow-hidden">
                    {product.image_url ? (
                      <Image src={product.image_url} alt={product.name} fill className="object-contain p-2" sizes="20vw" />
                    ) : (
                      categoryData[product.category_slug || '']?.icon || '◎'
                    )}
                  </div>
                  <div className="text-xs line-clamp-2 group-hover:text-blue-600 mb-1">{product.name}</div>
                  <div className="flex items-center gap-2">
                    <span className="text-sm font-bold">${Number(product.price).toFixed(0)}</span>
                    <span className="text-xs text-red-600 font-semibold">-{product.savings_percentage}%</span>
                  </div>
                </Link>
              ))}
            </div>
          </section>
        )}

        {/* Top Rated Row */}
        {topRated.length > 0 && (
          <section className="bg-background border border-border p-5">
            <div className="flex items-center justify-between mb-4">
              <h2 className="font-bold text-lg">Top Rated Products</h2>
              <Link href="/top-brands" className="text-sm text-blue-600 hover:underline">
                Top brands
              </Link>
            </div>
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4">
              {topRated.slice(0, 5).map((product) => (
                <Link key={product.product_id} href={`/product/${product.product_id}`} className="group">
                  <div className="aspect-square bg-muted flex items-center justify-center text-4xl mb-2 group-hover:bg-muted/70 transition-colors relative overflow-hidden">
                    {product.image_url ? (
                      <Image src={product.image_url} alt={product.name} fill className="object-contain p-2" sizes="20vw" />
                    ) : (
                      categoryData[product.category_slug || '']?.icon || '◎'
                    )}
                  </div>
                  <div className="text-xs line-clamp-2 group-hover:text-blue-600 mb-1">{product.name}</div>
                  <div className="flex items-center gap-2">
                    <span className="text-sm font-bold">${Number(product.price).toFixed(0)}</span>
                    <span className="text-xs text-muted-foreground">★ {product.rating}</span>
                  </div>
                </Link>
              ))}
            </div>
          </section>
        )}

        {/* More Categories */}
        <section className="bg-background border border-border p-5">
          <h2 className="font-bold text-lg mb-4">Browse All Categories</h2>
          <div className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-7 gap-4">
            {categories.map((cat) => (
              <Link
                key={cat.category_id}
                href={`/category/${cat.slug}`}
                className="text-center group"
              >
                <div className="aspect-square bg-muted flex items-center justify-center text-3xl mb-2 group-hover:bg-muted/70 transition-colors relative overflow-hidden">
                  {categoryData[cat.slug]?.image ? (
                    <Image src={categoryData[cat.slug].image} alt={cat.name} fill className="object-contain p-2" sizes="15vw" />
                  ) : (
                    categoryData[cat.slug]?.icon || '◎'
                  )}
                </div>
                <div className="text-xs font-medium group-hover:text-blue-600">{cat.name}</div>
                <div className="text-xs text-muted-foreground">{productCounts[cat.slug] || 0} items</div>
              </Link>
            ))}
          </div>
        </section>

        {/* Best Sellers */}
        {bestSellers.length > 0 && (
          <section className="bg-background border border-border p-5">
            <div className="flex items-center justify-between mb-4">
              <h2 className="font-bold text-lg">Popular in PC Components</h2>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              {bestSellers.slice(0, 4).map((product) => (
                <ProductCard key={product.product_id} product={product} />
              ))}
            </div>
          </section>
        )}
      </div>
    </div>
  );
}
