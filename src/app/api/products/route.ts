/**
 * GET /api/products
 * Returns products with optional filters (category, brand, price range, stock)
 */

import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const category = searchParams.get('category');
    const brand = searchParams.get('brand');
    const minPrice = searchParams.get('minPrice');
    const maxPrice = searchParams.get('maxPrice');
    const inStock = searchParams.get('inStock');
    const limit = searchParams.get('limit');

    // Build dynamic query with filters
    let sql = `
      SELECT p.*, c.name AS category_name, c.slug AS category_slug
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      WHERE 1=1
    `;
    const params: (string | number)[] = [];

    if (category) {
      sql += ' AND c.slug = ?';
      params.push(category);
    }

    if (brand) {
      sql += ' AND p.brand = ?';
      params.push(brand);
    }

    if (minPrice) {
      sql += ' AND p.price >= ?';
      params.push(parseFloat(minPrice));
    }

    if (maxPrice) {
      sql += ' AND p.price <= ?';
      params.push(parseFloat(maxPrice));
    }

    if (inStock === 'true') {
      sql += ' AND p.stock_qty > 0';
    }

    sql += ' ORDER BY p.rating DESC, p.name';

    if (limit) {
      sql += ' LIMIT ?';
      params.push(parseInt(limit));
    }

    const products = await query<Product[]>(sql, params);
    return NextResponse.json(products);
  } catch (error) {
    console.error('Error fetching products:', error);
    return NextResponse.json(
      { error: 'Failed to fetch products' },
      { status: 500 }
    );
  }
}


