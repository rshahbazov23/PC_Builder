/**
 * GET /api/products/[id]
 * Returns a single product with its category-specific specs
 */

import { NextRequest, NextResponse } from 'next/server';
import { query, queryOne } from '@/lib/db';
import { Product, CPUSpec, MOBOSpec, GPUSpec, CASESpec, PSUSpec, RAMSpec, StorageSpec } from '@/lib/types';

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const productId = parseInt(params.id);

    // Get product with category info
    const product = await queryOne<Product>(
      `SELECT p.*, c.name AS category_name, c.slug AS category_slug
       FROM Product p
       JOIN Category c ON p.category_id = c.category_id
       WHERE p.product_id = ?`,
      [productId]
    );

    if (!product) {
      return NextResponse.json(
        { error: 'Product not found' },
        { status: 404 }
      );
    }

    // Get category-specific specs based on category
    let specs = null;
    const categorySlug = product.category_slug;

    switch (categorySlug) {
      case 'cpu':
        specs = await queryOne<CPUSpec>(
          'SELECT * FROM CPU_Spec WHERE product_id = ?',
          [productId]
        );
        break;
      case 'motherboard':
        specs = await queryOne<MOBOSpec>(
          'SELECT * FROM MOBO_Spec WHERE product_id = ?',
          [productId]
        );
        break;
      case 'gpu':
        specs = await queryOne<GPUSpec>(
          'SELECT * FROM GPU_Spec WHERE product_id = ?',
          [productId]
        );
        break;
      case 'case':
        specs = await queryOne<CASESpec>(
          'SELECT * FROM CASE_Spec WHERE product_id = ?',
          [productId]
        );
        break;
      case 'psu':
        specs = await queryOne<PSUSpec>(
          'SELECT * FROM PSU_Spec WHERE product_id = ?',
          [productId]
        );
        break;
      case 'ram':
        specs = await queryOne<RAMSpec>(
          'SELECT * FROM RAM_Spec WHERE product_id = ?',
          [productId]
        );
        break;
      case 'storage':
        specs = await queryOne<StorageSpec>(
          'SELECT * FROM Storage_Spec WHERE product_id = ?',
          [productId]
        );
        break;
    }

    return NextResponse.json({ ...product, specs });
  } catch (error) {
    console.error('Error fetching product:', error);
    return NextResponse.json(
      { error: 'Failed to fetch product' },
      { status: 500 }
    );
  }
}

