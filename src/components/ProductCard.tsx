'use client';

import Link from 'next/link';
import Image from 'next/image';
import { Product } from '@/lib/types';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';

interface ProductCardProps {
  product: Product;
  onAddToBuild?: (product: Product) => void;
  showAddButton?: boolean;
}

export function ProductCard({ product, onAddToBuild, showAddButton = false }: ProductCardProps) {
  const inStock = product.stock_qty > 0;

  return (
    <Card className="group overflow-hidden hover:border-foreground/30 transition-all duration-200">
      {/* Product Image */}
      <div className="aspect-square bg-muted/50 flex items-center justify-center relative overflow-hidden">
        <div className="absolute inset-0 dot-bg opacity-50" />
        {product.image_url ? (
          <Image
            src={product.image_url}
            alt={product.name}
            fill
            className="object-contain p-4"
            sizes="(max-width: 768px) 50vw, 25vw"
          />
        ) : (
          <CategoryIcon category={product.category_slug || ''} />
        )}
        
        {/* Category badge */}
        <div className="absolute top-3 left-3">
          <Badge variant="secondary" className="font-mono text-xs">
            {product.category_slug?.toUpperCase() || 'PART'}
          </Badge>
        </div>
      </div>

      <CardContent className="p-4">
        {/* Brand & Stock */}
        <div className="flex items-center justify-between gap-2 mb-2">
          <span className="text-xs text-muted-foreground font-mono">
            {product.brand}
          </span>
          <span className={`text-xs font-mono ${inStock ? 'text-foreground' : 'text-muted-foreground'}`}>
            {inStock ? `● ${product.stock_qty} in stock` : '○ out of stock'}
          </span>
        </div>

        {/* Product Name */}
        <Link href={`/product/${product.product_id}`} className="group/link">
          <h3 className="font-medium text-sm leading-tight mb-3 group-hover/link:underline underline-offset-2 line-clamp-2">
            {product.name}
          </h3>
        </Link>

        {/* Rating */}
        <div className="flex items-center gap-2 mb-3 text-xs text-muted-foreground">
          <RatingDisplay rating={Number(product.rating)} />
          <span className="font-mono">{product.rating}/5</span>
        </div>

        {/* Price & Power */}
        <div className="flex items-end justify-between">
          <div>
            <div className="text-lg font-semibold font-mono">
              ${Number(product.price).toFixed(2)}
            </div>
            {product.power_watts > 0 && (
              <div className="text-xs text-muted-foreground font-mono">
                {product.power_watts}W TDP
              </div>
            )}
          </div>

          {showAddButton && onAddToBuild && (
            <Button
              onClick={() => onAddToBuild(product)}
              disabled={!inStock}
              variant="outline"
              size="sm"
              className="font-mono text-xs"
            >
              + add
            </Button>
          )}
        </div>
      </CardContent>
    </Card>
  );
}

function RatingDisplay({ rating }: { rating: number }) {
  const fullBlocks = Math.floor(rating);
  const emptyBlocks = 5 - fullBlocks;
  
  return (
    <span className="font-mono tracking-tight">
      {'█'.repeat(fullBlocks)}
      {'░'.repeat(emptyBlocks)}
    </span>
  );
}

export function StarRating({ rating }: { rating: number }) {
  return <RatingDisplay rating={rating} />;
}

function CategoryIcon({ category }: { category: string }) {
  const iconClass = "w-16 h-16 text-muted-foreground/30 group-hover:text-muted-foreground/50 transition-colors";
  
  const icons: Record<string, JSX.Element> = {
    cpu: (
      <svg className={iconClass} fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2zM9 9h6v6H9V9z" />
      </svg>
    ),
    gpu: (
      <svg className={iconClass} fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M9 17V7m0 10a2 2 0 01-2 2H5a2 2 0 01-2-2V7a2 2 0 012-2h2a2 2 0 012 2m0 10a2 2 0 002 2h2a2 2 0 002-2M9 7a2 2 0 012-2h2a2 2 0 012 2m0 10V7m0 10a2 2 0 002 2h2a2 2 0 002-2V7a2 2 0 00-2-2h-2a2 2 0 00-2 2" />
      </svg>
    ),
    motherboard: (
      <svg className={iconClass} fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M4 5a1 1 0 011-1h14a1 1 0 011 1v14a1 1 0 01-1 1H5a1 1 0 01-1-1V5z" />
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M8 8h3v3H8V8zm5 0h3v3h-3V8zm-5 5h3v3H8v-3zm5 0h3v3h-3v-3z" />
      </svg>
    ),
    ram: (
      <svg className={iconClass} fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
      </svg>
    ),
    storage: (
      <svg className={iconClass} fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4m0 5c0 2.21-3.582 4-8 4s-8-1.79-8-4" />
      </svg>
    ),
    psu: (
      <svg className={iconClass} fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M13 10V3L4 14h7v7l9-11h-7z" />
      </svg>
    ),
    case: (
      <svg className={iconClass} fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M5 3h14a2 2 0 012 2v14a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2z" />
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M12 8v8m-4-4h8" />
      </svg>
    ),
  };

  return icons[category] || icons.cpu;
}

export { CategoryIcon };
