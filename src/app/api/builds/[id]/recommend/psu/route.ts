import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

interface RecommendedPSU extends Product {
  wattage: number;
  efficiency_rating: string;
  modular: string;
  psu_length_mm: number;
  headroom_watts: number;
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
        ps.wattage, ps.efficiency_rating, ps.modular, ps.psu_length_mm,
        c.name AS category_name, c.slug AS category_slug,
        (ps.wattage - CEIL(1.2 * (
          SELECT COALESCE(SUM(pr.power_watts), 0)
          FROM BuildItem bi
          JOIN Product pr ON pr.product_id = bi.product_id
          WHERE bi.build_id = $1
        ))) AS headroom_watts
      FROM Product p
      JOIN PSU_Spec ps ON ps.product_id = p.product_id
      JOIN Category c ON p.category_id = c.category_id
      WHERE c.slug = 'psu'
        AND p.stock_qty > 0
        AND ps.wattage >= CEIL(1.2 * (
          SELECT COALESCE(SUM(pr.power_watts), 0)
          FROM BuildItem bi
          JOIN Product pr ON pr.product_id = bi.product_id
          WHERE bi.build_id = $2
        ))
      ORDER BY 
        ps.wattage ASC, 
        p.rating DESC,
        p.price ASC
    `;

    const psus = await query<RecommendedPSU>(sql, [buildId, buildId]);

    const powerInfo = await query<{ total_watts: number; part_count: number }>(
      `SELECT 
        COALESCE(SUM(p.power_watts), 0) AS total_watts,
        COUNT(*) AS part_count
       FROM BuildItem bi
       JOIN Product p ON p.product_id = bi.product_id
       WHERE bi.build_id = $1`,
      [buildId]
    );

    const totalWatts = powerInfo.length > 0 ? Number(powerInfo[0].total_watts) : 0;
    const recommendedMinWatts = Math.ceil(1.2 * totalWatts);

    return NextResponse.json({
      recommended_psus: psus,
      build_total_watts: totalWatts,
      recommended_min_watts: recommendedMinWatts,
      headroom_percentage: 20,
      part_count: powerInfo.length > 0 ? powerInfo[0].part_count : 0,
      count: psus.length,
      query_description: 'Aggregate SUM with 1.2x multiplier in nested subquery'
    });
  } catch (error) {
    console.error('Error recommending PSUs:', error);
    return NextResponse.json(
      { error: 'Failed to recommend PSUs' },
      { status: 500 }
    );
  }
}
