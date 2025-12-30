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

    let sql = `
      SELECT 
        c.name AS category_name,
        c.slug AS category_slug,
        p.brand,
        COUNT(*) AS num_products,
        ROUND(AVG(p.rating)::numeric, 2) AS avg_rating,
        ROUND(AVG(p.price)::numeric, 2) AS avg_price,
        MIN(p.price) AS min_price,
        MAX(p.price) AS max_price,
        SUM(p.stock_qty) AS total_stock
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      WHERE p.stock_qty > 0
    `;

    const params: (string | number)[] = [];
    let paramIndex = 1;

    if (category) {
      sql += ` AND c.slug = $${paramIndex++}`;
      params.push(category);
    }

    sql += `
      GROUP BY c.category_id, c.name, c.slug, p.brand
      HAVING 
        COUNT(*) >= $${paramIndex++} 
        AND AVG(p.rating) >= $${paramIndex++}
      ORDER BY 
        c.name ASC,
        avg_rating DESC,
        num_products DESC
    `;

    params.push(parseInt(minProducts));
    params.push(parseFloat(minRating));

    const topBrands = await query<TopBrand[]>(sql, params);

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
