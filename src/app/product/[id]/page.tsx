import { notFound } from 'next/navigation';
import Link from 'next/link';
import Image from 'next/image';
import { query, queryOne } from '@/lib/db';
import { Product, CPUSpec, MOBOSpec, GPUSpec, CASESpec, PSUSpec, RAMSpec, StorageSpec } from '@/lib/types';
import { StarRating } from '@/components/ProductCard';
import { AddToBuildButton } from './AddToBuildButton';
import { Card } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';

interface PageProps {
  params: { id: string };
}

type Specs = CPUSpec | MOBOSpec | GPUSpec | CASESpec | PSUSpec | RAMSpec | StorageSpec;

async function getProduct(id: number) {
  return queryOne<Product & { category_slug: string }>(`
    SELECT p.*, c.name AS category_name, c.slug AS category_slug
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE p.product_id = $1
  `, [id]);
}

async function getSpecs(productId: number, categorySlug: string): Promise<Specs | null> {
  const specTables: Record<string, string> = {
    cpu: 'CPU_Spec',
    motherboard: 'MOBO_Spec',
    gpu: 'GPU_Spec',
    case: 'CASE_Spec',
    psu: 'PSU_Spec',
    ram: 'RAM_Spec',
    storage: 'Storage_Spec',
  };

  const table = specTables[categorySlug];
  if (!table) return null;

  return queryOne<Specs>(`SELECT * FROM ${table} WHERE product_id = $1`, [productId]);
}

async function getSimilarProducts(categoryId: number, productId: number) {
  return query<Product[]>(`
    SELECT p.*, c.slug AS category_slug
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE p.category_id = $1 AND p.product_id != $2
    ORDER BY p.rating DESC
    LIMIT 4
  `, [categoryId, productId]);
}

export default async function ProductPage({ params }: PageProps) {
  const productId = parseInt(params.id);

  const product = await getProduct(productId);
  if (!product) {
    notFound();
  }

  const [specs, similarProducts] = await Promise.all([
    getSpecs(productId, product.category_slug),
    getSimilarProducts(product.category_id, productId),
  ]);

  const inStock = product.stock_qty > 0;

  return (
    <div className="min-h-screen">
      {/* Breadcrumb */}
      <div className="border-b border-border">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 py-4">
          <nav className="flex items-center gap-2 text-sm text-muted-foreground font-mono">
            <Link href="/" className="hover:text-foreground transition-colors">~</Link>
            <span>/</span>
            <Link href={`/category/${product.category_slug}`} className="hover:text-foreground transition-colors">
              {product.category_slug}
            </Link>
            <span>/</span>
            <span className="text-foreground truncate max-w-xs">{product.model || 'item'}</span>
          </nav>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8">
        {/* Product Main Section */}
        <div className="grid lg:grid-cols-2 gap-12 mb-16">
          {/* Product Image */}
          <Card className="aspect-square bg-muted/30 flex items-center justify-center relative overflow-hidden">
            <div className="absolute inset-0 dot-bg opacity-30" />
            {product.image_url ? (
              <Image
                src={product.image_url}
                alt={product.name}
                fill
                className="object-contain p-6"
                sizes="(max-width: 1024px) 100vw, 50vw"
                priority
              />
            ) : (
              <div className="text-8xl text-muted-foreground/20">
                {product.category_slug === 'cpu' && '⬡'}
                {product.category_slug === 'gpu' && '▣'}
                {product.category_slug === 'motherboard' && '⬢'}
                {product.category_slug === 'ram' && '▤'}
                {product.category_slug === 'storage' && '◉'}
                {product.category_slug === 'psu' && '⚡'}
                {product.category_slug === 'case' && '▢'}
              </div>
            )}
            <Badge className="absolute top-4 left-4 font-mono">
              {product.category_slug?.toUpperCase()}
            </Badge>
          </Card>

          {/* Product Info */}
          <div>
            <div className="flex items-center gap-3 mb-4">
              <span className="text-sm text-muted-foreground font-mono">{product.brand}</span>
              <span className={`text-sm font-mono ${inStock ? 'text-foreground' : 'text-muted-foreground'}`}>
                {inStock ? `● ${product.stock_qty} in stock` : '○ out of stock'}
              </span>
            </div>

            <h1 className="text-2xl md:text-3xl font-semibold mb-6">
              {product.name}
            </h1>

            <div className="flex items-center gap-4 mb-6">
              <StarRating rating={Number(product.rating)} />
              <span className="text-sm text-muted-foreground font-mono">
                {product.rating}/5.0
              </span>
            </div>

            <div className="mb-8">
              <div className="text-4xl font-semibold font-mono mb-1">
                ${Number(product.price).toFixed(2)}
              </div>
              {product.power_watts > 0 && (
                <div className="text-sm text-muted-foreground font-mono">
                  power_draw: {product.power_watts}W
                </div>
              )}
            </div>

            {product.description && (
              <p className="text-muted-foreground mb-8 leading-relaxed">
                {product.description}
              </p>
            )}

            <AddToBuildButton productId={productId} disabled={!inStock} />
          </div>
        </div>

        {/* Specifications */}
        {specs && (
          <>
            <Separator className="mb-8" />
            <div className="mb-16">
              <h2 className="text-xl font-semibold mb-6">./specifications</h2>
              <Card className="p-6">
                <SpecsTable specs={specs} category={product.category_slug} />
              </Card>
            </div>
          </>
        )}

        {/* Similar Products */}
        {similarProducts.length > 0 && (
          <>
            <Separator className="mb-8" />
            <div>
              <h2 className="text-xl font-semibold mb-6">./similar</h2>
              <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
                {similarProducts.map((p) => (
                  <Link key={p.product_id} href={`/product/${p.product_id}`}>
                    <Card className="p-4 hover:border-foreground/30 transition-colors">
                      <div className="aspect-square bg-muted/30 rounded mb-3 flex items-center justify-center relative overflow-hidden">
                        {p.image_url ? (
                          <Image
                            src={p.image_url}
                            alt={p.name}
                            fill
                            className="object-contain p-2"
                            sizes="25vw"
                          />
                        ) : (
                          <span className="text-2xl text-muted-foreground/30">
                            {p.category_slug === 'cpu' && '⬡'}
                            {p.category_slug === 'gpu' && '▣'}
                            {p.category_slug === 'motherboard' && '⬢'}
                            {p.category_slug === 'ram' && '▤'}
                            {p.category_slug === 'storage' && '◉'}
                            {p.category_slug === 'psu' && '⚡'}
                            {p.category_slug === 'case' && '▢'}
                          </span>
                        )}
                      </div>
                      <h3 className="text-sm font-medium line-clamp-2 mb-2">{p.name}</h3>
                      <p className="font-mono font-semibold">${Number(p.price).toFixed(2)}</p>
                    </Card>
                  </Link>
                ))}
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

function SpecsTable({ specs, category }: { specs: Specs; category: string }) {
  const specLabels: Record<string, Record<string, string>> = {
    cpu: {
      socket: 'socket',
      core_count: 'cores',
      thread_count: 'threads',
      base_clock_ghz: 'base_clock',
      boost_clock_ghz: 'boost_clock',
      tdp_watts: 'tdp',
    },
    motherboard: {
      socket: 'socket',
      form_factor: 'form_factor',
      ram_type: 'ram_type',
      ram_slots: 'ram_slots',
      max_ram_gb: 'max_ram',
      pcie_version: 'pcie',
    },
    gpu: {
      length_mm: 'length',
      vram_gb: 'vram',
      min_psu_watts: 'min_psu',
      pcie_version: 'pcie',
    },
    case: {
      max_gpu_length_mm: 'max_gpu_length',
      supported_form_factor: 'form_factor',
      max_psu_length_mm: 'max_psu_length',
      drive_bays_25: 'bays_2.5"',
      drive_bays_35: 'bays_3.5"',
    },
    psu: {
      wattage: 'wattage',
      efficiency_rating: 'efficiency',
      modular: 'modular',
      psu_length_mm: 'length',
    },
    ram: {
      ram_type: 'type',
      speed_mhz: 'speed',
      size_gb: 'size',
      modules: 'modules',
      latency: 'latency',
    },
    storage: {
      storage_type: 'type',
      capacity_gb: 'capacity',
      form_factor: 'form_factor',
      read_speed_mbps: 'read_speed',
      write_speed_mbps: 'write_speed',
    },
  };

  const labels = specLabels[category] || {};
  const entries = Object.entries(specs).filter(([key]) => key !== 'product_id' && labels[key]);

  return (
    <div className="grid md:grid-cols-2 gap-x-8 gap-y-3">
      {entries.map(([key, value]) => (
        <div key={key} className="flex justify-between py-2 border-b border-border">
          <span className="text-muted-foreground font-mono text-sm">{labels[key]}</span>
          <span className="font-mono text-sm">
            {formatSpecValue(key, value)}
          </span>
        </div>
      ))}
    </div>
  );
}

function formatSpecValue(key: string, value: unknown): string {
  if (value === null || value === undefined) return '-';
  
  const valueStr = String(value);
  
  if (key.includes('ghz')) return `${value} GHz`;
  if (key.includes('watts') || key === 'tdp_watts' || key === 'wattage') return `${value}W`;
  if (key.includes('_mm')) return `${value}mm`;
  if (key.includes('_gb') || key === 'vram_gb' || key === 'size_gb' || key === 'max_ram_gb') return `${value}GB`;
  if (key.includes('_mhz')) return `${value}MHz`;
  if (key.includes('_mbps')) return `${value}MB/s`;
  
  return valueStr;
}
