/**
 * GET /api/categories
 * Returns all product categories
 */

import { NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { Category } from '@/lib/types';

export async function GET() {
  try {
    const categories = await query<Category[]>(
      'SELECT * FROM Category ORDER BY name'
    );
    return NextResponse.json(categories);
  } catch (error) {
    console.error('Error fetching categories:', error);
    return NextResponse.json(
      { error: 'Failed to fetch categories' },
      { status: 500 }
    );
  }
}


