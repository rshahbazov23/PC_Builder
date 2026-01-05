import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const category = searchParams.get('category');
    const brand = searchParams.get('brand');
    const q = searchParams.get('q');
    const minPrice = searchParams.get('minPrice');
    const maxPrice = searchParams.get('maxPrice');
    const minRating = searchParams.get('minRating');
    const inStock = searchParams.get('inStock');
    const sort = searchParams.get('sort');
    const limitRaw = searchParams.get('limit');
    const offsetRaw = searchParams.get('offset');

    let sql = `
      SELECT p.*, c.name AS category_name, c.slug AS category_slug
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      WHERE 1=1
    `;
    const params: (string | number)[] = [];
    let paramIndex = 1;

    if (category) {
      sql += ` AND c.slug = $${paramIndex++}`;
      params.push(category);
    }

    if (brand) {
      sql += ` AND p.brand = $${paramIndex++}`;
      params.push(brand);
    }

    if (q && q.trim()) {
      sql += ` AND (
        p.name ILIKE $${paramIndex}
        OR p.brand ILIKE $${paramIndex}
        OR COALESCE(p.model, '') ILIKE $${paramIndex}
        OR COALESCE(p.description, '') ILIKE $${paramIndex}
      )`;
      params.push(`%${q.trim()}%`);
      paramIndex++;
    }

    if (minPrice) {
      sql += ` AND p.price >= $${paramIndex++}`;
      params.push(parseFloat(minPrice));
    }

    if (maxPrice) {
      sql += ` AND p.price <= $${paramIndex++}`;
      params.push(parseFloat(maxPrice));
    }

    if (minRating) {
      sql += ` AND p.rating >= $${paramIndex++}`;
      params.push(parseFloat(minRating));
    }

    if (inStock === 'true') {
      sql += ' AND p.stock_qty > 0';
    }

    // Safe sort mapping (avoid injecting arbitrary ORDER BY)
    switch (sort) {
      case 'price_asc':
        sql += ' ORDER BY p.price ASC, p.rating DESC, p.name ASC';
        break;
      case 'price_desc':
        sql += ' ORDER BY p.price DESC, p.rating DESC, p.name ASC';
        break;
      case 'name_asc':
        sql += ' ORDER BY p.name ASC, p.rating DESC';
        break;
      case 'newest':
        sql += ' ORDER BY p.created_at DESC, p.rating DESC';
        break;
      case 'stock_desc':
        sql += ' ORDER BY p.stock_qty DESC, p.rating DESC, p.name ASC';
        break;
      case 'rating_desc':
      default:
        sql += ' ORDER BY p.rating DESC, p.name ASC';
        break;
    }

    const limit = Math.min(Math.max(parseInt(limitRaw || '100', 10) || 100, 1), 200);
    const offset = Math.max(parseInt(offsetRaw || '0', 10) || 0, 0);

    sql += ` LIMIT $${paramIndex++}`;
    params.push(limit);
    sql += ` OFFSET $${paramIndex++}`;
    params.push(offset);

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
