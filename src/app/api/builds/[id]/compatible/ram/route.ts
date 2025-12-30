import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

interface CompatibleRAM extends Product {
  ram_type: string;
  speed_mhz: number;
  size_gb: number;
  modules: number;
  latency: string;
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
        r.ram_type, r.speed_mhz, r.size_gb, r.modules, r.latency,
        c.name AS category_name, c.slug AS category_slug
      FROM Product p
      JOIN RAM_Spec r ON r.product_id = p.product_id
      JOIN Category c ON p.category_id = c.category_id
      WHERE c.slug = 'ram'
        AND p.stock_qty > 0
        AND r.ram_type = (
          SELECT m.ram_type
          FROM BuildItem bi
          JOIN MOBO_Spec m ON m.product_id = bi.product_id
          WHERE bi.build_id = $1 AND bi.slot_type = 'MOBO'
        )
      ORDER BY r.speed_mhz DESC, p.rating DESC, p.price ASC
    `;

    const ram = await query<CompatibleRAM[]>(sql, [buildId]);

    const moboInfo = await query<{ ram_type: string; name: string; max_ram_gb: number }[]>(
      `SELECT m.ram_type, p.name, m.max_ram_gb
       FROM BuildItem bi
       JOIN MOBO_Spec m ON m.product_id = bi.product_id
       JOIN Product p ON p.product_id = bi.product_id
       WHERE bi.build_id = $1 AND bi.slot_type = 'MOBO'`,
      [buildId]
    );

    return NextResponse.json({
      compatible_ram: ram,
      mobo_ram_type: moboInfo.length > 0 ? moboInfo[0].ram_type : null,
      mobo_name: moboInfo.length > 0 ? moboInfo[0].name : null,
      max_ram_gb: moboInfo.length > 0 ? moboInfo[0].max_ram_gb : null,
      count: ram.length
    });
  } catch (error) {
    console.error('Error finding compatible RAM:', error);
    return NextResponse.json(
      { error: 'Failed to find compatible RAM' },
      { status: 500 }
    );
  }
}
