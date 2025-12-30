/**
 * GET /api/deals
 * 
 * ADVANCED SQL QUERY #4: Deals (Nested Aggregate / Correlated Subquery)
 * 
 * This query finds products that are priced BELOW their category's average price.
 * These are "deals" - products that offer good value compared to similar items.
 * 
 * Uses:
 * - Correlated subquery (references outer query's category_id)
 * - AVG aggregate function in subquery
 * - Comparison between current price and category average
 * - Calculated field showing savings amount
 * 
 * This is a classic "products below category average" query pattern.
 */

import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

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

    /**
     * ADVANCED QUERY #4: Products Priced Below Category Average
     * 
     * Uses a correlated subquery where the inner query references
     * the outer query's category_id to calculate category-specific average.
     * 
     * The query returns products with their:
     * - Category average price (calculated via correlated subquery)
     * - Savings amount (avg - current price)
     * - Savings percentage
     */
    let sql = `
      SELECT 
        p.product_id, p.name, p.brand, p.model, p.price, 
        p.stock_qty, p.power_watts, p.rating, p.image_url, p.description,
        c.name AS category_name, c.slug AS category_slug,
        /* Correlated subquery: Calculate average price for THIS product's category */
        (
          SELECT AVG(p2.price)
          FROM Product p2
          WHERE p2.category_id = p.category_id
        ) AS category_avg_price,
        /* Calculate savings: how much below average this product is */
        (
          (
            SELECT AVG(p2.price)
            FROM Product p2
            WHERE p2.category_id = p.category_id
          ) - p.price
        ) AS savings_amount,
        /* Calculate savings percentage */
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
          ), 1
        ) AS savings_percentage
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      WHERE p.stock_qty > 0
        /* Only show products BELOW their category average */
        AND p.price < (
          SELECT AVG(p2.price)
          FROM Product p2
          WHERE p2.category_id = p.category_id
        )
    `;

    const params: (string | number)[] = [];

    if (category) {
      sql += ' AND c.slug = ?';
      params.push(category);
    }

    // Order by savings percentage (best deals first)
    sql += `
      ORDER BY savings_percentage DESC, p.rating DESC
      LIMIT ?
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


