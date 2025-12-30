/**
 * GET /api/top-brands
 * 
 * ADVANCED SQL QUERY #5: Top Brands (GROUP BY + HAVING)
 * 
 * This query identifies the top brands in each category based on:
 * - Having at least N products (variety)
 * - Having an average rating above a threshold (quality)
 * 
 * Uses:
 * - GROUP BY with multiple columns
 * - HAVING clause with multiple conditions
 * - COUNT and AVG aggregate functions
 * - Filtering on aggregated values
 * 
 * This is a classic "find groups meeting criteria" pattern.
 */

import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

interface TopBrand {
  category_name: string;
  category_slug: string;
  brand: string;
  num_products: number;
  avg_rating: number;
  avg_price: number;
  min_price: number;
  max_price: number;
  total_stock: number;
}

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const minProducts = searchParams.get('minProducts') || '3';
    const minRating = searchParams.get('minRating') || '4.0';
    const category = searchParams.get('category');

    /**
     * ADVANCED QUERY #5: Top Brands per Category
     * 
     * Uses GROUP BY to aggregate products by category and brand,
     * then HAVING to filter groups that meet our quality criteria:
     * - Minimum number of products (brand has variety)
     * - Minimum average rating (brand has quality)
     * 
     * Returns detailed statistics for each qualifying brand.
     */
    let sql = `
      SELECT 
        c.name AS category_name,
        c.slug AS category_slug,
        p.brand,
        /* Aggregate functions over the group */
        COUNT(*) AS num_products,
        ROUND(AVG(p.rating), 2) AS avg_rating,
        ROUND(AVG(p.price), 2) AS avg_price,
        MIN(p.price) AS min_price,
        MAX(p.price) AS max_price,
        SUM(p.stock_qty) AS total_stock
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      WHERE p.stock_qty > 0
    `;

    const params: (string | number)[] = [];

    if (category) {
      sql += ' AND c.slug = ?';
      params.push(category);
    }

    sql += `
      /* GROUP BY category and brand to aggregate per brand per category */
      GROUP BY c.category_id, c.name, c.slug, p.brand
      
      /* HAVING filters groups after aggregation */
      /* Only include brands with enough products AND good ratings */
      HAVING 
        COUNT(*) >= ? 
        AND AVG(p.rating) >= ?
      
      ORDER BY 
        c.name ASC,
        avg_rating DESC,
        num_products DESC
    `;

    params.push(parseInt(minProducts));
    params.push(parseFloat(minRating));

    const topBrands = await query<TopBrand[]>(sql, params);

    // Group by category for easier frontend consumption
    const byCategory: Record<string, TopBrand[]> = {};
    for (const brand of topBrands) {
      if (!byCategory[brand.category_name]) {
        byCategory[brand.category_name] = [];
      }
      byCategory[brand.category_name].push(brand);
    }

    return NextResponse.json({
      top_brands: topBrands,
      by_category: byCategory,
      count: topBrands.length,
      filters: {
        min_products: parseInt(minProducts),
        min_rating: parseFloat(minRating),
        category: category || 'all'
      },
      query_description: 'GROUP BY category and brand with HAVING clause for COUNT and AVG filters'
    });
  } catch (error) {
    console.error('Error fetching top brands:', error);
    return NextResponse.json(
      { error: 'Failed to fetch top brands' },
      { status: 500 }
    );
  }
}


