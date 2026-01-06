import { NextRequest, NextResponse } from 'next/server';
import { query, queryOne, execute } from '@/lib/db';
import { Build, BuildItemWithProduct } from '@/lib/types';

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const buildId = parseInt(params.id);

    const build = await queryOne<Build>(
      'SELECT * FROM Build WHERE build_id = $1',
      [buildId]
    );

    if (!build) {
      return NextResponse.json(
        { error: 'Build not found' },
        { status: 404 }
      );
    }

    const items = await query<BuildItemWithProduct[]>(
      `SELECT bi.*, 
              p.product_id, p.name, p.brand, p.model, p.price, 
              p.stock_qty, p.power_watts, p.rating, p.image_url,
              c.name AS category_name, c.slug AS category_slug
       FROM BuildItem bi
       JOIN Product p ON bi.product_id = p.product_id
       JOIN Category c ON p.category_id = c.category_id
       WHERE bi.build_id = $1
       ORDER BY array_position(ARRAY['CPU', 'MOBO', 'GPU', 'RAM', 'PSU', 'CASE', 'STORAGE']::slot_type_enum[], bi.slot_type)`,
      [buildId]
    );

    const totalPrice = items.reduce((sum, item) => sum + Number(item.price), 0);
    const totalWatts = items.reduce((sum, item) => sum + Number(item.power_watts), 0);

    return NextResponse.json({
      ...build,
      items,
      total_price: totalPrice,
      total_watts: totalWatts,
      part_count: items.length
    });
  } catch (error) {
    console.error('Error fetching build:', error);
    return NextResponse.json(
      { error: 'Failed to fetch build' },
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

    await execute('DELETE FROM Build WHERE build_id = $1', [buildId]);
    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error deleting build:', error);
    return NextResponse.json(
      { error: 'Failed to delete build' },
      { status: 500 }
    );
  }
}

export async function PATCH(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const buildId = parseInt(params.id);
    const body = await request.json();
    const { name, description } = body as { name?: string; description?: string | null };

    if (!name || !name.trim()) {
      return NextResponse.json(
        { error: 'Build name is required' },
        { status: 400 }
      );
    }

    await execute(
      `UPDATE Build
       SET name = $2,
           description = $3,
           updated_at = CURRENT_TIMESTAMP
       WHERE build_id = $1`,
      [buildId, name.trim(), description ?? null]
    );

    const updated = await queryOne<Build>(
      'SELECT * FROM Build WHERE build_id = $1',
      [buildId]
    );

    return NextResponse.json(updated);
  } catch (error) {
    console.error('Error updating build:', error);
    return NextResponse.json(
      { error: 'Failed to update build' },
      { status: 500 }
    );
  }
}
