import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

interface CompatibleMotherboard extends Product {
  socket: string;
  form_factor: string;
  ram_type: string;
  max_ram_gb: number;
}

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const buildId = parseInt(params.id);

    const sql = `
      SELECT 
        p.product_id, p.name, p.brand, p.model, p.price, 
        p.stock_qty, p.power_watts, p.rating, p.image_url, p.description,
        m.socket, m.form_factor, m.ram_type, m.max_ram_gb, m.ram_slots,
        c.name AS category_name, c.slug AS category_slug
      FROM Product p
      JOIN MOBO_Spec m ON m.product_id = p.product_id
      JOIN Category c ON p.category_id = c.category_id
      WHERE c.slug = 'motherboard'
        AND p.stock_qty > 0
        AND m.socket = (
          SELECT cpu_spec.socket
          FROM BuildItem bi
          JOIN CPU_Spec cpu_spec ON cpu_spec.product_id = bi.product_id
          WHERE bi.build_id = $1 AND bi.slot_type = 'CPU'
        )
      ORDER BY p.rating DESC, p.price ASC
    `;

    const motherboards = await query<CompatibleMotherboard[]>(sql, [buildId]);

    const cpuSocket = await query<{ socket: string }[]>(
      `SELECT cpu_spec.socket
       FROM BuildItem bi
       JOIN CPU_Spec cpu_spec ON cpu_spec.product_id = bi.product_id
       WHERE bi.build_id = $1 AND bi.slot_type = 'CPU'`,
      [buildId]
    );

    return NextResponse.json({
      compatible_motherboards: motherboards,
      cpu_socket: cpuSocket.length > 0 ? cpuSocket[0].socket : null,
      count: motherboards.length,
      query_description: 'Nested subquery matching CPU socket to motherboard socket'
    });
  } catch (error) {
    console.error('Error finding compatible motherboards:', error);
    return NextResponse.json(
      { error: 'Failed to find compatible motherboards' },
      { status: 500 }
    );
  }
}
