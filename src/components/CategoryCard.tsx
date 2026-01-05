import Link from 'next/link';
import { Category } from '@/lib/types';
import { Card } from '@/components/ui/card';

interface CategoryCardProps {
  category: Category;
  productCount?: number;
}

const categoryIcons: Record<string, string> = {
  cpu: '⬡',
  gpu: '▣',
  motherboard: '⬢',
  ram: '▤',
  storage: '◉',
  psu: '⚡',
  case: '▢',
  cooler: '❄',
  monitor: '🖥️',
  keyboard: '⌨️',
  mouse: '🖱️',
  headset: '🎧',
};

export function CategoryCard({ category, productCount }: CategoryCardProps) {
  const icon = categoryIcons[category.slug] || '○';

  return (
    <Link href={`/category/${category.slug}`}>
      <Card className="p-4 text-center group hover:border-foreground/50 transition-all duration-200 cursor-pointer">
        <div className="text-3xl mb-2 group-hover:scale-110 transition-transform">
          {icon}
        </div>
        <h3 className="font-medium text-sm mb-0.5">
          {category.name.toLowerCase()}
        </h3>
        {productCount !== undefined && (
          <p className="text-xs text-muted-foreground font-mono">
            [{productCount}]
          </p>
        )}
      </Card>
    </Link>
  );
}
