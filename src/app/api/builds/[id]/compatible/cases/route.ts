import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

interface CompatibleCase extends Product {
  max_gpu_length_mm: number;
  supported_form_factor: string;
  max_psu_length_mm: number;
  drive_bays_25: number;
  drive_bays_35: number;
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
        cs.max_gpu_length_mm, cs.supported_form_factor, 
        cs.max_psu_length_mm, cs.drive_bays_25, cs.drive_bays_35,
        c.name AS category_name, c.slug AS category_slug
      FROM Product p
      JOIN CASE_Spec cs ON cs.product_id = p.product_id
      JOIN Category c ON p.category_id = c.category_id
      WHERE c.slug = 'case'
        AND p.stock_qty > 0
        AND cs.max_gpu_length_mm >= COALESCE(
          (
            SELECT g.length_mm
            FROM BuildItem bi
            JOIN GPU_Spec g ON g.product_id = bi.product_id
            WHERE bi.build_id = $1 AND bi.slot_type = 'GPU'
          ), 0
        )
        AND (
          cs.supported_form_factor = 'ATX' 
          OR cs.supported_form_factor = COALESCE(
            (
              SELECT m.form_factor
              FROM BuildItem bi
              JOIN MOBO_Spec m ON m.product_id = bi.product_id
              WHERE bi.build_id = $2 AND bi.slot_type = 'MOBO'
            ), cs.supported_form_factor
          )
          OR (
            cs.supported_form_factor = 'Micro-ATX' 
            AND COALESCE(
              (
                SELECT m.form_factor
                FROM BuildItem bi
                JOIN MOBO_Spec m ON m.product_id = bi.product_id
                WHERE bi.build_id = $3 AND bi.slot_type = 'MOBO'
              ), 'Mini-ITX'
            ) IN ('Micro-ATX', 'Mini-ITX')
          )
        )
      ORDER BY p.rating DESC, p.price ASC
    `;

    const cases = await query<CompatibleCase[]>(sql, [buildId, buildId, buildId]);

    const gpuInfo = await query<{ length_mm: number; name: string }[]>(
      `SELECT g.length_mm, p.name
       FROM BuildItem bi
       JOIN GPU_Spec g ON g.product_id = bi.product_id
       JOIN Product p ON p.product_id = bi.product_id
       WHERE bi.build_id = $1 AND bi.slot_type = 'GPU'`,
      [buildId]
    );

    const moboInfo = await query<{ form_factor: string; name: string }[]>(
      `SELECT m.form_factor, p.name
       FROM BuildItem bi
       JOIN MOBO_Spec m ON m.product_id = bi.product_id
       JOIN Product p ON p.product_id = bi.product_id
       WHERE bi.build_id = $1 AND bi.slot_type = 'MOBO'`,
      [buildId]
    );

    return NextResponse.json({
      compatible_cases: cases,
      gpu_length_mm: gpuInfo.length > 0 ? gpuInfo[0].length_mm : null,
      gpu_name: gpuInfo.length > 0 ? gpuInfo[0].name : null,
      mobo_form_factor: moboInfo.length > 0 ? moboInfo[0].form_factor : null,
      mobo_name: moboInfo.length > 0 ? moboInfo[0].name : null,
      count: cases.length,
      query_description: 'Multiple nested subqueries checking GPU length and motherboard form factor'
    });
  } catch (error) {
    console.error('Error finding compatible cases:', error);
    return NextResponse.json(
      { error: 'Failed to find compatible cases' },
      { status: 500 }
    );
  }
}
