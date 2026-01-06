'use client';

import { useCallback, useEffect, useMemo, useState } from 'react';
import Link from 'next/link';
import { useParams, useRouter } from 'next/navigation';
import { SlotType, Product } from '@/lib/types';
import { ProductCard } from '@/components/ProductCard';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Separator } from '@/components/ui/separator';

interface BuildItem {
  slot_type: SlotType;
  product_id: number;
  name: string;
  brand: string;
  model: string | null;
  price: number;
  power_watts: number;
  stock_qty: number;
  rating: number;
  category_slug?: string;
}

interface Build {
  build_id: number;
  name: string;
  description: string | null;
  items: BuildItem[];
  total_price: number;
  total_watts: number;
  part_count: number;
}

type StepId = SlotType | 'SUMMARY';
type ViewMode = 'all' | 'smart';

const STEPS: { id: StepId; label: string; help: string }[] = [
  { id: 'CPU', label: 'cpu', help: 'Pick your processor first.' },
  { id: 'MOBO', label: 'motherboard', help: 'Optionally switch to compatible mode (CPU socket).' },
  { id: 'GPU', label: 'gpu', help: 'Choose a graphics card (or skip for iGPU builds).' },
  { id: 'RAM', label: 'ram', help: 'Optionally switch to compatible mode (DDR type).' },
  { id: 'STORAGE', label: 'storage', help: 'Pick an SSD/HDD for your system.' },
  { id: 'PSU', label: 'psu', help: 'Optionally switch to recommended mode (power headroom).' },
  { id: 'CASE', label: 'case', help: 'Optionally switch to compatible mode (GPU length + form factor).' },
  { id: 'SUMMARY', label: 'summary', help: 'Review, rename, and finish.' },
];

const SLOT_TO_CATEGORY: Record<SlotType, string> = {
  CPU: 'cpu',
  MOBO: 'motherboard',
  GPU: 'gpu',
  RAM: 'ram',
  STORAGE: 'storage',
  PSU: 'psu',
  CASE: 'case',
};

const SMART_ENDPOINT: Partial<Record<SlotType, string>> = {
  MOBO: 'compatible/motherboards',
  RAM: 'compatible/ram',
  CASE: 'compatible/cases',
  PSU: 'recommend/psu',
};

function stepTitle(step: StepId): string {
  if (step === 'CPU') return './cpu';
  if (step === 'MOBO') return './motherboard';
  if (step === 'GPU') return './gpu';
  if (step === 'RAM') return './ram';
  if (step === 'STORAGE') return './storage';
  if (step === 'PSU') return './psu';
  if (step === 'CASE') return './case';
  return './summary';
}

function smartLabel(step: SlotType): string {
  if (step === 'MOBO') return 'show_compatible()';
  if (step === 'RAM') return 'show_compatible()';
  if (step === 'CASE') return 'show_compatible()';
  if (step === 'PSU') return 'recommend_psu()';
  return 'show_smart()';
}

export default function BuildPage() {
  const params = useParams();
  const buildId = parseInt(params.id as string, 10);
  const router = useRouter();
  
  const [build, setBuild] = useState<Build | null>(null);
  const [loadingBuild, setLoadingBuild] = useState(true);

  const [activeStepIndex, setActiveStepIndex] = useState(0);
  const activeStep = STEPS[activeStepIndex]?.id ?? 'CPU';

  const [viewMode, setViewMode] = useState<Partial<Record<SlotType, ViewMode>>>({});
  const [search, setSearch] = useState<Partial<Record<SlotType, string>>>({});

  const [allProducts, setAllProducts] = useState<Partial<Record<SlotType, Product[]>>>({});
  const [smartProducts, setSmartProducts] = useState<Partial<Record<SlotType, Product[]>>>({});
  const [smartInfo, setSmartInfo] = useState<Partial<Record<SlotType, Record<string, unknown>>>>({});

  const [loadingProductsKey, setLoadingProductsKey] = useState<string | null>(null);

  const [draftName, setDraftName] = useState('');
  const [draftDescription, setDraftDescription] = useState('');
  const [savingBuild, setSavingBuild] = useState(false);

  const fetchBuild = useCallback(async () => {
    try {
      const res = await fetch(`/api/builds/${buildId}`, { cache: 'no-store' });
      if (!res.ok) throw new Error('Build not found');
      const data = (await res.json()) as Build;
      setBuild(data);
      setDraftName(data.name || '');
      setDraftDescription(data.description || '');
    } catch (error) {
      console.error('Error fetching build:', error);
      router.push('/builder');
    } finally {
      setLoadingBuild(false);
    }
  }, [buildId, router]);

  useEffect(() => {
    fetchBuild();
  }, [fetchBuild]);

  const getItemBySlot = useCallback(
    (slotType: SlotType) => build?.items.find(i => i.slot_type === slotType),
    [build]
  );

  const prerequisites = useMemo(() => {
    return {
      MOBO: { ok: !!getItemBySlot('CPU'), reason: 'Pick a CPU first to match socket.' },
      RAM: { ok: !!getItemBySlot('MOBO'), reason: 'Pick a motherboard first to match RAM type.' },
      CASE: { ok: !!getItemBySlot('GPU') && !!getItemBySlot('MOBO'), reason: 'Pick GPU + motherboard first.' },
      PSU: { ok: (build?.items.length || 0) > 0, reason: 'Add at least one part first.' },
    } satisfies Partial<Record<SlotType, { ok: boolean; reason: string }>>;
  }, [build, getItemBySlot]);

  const ensureAllForSlot = useCallback(
    async (slotType: SlotType) => {
      if (allProducts[slotType]) return;

      setLoadingProductsKey(`${slotType}:all`);
      try {
        const category = SLOT_TO_CATEGORY[slotType];
        const res = await fetch(`/api/products?category=${encodeURIComponent(category)}&limit=200&sort=rating_desc`, {
          cache: 'no-store',
        });
        if (!res.ok) throw new Error('Failed to load products');
        const data = (await res.json()) as Product[];
        setAllProducts(prev => ({ ...prev, [slotType]: data }));
      } catch (error) {
        console.error('Error fetching products:', error);
        setAllProducts(prev => ({ ...prev, [slotType]: [] }));
      } finally {
        setLoadingProductsKey(null);
      }
    },
    [allProducts]
  );

  const fetchSmartForSlot = useCallback(
    async (slotType: SlotType) => {
      const endpoint = SMART_ENDPOINT[slotType];
      if (!endpoint) return;

      setLoadingProductsKey(`${slotType}:smart`);
      try {
        const res = await fetch(`/api/builds/${buildId}/${endpoint}`, { cache: 'no-store' });
        const data = await res.json();

        const products: Product[] =
          data.compatible_motherboards ||
          data.compatible_ram ||
          data.compatible_cases ||
          data.recommended_psus ||
          [];

        setSmartProducts(prev => ({ ...prev, [slotType]: products }));
        setSmartInfo(prev => ({ ...prev, [slotType]: data }));
    } catch (error) {
        console.error('Error fetching smart products:', error);
        setSmartProducts(prev => ({ ...prev, [slotType]: [] }));
        setSmartInfo(prev => ({ ...prev, [slotType]: {} }));
      } finally {
        setLoadingProductsKey(null);
      }
    },
    [buildId]
  );

  // Prefetch the “all products” list for the current slot step
  useEffect(() => {
    if (!build) return;
    if (activeStep === 'SUMMARY') return;
    const slot = activeStep as SlotType;
    void ensureAllForSlot(slot);
  }, [activeStep, build, ensureAllForSlot]);

  const addToBuild = useCallback(
    async (product: Product) => {
    try {
      await fetch(`/api/builds/${buildId}/items`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ product_id: product.product_id }),
      });

        // Smart results depend on build contents; clear cache so next “smart” fetch is accurate
        setSmartProducts({});
        setSmartInfo({});

        await fetchBuild();
    } catch (error) {
        console.error('Error adding item to build:', error);
      }
    },
    [buildId, fetchBuild]
  );

  const removeFromBuild = useCallback(
    async (slotType: SlotType) => {
      try {
        await fetch(`/api/builds/${buildId}/items?slot_type=${slotType}`, { method: 'DELETE' });

        setSmartProducts({});
        setSmartInfo({});

        await fetchBuild();
      } catch (error) {
        console.error('Error removing item from build:', error);
      }
    },
    [buildId, fetchBuild]
  );

  const goToSlot = useCallback((slot: StepId) => {
    const idx = STEPS.findIndex(s => s.id === slot);
    if (idx >= 0) setActiveStepIndex(idx);
  }, []);

  const goNext = useCallback(() => {
    setActiveStepIndex(i => Math.min(i + 1, STEPS.length - 1));
  }, []);

  const goBack = useCallback(() => {
    setActiveStepIndex(i => Math.max(i - 1, 0));
  }, []);

  const saveBuildAndExit = useCallback(async () => {
    setSavingBuild(true);
    try {
      const res = await fetch(`/api/builds/${buildId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          name: draftName.trim() || `Build #${buildId}`,
          description: draftDescription.trim() || null,
        }),
      });
      if (!res.ok) throw new Error('Failed to save build');
      router.push('/builder');
    } catch (error) {
      console.error('Error saving build:', error);
      // fall back to just exit
      router.push('/builder');
    } finally {
      setSavingBuild(false);
    }
  }, [buildId, draftDescription, draftName, router]);

  const currentSlot = activeStep === 'SUMMARY' ? null : (activeStep as SlotType);
  const currentMode = currentSlot ? (viewMode[currentSlot] ?? 'all') : 'all';
  const currentSearch = currentSlot ? (search[currentSlot] ?? '') : '';

  const displayedProducts = useMemo(() => {
    if (!currentSlot) return [];

    const base =
      currentMode === 'smart'
        ? (smartProducts[currentSlot] ?? [])
        : (allProducts[currentSlot] ?? []);

    if (!currentSearch.trim()) return base;
    const q = currentSearch.trim().toLowerCase();
    return base.filter(p =>
      p.name.toLowerCase().includes(q) ||
      p.brand.toLowerCase().includes(q) ||
      (p.model || '').toLowerCase().includes(q)
    );
  }, [allProducts, currentMode, currentSearch, currentSlot, smartProducts]);

  const smartMetaLine = useMemo(() => {
    if (!currentSlot) return null;
    const info = smartInfo[currentSlot];
    if (!info) return null;
    if (currentSlot === 'MOBO' && info.cpu_socket) return `socket: ${String(info.cpu_socket)}`;
    if (currentSlot === 'RAM' && info.mobo_ram_type) return `type: ${String(info.mobo_ram_type)}`;
    if (currentSlot === 'CASE' && info.gpu_length_mm) return `gpu: ${String(info.gpu_length_mm)}mm`;
    if (currentSlot === 'PSU' && info.recommended_min_watts) return `min: ${String(info.recommended_min_watts)}W`;
    return null;
  }, [currentSlot, smartInfo]);

  const partsFilled = build?.items.length ?? 0;

  if (loadingBuild) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="font-mono text-muted-foreground">loading...</div>
      </div>
    );
  }

  if (!build) return null;

  return (
    <div className="min-h-screen">
      {/* Header */}
      <div className="border-b border-border">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 py-6">
          <nav className="flex items-center gap-2 text-sm text-muted-foreground mb-4 font-mono">
            <Link href="/" className="hover:text-foreground transition-colors">~</Link>
            <span>/</span>
            <Link href="/builder" className="hover:text-foreground transition-colors">builds</Link>
            <span>/</span>
            <span className="text-foreground">{build.name}</span>
          </nav>

          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
            <div>
            <h1 className="text-2xl font-semibold">{build.name}</h1>
              <p className="text-sm text-muted-foreground font-mono mt-1">
                {stepTitle(activeStep)} • step {activeStepIndex + 1}/{STEPS.length}
              </p>
            </div>

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

          {/* Stepper */}
          <div className="mt-6 overflow-x-auto">
            <div className="inline-flex items-center gap-2">
              {STEPS.map((s, idx) => {
                const active = idx === activeStepIndex;
                const done = idx < activeStepIndex;
                return (
                  <button
                    key={s.id}
                    onClick={() => goToSlot(s.id)}
                    className={`px-3 py-1.5 border font-mono text-xs whitespace-nowrap transition-colors ${
                      active
                        ? 'border-foreground bg-foreground text-background'
                        : done
                          ? 'border-border hover:border-foreground/50'
                          : 'border-border hover:border-foreground/50 text-muted-foreground'
                    }`}
                  >
                    {done ? '✓ ' : ''}
                    {s.label}
                  </button>
                );
              })}
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8">
        <div className="grid lg:grid-cols-3 gap-8">
          {/* Wizard (carousel) */}
          <div className="lg:col-span-2">
            <div className="overflow-hidden border border-border bg-background">
              <div
                className="flex transition-transform duration-500 ease-out"
                style={{ transform: `translateX(-${activeStepIndex * 100}%)` }}
              >
                {STEPS.map((step) => {
                  if (step.id === 'SUMMARY') {
                    return (
                      <div key={step.id} className="w-full flex-shrink-0 p-6">
                        <h2 className="text-xl font-semibold mb-2">{stepTitle(step.id)}</h2>
                        <p className="text-sm text-muted-foreground font-mono mb-6">
                          Review your build, adjust any step, then finish.
                        </p>

                        <div className="grid sm:grid-cols-2 gap-4 mb-6">
                          <div>
                            <label className="block text-xs font-mono text-muted-foreground mb-2">
                              build_name
                            </label>
                            <Input
                              value={draftName}
                              onChange={(e) => setDraftName(e.target.value)}
                              placeholder="My build"
                            />
                          </div>
                          <div>
                            <label className="block text-xs font-mono text-muted-foreground mb-2">
                              description
                            </label>
                            <Input
                              value={draftDescription}
                              onChange={(e) => setDraftDescription(e.target.value)}
                              placeholder="(optional)"
                            />
                          </div>
                        </div>

                        <Separator className="mb-6" />

                        <div className="space-y-3">
                          {(Object.keys(SLOT_TO_CATEGORY) as SlotType[]).map((slot) => {
                            const item = getItemBySlot(slot);
              return (
                              <div key={slot} className="flex items-center justify-between gap-4 border border-border p-4">
                                <div className="min-w-0">
                                  <div className="text-xs font-mono text-muted-foreground mb-1">./{slot.toLowerCase()}</div>
                                  {item ? (
                                    <div className="truncate">
                                      <span className="font-medium">{item.name}</span>
                                      <span className="text-muted-foreground"> • {item.brand}</span>
                                    </div>
                                  ) : (
                                    <div className="text-muted-foreground">not selected</div>
                                  )}
                                </div>
                                <div className="flex items-center gap-2 flex-shrink-0">
                                  {item && (
                                    <Button
                                      variant="outline"
                                      className="font-mono text-xs"
                                      onClick={() => removeFromBuild(slot)}
                                    >
                                      remove()
                                    </Button>
                                  )}
                                  <Button
                                    className="font-mono text-xs"
                                    onClick={() => goToSlot(slot)}
                                  >
                                    edit()
                                  </Button>
                                </div>
                              </div>
              );
            })}
          </div>

                        <Separator className="my-6" />

                        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                          <div className="font-mono text-sm">
                            <span className="text-muted-foreground">parts:</span> {partsFilled}/7{' '}
                            <span className="text-muted-foreground ml-4">min_psu:</span> {Math.ceil(build.total_watts * 1.2)}W+
                          </div>

                <Button
                            onClick={saveBuildAndExit}
                            disabled={savingBuild}
                            className="font-mono"
                          >
                            {savingBuild ? 'saving...' : 'save_and_exit()'}
                </Button>
                        </div>
                      </div>
                    );
                  }

                  const slot = step.id as SlotType;
                  const slotCategory = SLOT_TO_CATEGORY[slot];
                  const supportsSmart = !!SMART_ENDPOINT[slot];
                  const prereq = prerequisites[slot];
                  const mode = viewMode[slot] ?? 'all';
                  const s = search[slot] ?? '';
                  const isLoading =
                    loadingProductsKey === `${slot}:all` ||
                    loadingProductsKey === `${slot}:smart`;

                  const selected = getItemBySlot(slot);

                  return (
                    <div key={step.id} className="w-full flex-shrink-0 p-6">
                      <div className="flex items-start justify-between gap-4 mb-4">
                        <div>
                          <h2 className="text-xl font-semibold mb-1">{stepTitle(step.id)}</h2>
                          <p className="text-sm text-muted-foreground font-mono">{step.help}</p>
                        </div>

                        <div className="text-right">
                          <div className="text-xs font-mono text-muted-foreground">selected</div>
                          <div className="text-sm font-mono">
                            {selected ? '●' : '○'} {selected ? selected.name : 'none'}
                          </div>
                        </div>
                      </div>

                      <div className="flex flex-col sm:flex-row sm:items-center gap-3 mb-4">
                        <Input
                          value={s}
                          onChange={(e) => setSearch(prev => ({ ...prev, [slot]: e.target.value }))}
                          placeholder="search..."
                          className="sm:max-w-xs"
                        />

                        <div className="flex items-center gap-2">
                <Button
                            variant={mode === 'all' ? 'default' : 'outline'}
                            className="font-mono text-xs"
                            onClick={() => {
                              setViewMode(prev => ({ ...prev, [slot]: 'all' }));
                              void ensureAllForSlot(slot);
                            }}
                          >
                            show_all()
                </Button>

                          {supportsSmart && (
                <Button
                              variant={mode === 'smart' ? 'default' : 'outline'}
                              className="font-mono text-xs"
                              disabled={!!prereq && !prereq.ok}
                              onClick={() => {
                                setViewMode(prev => ({ ...prev, [slot]: 'smart' }));
                                void fetchSmartForSlot(slot);
                              }}
                              title={prereq && !prereq.ok ? prereq.reason : undefined}
                            >
                              {smartLabel(slot)}
                </Button>
                          )}

                          {selected && (
                <Button
                              variant="ghost"
                              className="font-mono text-xs"
                              onClick={() => removeFromBuild(slot)}
                            >
                              remove()
                            </Button>
                          )}
                        </div>
                      </div>

                      {mode === 'smart' && prereq && !prereq.ok && (
                        <Card className="p-4 mb-4 border-dashed">
                          <div className="text-sm text-muted-foreground font-mono">
                            {prereq.reason}
                          </div>
                        </Card>
                      )}

                      {mode === 'smart' && smartMetaLine && (
                        <div className="mb-4 text-xs font-mono text-muted-foreground">
                          {smartMetaLine}
                        </div>
                      )}

                      <div className="border border-border bg-muted/20 p-3 mb-4 text-xs font-mono">
                        <span className="text-muted-foreground">source:</span>{' '}
                        {mode === 'smart'
                          ? `build/${buildId}/${SMART_ENDPOINT[slot]}`
                          : `/api/products?category=${slotCategory}`}
                        <span className="text-muted-foreground ml-3">results:</span>{' '}
                        <span className="text-foreground">{displayedProducts.length}</span>
                      </div>

                      {isLoading ? (
                        <div className="flex items-center justify-center py-12">
                          <span className="font-mono text-muted-foreground">loading...</span>
                        </div>
                      ) : displayedProducts.length > 0 ? (
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                          {displayedProducts.map((p) => (
                            <div key={p.product_id} className="relative">
                              {selected?.product_id === p.product_id && (
                                <div className="absolute top-2 right-2 z-10 bg-foreground text-background text-xs font-mono px-2 py-1">
                                  selected
                                </div>
                              )}
                              <ProductCard product={p} showAddButton onAddToBuild={addToBuild} />
                            </div>
                          ))}
                        </div>
                      ) : (
                        <Card className="p-12 text-center">
                          <div className="text-4xl mb-4">∅</div>
                          <h3 className="font-semibold mb-2">no results</h3>
                          <p className="text-sm text-muted-foreground font-mono">
                            {mode === 'smart'
                              ? 'Try a different selection in previous steps, or switch to show_all().'
                              : 'Try adjusting your search.'}
                          </p>
                        </Card>
                      )}

                      <Separator className="my-6" />

                      <div className="flex items-center justify-between gap-4">
                        <Button variant="outline" className="font-mono" onClick={goBack} disabled={activeStepIndex === 0}>
                          ← back
                        </Button>

                        <div className="text-xs text-muted-foreground font-mono">
                          tip: you can jump steps using the top bar
                        </div>

                        <Button className="font-mono" onClick={goNext}>
                          next →
                </Button>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          </div>

          {/* Side summary (always visible) */}
          <div className="space-y-6">
            <Card className="p-4">
              <h3 className="text-sm font-mono text-muted-foreground mb-4">./current_build</h3>
              <div className="space-y-3 text-sm font-mono">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">parts</span>
                  <span>{partsFilled}/7</span>
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

            <Card className="p-4">
              <h3 className="text-sm font-mono text-muted-foreground mb-4">./jump_to</h3>
              <div className="grid grid-cols-2 gap-2">
                {(Object.keys(SLOT_TO_CATEGORY) as SlotType[]).map((slot) => (
              <Button
                    key={slot}
                    variant="outline"
                    className="font-mono text-xs justify-start"
                    onClick={() => goToSlot(slot)}
                  >
                    {getItemBySlot(slot) ? '● ' : '○ '}
                    {slot.toLowerCase()}
              </Button>
                ))}
                <Button
                  variant={activeStep === 'SUMMARY' ? 'default' : 'outline'}
                  className="font-mono text-xs justify-start col-span-2"
                  onClick={() => goToSlot('SUMMARY')}
                >
                  summary →
                </Button>
              </div>
            </Card>

            <Card className="p-4">
              <h3 className="text-sm font-mono text-muted-foreground mb-4">./saved_builds</h3>
              <p className="text-sm text-muted-foreground mb-3">
                You can access all builds on the builds page.
              </p>
              <Link href="/builder" className="block">
                <Button variant="outline" className="w-full font-mono">
                  open_builds()
                </Button>
              </Link>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
}
