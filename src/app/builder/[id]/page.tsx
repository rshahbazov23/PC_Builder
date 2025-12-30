'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useRouter, useParams } from 'next/navigation';
import { BuildSlot } from '@/components/BuildSlot';
import { ProductCard } from '@/components/ProductCard';
import { SlotType, Product } from '@/lib/types';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';

interface BuildItem {
  slot_type: SlotType;
  product_id: number;
  name: string;
  brand: string;
  price: number;
  power_watts: number;
}

interface Build {
  build_id: number;
  name: string;
  items: BuildItem[];
  total_price: number;
  total_watts: number;
}

type CompatibleType = 'motherboards' | 'ram' | 'cases' | 'psu';

const SLOT_ORDER: SlotType[] = ['CPU', 'MOBO', 'GPU', 'RAM', 'STORAGE', 'PSU', 'CASE'];

export default function BuildPage() {
  const params = useParams();
  const buildId = parseInt(params.id as string);
  const router = useRouter();
  
  const [build, setBuild] = useState<Build | null>(null);
  const [loading, setLoading] = useState(true);
  const [compatibleProducts, setCompatibleProducts] = useState<Product[]>([]);
  const [compatibleType, setCompatibleType] = useState<CompatibleType | null>(null);
  const [compatibleLoading, setCompatibleLoading] = useState(false);
  const [compatibleInfo, setCompatibleInfo] = useState<Record<string, unknown>>({});

  useEffect(() => {
    fetchBuild();
  }, [buildId]);

  const fetchBuild = async () => {
    try {
      const res = await fetch(`/api/builds/${buildId}`);
      if (!res.ok) throw new Error('Build not found');
      const data = await res.json();
      setBuild(data);
    } catch (error) {
      console.error('Error fetching build:', error);
      router.push('/builder');
    } finally {
      setLoading(false);
    }
  };

  const removeItem = async (slotType: SlotType) => {
    try {
      await fetch(`/api/builds/${buildId}/items?slot_type=${slotType}`, {
        method: 'DELETE',
      });
      fetchBuild();
      setCompatibleProducts([]);
      setCompatibleType(null);
    } catch (error) {
      console.error('Error removing item:', error);
    }
  };

  const addToBuild = async (product: Product) => {
    try {
      await fetch(`/api/builds/${buildId}/items`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ product_id: product.product_id }),
      });
      fetchBuild();
      setCompatibleProducts([]);
      setCompatibleType(null);
    } catch (error) {
      console.error('Error adding item:', error);
    }
  };

  const fetchCompatible = async (type: CompatibleType) => {
    setCompatibleLoading(true);
    setCompatibleType(type);
    
    try {
      let endpoint = '';
      switch (type) {
        case 'motherboards':
          endpoint = `/api/builds/${buildId}/compatible/motherboards`;
          break;
        case 'ram':
          endpoint = `/api/builds/${buildId}/compatible/ram`;
          break;
        case 'cases':
          endpoint = `/api/builds/${buildId}/compatible/cases`;
          break;
        case 'psu':
          endpoint = `/api/builds/${buildId}/recommend/psu`;
          break;
      }
      
      const res = await fetch(endpoint);
      const data = await res.json();
      
      const products = data.compatible_motherboards || data.compatible_ram || 
                      data.compatible_cases || data.recommended_psus || [];
      setCompatibleProducts(products);
      setCompatibleInfo(data);
    } catch (error) {
      console.error('Error fetching compatible products:', error);
    } finally {
      setCompatibleLoading(false);
    }
  };

  const getItemBySlot = (slotType: SlotType) => {
    return build?.items.find(item => item.slot_type === slotType);
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="font-mono text-muted-foreground">loading...</div>
      </div>
    );
  }

  if (!build) return null;

  const hasCPU = !!getItemBySlot('CPU');
  const hasMOBO = !!getItemBySlot('MOBO');
  const hasGPU = !!getItemBySlot('GPU');

  return (
    <div className="min-h-screen">
      {/* Header */}
      <div className="border-b border-border">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 py-6">
          <nav className="flex items-center gap-2 text-sm text-muted-foreground mb-4 font-mono">
            <Link href="/" className="hover:text-foreground transition-colors">~</Link>
            <span>/</span>
            <Link href="/builder" className="hover:text-foreground transition-colors">builder</Link>
            <span>/</span>
            <span className="text-foreground">{build.name}</span>
          </nav>
          <div className="flex items-center justify-between">
            <h1 className="text-2xl font-semibold">{build.name}</h1>
            <div className="flex items-center gap-6 font-mono text-sm">
              <div>
                <span className="text-muted-foreground">power: </span>
                <span>{build.total_watts}W</span>
              </div>
              <div>
                <span className="text-muted-foreground">total: </span>
                <span className="text-lg font-semibold">${Number(build.total_price).toFixed(2)}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8">
        <div className="grid lg:grid-cols-3 gap-8">
          {/* Build Slots */}
          <div className="lg:col-span-2 space-y-3">
            <h2 className="text-sm font-mono text-muted-foreground mb-4">./components</h2>
            
            {SLOT_ORDER.map((slotType) => {
              const item = getItemBySlot(slotType);
              return (
                <BuildSlot
                  key={slotType}
                  slotType={slotType}
                  product={item ? {
                    product_id: item.product_id,
                    name: item.name,
                    brand: item.brand,
                    price: item.price,
                    power_watts: item.power_watts,
                  } as Product : null}
                  onRemove={() => removeItem(slotType)}
                  onSelectProduct={addToBuild}
                  onSelectCompatible={
                    (slotType === 'CPU' && hasCPU) ? () => fetchCompatible('motherboards') :
                    (slotType === 'MOBO' && hasMOBO) ? () => fetchCompatible('ram') :
                    (slotType === 'GPU' && hasGPU && hasMOBO) ? () => fetchCompatible('cases') :
                    undefined
                  }
                />
              );
            })}
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Compatibility Tools */}
            <Card className="p-4">
              <h3 className="text-sm font-mono text-muted-foreground mb-4">./tools</h3>
              <div className="space-y-2">
                <Button
                  onClick={() => fetchCompatible('motherboards')}
                  disabled={!hasCPU}
                  variant="outline"
                  className="w-full justify-start font-mono text-xs"
                >
                  find_compatible_mobo()
                </Button>
                <Button
                  onClick={() => fetchCompatible('ram')}
                  disabled={!hasMOBO}
                  variant="outline"
                  className="w-full justify-start font-mono text-xs"
                >
                  find_compatible_ram()
                </Button>
                <Button
                  onClick={() => fetchCompatible('cases')}
                  disabled={!hasGPU || !hasMOBO}
                  variant="outline"
                  className="w-full justify-start font-mono text-xs"
                >
                  find_compatible_case()
                </Button>
                <Button
                  onClick={() => fetchCompatible('psu')}
                  disabled={build.items.length === 0}
                  variant="outline"
                  className="w-full justify-start font-mono text-xs"
                >
                  recommend_psu()
                </Button>
              </div>
            </Card>

            {/* Build Summary */}
            <Card className="p-4">
              <h3 className="text-sm font-mono text-muted-foreground mb-4">./summary</h3>
              <div className="space-y-3 text-sm font-mono">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">parts</span>
                  <span>{build.items.length}/7</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">power</span>
                  <span>{build.total_watts}W</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">min_psu</span>
                  <span>{Math.ceil(build.total_watts * 1.2)}W+</span>
                </div>
                <Separator />
                <div className="flex justify-between text-base">
                  <span className="font-semibold">total</span>
                  <span className="font-semibold">${Number(build.total_price).toFixed(2)}</span>
                </div>
              </div>
            </Card>
          </div>
        </div>

        {/* Compatible Products Panel */}
        {(compatibleProducts.length > 0 || compatibleLoading) && (
          <div className="mt-12">
            <Separator className="mb-8" />
            <div className="flex items-center justify-between mb-6">
              <div>
                <h2 className="text-xl font-semibold mb-1">
                  {compatibleType === 'motherboards' && './compatible_motherboards'}
                  {compatibleType === 'ram' && './compatible_ram'}
                  {compatibleType === 'cases' && './compatible_cases'}
                  {compatibleType === 'psu' && './recommended_psu'}
                </h2>
                <p className="text-sm text-muted-foreground font-mono">
                  {compatibleInfo.cpu_socket ? `socket: ${String(compatibleInfo.cpu_socket)}` : null}
                  {compatibleInfo.mobo_ram_type ? `type: ${String(compatibleInfo.mobo_ram_type)}` : null}
                  {compatibleInfo.gpu_length_mm ? `gpu: ${String(compatibleInfo.gpu_length_mm)}mm` : null}
                  {compatibleInfo.recommended_min_watts ? `min: ${String(compatibleInfo.recommended_min_watts)}W` : null}
                </p>
              </div>
              <Button
                variant="ghost"
                onClick={() => {
                  setCompatibleProducts([]);
                  setCompatibleType(null);
                }}
              >
                ×
              </Button>
            </div>
            
            {compatibleLoading ? (
              <div className="flex items-center justify-center py-12">
                <span className="font-mono text-muted-foreground">loading...</span>
              </div>
            ) : (
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                {compatibleProducts.map((product) => (
                  <ProductCard
                    key={product.product_id}
                    product={product}
                    showAddButton
                    onAddToBuild={addToBuild}
                  />
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
