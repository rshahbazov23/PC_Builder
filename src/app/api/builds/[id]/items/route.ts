import { NextRequest, NextResponse } from 'next/server';
import { query, execute, queryOne } from '@/lib/db';
import { SlotType, Product } from '@/lib/types';

export const dynamic = 'force-dynamic';

const VALID_SLOTS: SlotType[] = ['CPU', 'GPU', 'RAM', 'MOBO', 'PSU', 'CASE', 'STORAGE'];

const CATEGORY_TO_SLOT: Record<string, SlotType> = {
  'cpu': 'CPU',
  'gpu': 'GPU',
  'ram': 'RAM',
  'motherboard': 'MOBO',
  'psu': 'PSU',
  'case': 'CASE',
  'storage': 'STORAGE'
};

export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const buildId = parseInt(params.id);
    const body = await request.json();
    const { product_id } = body;

    if (!product_id) {
      return NextResponse.json(
        { error: 'product_id is required' },
        { status: 400 }
      );
    }

    const product = await queryOne<Product & { category_slug: string }>(
      `SELECT p.*, c.slug AS category_slug 
       FROM Product p 
       JOIN Category c ON p.category_id = c.category_id 
       WHERE p.product_id = $1`,
      [product_id]
    );

    if (!product) {
      return NextResponse.json(
        { error: 'Product not found' },
        { status: 404 }
      );
    }

    const slot_type = CATEGORY_TO_SLOT[product.category_slug];
    if (!slot_type) {
      return NextResponse.json(
        { error: 'Invalid product category' },
        { status: 400 }
      );
    }

    const existingItem = await query<{ build_item_id: number }[]>(
      'SELECT build_item_id FROM BuildItem WHERE build_id = $1 AND slot_type = $2',
      [buildId, slot_type]
    );

    if (existingItem.length > 0) {
      await execute(
        'DELETE FROM BuildItem WHERE build_id = $1 AND slot_type = $2',
        [buildId, slot_type]
      );
    }

    await execute(
      'INSERT INTO BuildItem (build_id, product_id, slot_type) VALUES ($1, $2, $3)',
      [buildId, product_id, slot_type]
    );

    await execute(
      'UPDATE Build SET updated_at = CURRENT_TIMESTAMP WHERE build_id = $1',
      [buildId]
    );

    return NextResponse.json({ 
      success: true, 
      slot_type,
      product_id,
      replaced: existingItem.length > 0
    }, { status: 201 });
  } catch (error) {
    console.error('Error adding item to build:', error);
    return NextResponse.json(
      { error: 'Failed to add item to build' },
      { status: 500 }
    );
  }
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const buildId = parseInt(params.id);
    const { searchParams } = new URL(request.url);
    const slotType = searchParams.get('slot_type') as SlotType;

    if (!slotType || !VALID_SLOTS.includes(slotType)) {
      return NextResponse.json(
        { error: 'Valid slot_type is required' },
        { status: 400 }
      );
    }

    await execute(
      'DELETE FROM BuildItem WHERE build_id = $1 AND slot_type = $2',
      [buildId, slotType]
    );

    await execute(
      'UPDATE Build SET updated_at = CURRENT_TIMESTAMP WHERE build_id = $1',
      [buildId]
    );

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error removing item from build:', error);
    return NextResponse.json(
      { error: 'Failed to remove item from build' },
      { status: 500 }
    );
  }
}
