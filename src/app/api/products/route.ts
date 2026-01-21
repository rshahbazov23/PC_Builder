import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Product } from '@/lib/types';

export const dynamic = 'force-dynamic';

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
    const socket = searchParams.get('socket');
    const ramType = searchParams.get('ramType');
    const storageType = searchParams.get('storageType');
    const minVram = searchParams.get('minVram');
    const minWattage = searchParams.get('minWattage');
    const formFactor = searchParams.get('formFactor');
    const sort = searchParams.get('sort');
    const limitRaw = searchParams.get('limit');
    const offsetRaw = searchParams.get('offset');

    let specJoin = '';
    if (category === 'cpu') specJoin = ' LEFT JOIN CPU_Spec cpu ON cpu.product_id = p.product_id';
    if (category === 'motherboard') specJoin = ' LEFT JOIN MOBO_Spec mobo ON mobo.product_id = p.product_id';
    if (category === 'gpu') specJoin = ' LEFT JOIN GPU_Spec gpu ON gpu.product_id = p.product_id';
    if (category === 'ram') specJoin = ' LEFT JOIN RAM_Spec ram ON ram.product_id = p.product_id';
    if (category === 'psu') specJoin = ' LEFT JOIN PSU_Spec psu ON psu.product_id = p.product_id';
    if (category === 'case') specJoin = ' LEFT JOIN CASE_Spec cs ON cs.product_id = p.product_id';
    if (category === 'storage') specJoin = ' LEFT JOIN Storage_Spec st ON st.product_id = p.product_id';

    let sql = `
      SELECT p.*, c.name AS category_name, c.slug AS category_slug
      FROM Product p
      JOIN Category c ON p.category_id = c.category_id
      ${specJoin}
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

    if (socket && category === 'cpu') {
      sql += ` AND cpu.socket = $${paramIndex++}`;
      params.push(socket);
    }
    if (socket && category === 'motherboard') {
      sql += ` AND mobo.socket = $${paramIndex++}`;
      params.push(socket);
    }
    if (ramType && category === 'ram') {
      sql += ` AND ram.ram_type = $${paramIndex++}`;
      params.push(ramType);
    }
    if (ramType && category === 'motherboard') {
      sql += ` AND mobo.ram_type = $${paramIndex++}`;
      params.push(ramType);
    }
    if (storageType && category === 'storage') {
      sql += ` AND st.storage_type = $${paramIndex++}`;
      params.push(storageType);
    }
    if (formFactor && category === 'case') {
      sql += ` AND cs.supported_form_factor = $${paramIndex++}`;
      params.push(formFactor);
    }
    if (formFactor && category === 'motherboard') {
      sql += ` AND mobo.form_factor = $${paramIndex++}`;
      params.push(formFactor);
    }
    if (minVram && category === 'gpu') {
      const v = parseInt(minVram, 10);
      if (!Number.isNaN(v)) {
        sql += ` AND gpu.vram_gb >= $${paramIndex++}`;
        params.push(v);
      }
    }
    if (minWattage && category === 'psu') {
      const w = parseInt(minWattage, 10);
      if (!Number.isNaN(w)) {
        sql += ` AND psu.wattage >= $${paramIndex++}`;
        params.push(w);
      }
    }

    if (inStock === 'true') {
      sql += ' AND p.stock_qty > 0';
    }

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
