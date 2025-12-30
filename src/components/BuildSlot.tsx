'use client';

import { useState, useEffect } from 'react';
import { SlotType, Product } from '@/lib/types';
import Link from 'next/link';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';

interface BuildSlotProps {
  slotType: SlotType;
  product?: Product | null;
  onRemove?: () => void;
  onSelectCompatible?: () => void;
  onSelectProduct?: (product: Product) => void;
  isLoading?: boolean;
}

const slotConfig: Record<SlotType, { name: string; icon: string; shortName: string }> = {
  CPU: { name: 'Processor', icon: '⬡', shortName: 'cpu' },
  MOBO: { name: 'Motherboard', icon: '⬢', shortName: 'mobo' },
  GPU: { name: 'Graphics Card', icon: '▣', shortName: 'gpu' },
  RAM: { name: 'Memory', icon: '▤', shortName: 'ram' },
  PSU: { name: 'Power Supply', icon: '⚡', shortName: 'psu' },
  CASE: { name: 'Case', icon: '▢', shortName: 'case' },
  STORAGE: { name: 'Storage', icon: '◉', shortName: 'storage' },
};

const slotToCategory: Record<SlotType, string> = {
  CPU: 'cpu',
  MOBO: 'motherboard',
  GPU: 'gpu',
  RAM: 'ram',
  PSU: 'psu',
  CASE: 'case',
  STORAGE: 'storage',
};

export function BuildSlot({ slotType, product, onRemove, onSelectCompatible, onSelectProduct, isLoading }: BuildSlotProps) {
  const config = slotConfig[slotType];
  const [expanded, setExpanded] = useState(false);
  const [products, setProducts] = useState<Product[]>([]);
  const [filteredProducts, setFilteredProducts] = useState<Product[]>([]);
  const [loadingProducts, setLoadingProducts] = useState(false);
  const [search, setSearch] = useState('');

  const categorySlug = slotToCategory[slotType];

  useEffect(() => {
    if (expanded && products.length === 0) {
      fetchProducts();
    }
  }, [expanded]);

  useEffect(() => {
    if (search) {
      const searchLower = search.toLowerCase();
      setFilteredProducts(products.filter(p => 
        p.name.toLowerCase().includes(searchLower) ||
        p.brand.toLowerCase().includes(searchLower)
      ));
    } else {
      setFilteredProducts(products);
    }
  }, [products, search]);

  const fetchProducts = async () => {
    setLoadingProducts(true);
    try {
      const res = await fetch(`/api/products?category=${categorySlug}&inStock=true`);
      const data = await res.json();
      setProducts(data);
      setFilteredProducts(data);
    } catch (error) {
      console.error('Error fetching products:', error);
    } finally {
      setLoadingProducts(false);
    }
  };

  const handleSelect = (p: Product) => {
    if (onSelectProduct) {
      onSelectProduct(p);
    }
    setExpanded(false);
    setSearch('');
  };

  if (isLoading) {
    return (
      <Card className="p-4">
        <div className="flex items-center gap-4 animate-pulse">
          <div className="w-10 h-10 bg-muted rounded" />
          <div className="flex-1">
            <div className="h-4 bg-muted rounded w-24 mb-2" />
            <div className="h-3 bg-muted rounded w-48" />
          </div>
        </div>
      </Card>
    );
  }

  return (
    <Card className={`transition-all duration-200 overflow-hidden ${
      product 
        ? 'border-foreground/30 bg-muted/20' 
        : expanded 
          ? 'border-foreground/50' 
          : 'border-dashed hover:border-foreground/30'
    }`}>
      {/* Main Slot Row */}
      <div className="p-4 flex items-center gap-4">
        {/* Slot Icon */}
        <div className={`w-10 h-10 rounded flex items-center justify-center text-xl flex-shrink-0 ${
          product 
            ? 'bg-foreground text-background' 
            : 'bg-muted text-muted-foreground'
        }`}>
          {config.icon}
        </div>

        {/* Content */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-0.5">
            <span className="font-mono text-xs text-muted-foreground">
              ./{config.shortName}
            </span>
            {product && (
              <span className="text-xs text-foreground font-mono">● assigned</span>
            )}
          </div>
          
          {product ? (
            <div>
              <Link 
                href={`/product/${product.product_id}`} 
                className="text-sm font-medium hover:underline underline-offset-2 truncate block"
              >
                {product.name}
              </Link>
              <div className="flex items-center gap-3 mt-1 text-xs text-muted-foreground font-mono">
                <span>${Number(product.price).toFixed(2)}</span>
                {product.power_watts > 0 && (
                  <span>{product.power_watts}W</span>
                )}
              </div>
            </div>
          ) : (
            <p className="text-sm text-muted-foreground">
              {expanded ? `select a ${config.name.toLowerCase()}` : `no ${config.name.toLowerCase()} selected`}
            </p>
          )}
        </div>

        {/* Actions */}
        <div className="flex items-center gap-2 flex-shrink-0">
          {product ? (
            <>
              {onSelectCompatible && (slotType === 'CPU' || slotType === 'MOBO' || slotType === 'GPU') && (
                <Button
                  onClick={onSelectCompatible}
                  variant="outline"
                  size="sm"
                  className="font-mono text-xs"
                >
                  compatible()
                </Button>
              )}
              {onRemove && (
                <Button
                  onClick={onRemove}
                  variant="ghost"
                  size="sm"
                  className="text-muted-foreground hover:text-destructive"
                >
                  ×
                </Button>
              )}
            </>
          ) : (
            <Button 
              variant={expanded ? "default" : "outline"}
              size="sm" 
              className="font-mono text-xs"
              onClick={() => setExpanded(!expanded)}
            >
              {expanded ? '− close' : '+ select'}
            </Button>
          )}
        </div>
      </div>

      {/* Expanded Product List */}
      {expanded && !product && (
        <div className="border-t border-border">
          {/* Search */}
          <div className="p-3 border-b border-border bg-muted/30">
            <Input
              type="text"
              placeholder={`search ${config.name.toLowerCase()}...`}
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="font-mono text-sm h-8"
              autoFocus
            />
          </div>

          {/* Products */}
          <div className="max-h-80 overflow-y-auto">
            {loadingProducts ? (
              <div className="p-8 text-center">
                <span className="font-mono text-sm text-muted-foreground">loading...</span>
              </div>
            ) : filteredProducts.length > 0 ? (
              <div className="divide-y divide-border">
                {filteredProducts.map((p) => (
                  <button
                    key={p.product_id}
                    onClick={() => handleSelect(p)}
                    className="w-full p-3 text-left hover:bg-muted/50 transition-colors flex items-center gap-3"
                  >
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-0.5">
                        <span className="text-xs text-muted-foreground font-mono">{p.brand}</span>
                        <span className="text-xs text-muted-foreground font-mono">★ {p.rating}</span>
                      </div>
                      <p className="text-sm font-medium truncate">{p.name}</p>
                    </div>
                    <div className="text-right flex-shrink-0">
                      <div className="font-mono font-semibold text-sm">${Number(p.price).toFixed(2)}</div>
                      {p.power_watts > 0 && (
                        <div className="text-xs text-muted-foreground font-mono">{p.power_watts}W</div>
                      )}
                    </div>
                  </button>
                ))}
              </div>
            ) : (
              <div className="p-8 text-center">
                <span className="font-mono text-sm text-muted-foreground">no results</span>
              </div>
            )}
          </div>

          {/* Footer */}
          <div className="p-2 border-t border-border bg-muted/30 text-center">
            <span className="font-mono text-xs text-muted-foreground">
              {filteredProducts.length} products available
            </span>
          </div>
        </div>
      )}
    </Card>
  );
}
