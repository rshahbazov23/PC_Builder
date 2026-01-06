import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

export const dynamic = 'force-dynamic';

interface DealProduct extends Product {
  category_name: string;
  category_avg_price: number;
  savings_amount: number;
  savings_percentage: number;
}

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const limit = searchParams.get('limit') || '20';
    const category = searchParams.get('category');

    let sql = `
      SELECT 
        p.product_id, p.name, p.brand, p.model, p.price, 
        p.stock_qty, p.power_watts, p.rating, p.image_url, p.description,
        c.name AS category_name, c.slug AS category_slug,
        (
          SELECT AVG(p2.price)
          FROM Product p2
          WHERE p2.category_id = p.category_id
        ) AS category_avg_price,
        (
          (
            SELECT AVG(p2.price)
            FROM Product p2
            WHERE p2.category_id = p.category_id
          ) - p.price
        ) AS savings_amount,
        ROUND(
          (
            (
              (
                SELECT AVG(p2.price)
                FROM Product p2
                WHERE p2.category_id = p.category_id
              ) - p.price
            ) / (
              SELECT AVG(p2.price)
              FROM Product p2
              WHERE p2.category_id = p.category_id
            ) * 100
          )::numeric, 1
        ) AS savings_percentage
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      WHERE p.stock_qty > 0
        AND p.price < (
          SELECT AVG(p2.price)
          FROM Product p2
          WHERE p2.category_id = p.category_id
        )
    `;

    const params: (string | number)[] = [];
    let paramIndex = 1;

    if (category) {
      sql += ` AND c.slug = $${paramIndex++}`;
      params.push(category);
    }

    sql += `
      ORDER BY savings_percentage DESC, p.rating DESC
      LIMIT $${paramIndex++}
    `;
    params.push(parseInt(limit));

    const deals = await query<DealProduct[]>(sql, params);

    return NextResponse.json({
      deals,
      count: deals.length,
      query_description: 'Correlated subquery comparing product price to category average'
    });
  } catch (error) {
    console.error('Error fetching deals:', error);
    return NextResponse.json(
      { error: 'Failed to fetch deals' },
      { status: 500 }
    );
  }
}
