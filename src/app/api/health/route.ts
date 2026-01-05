import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET() {
  try {
    const [{ db }] = await query<{ db: string }[]>(`SELECT current_database() AS db`);
    const [{ category_count }] = await query<{ category_count: number }[]>(
      `SELECT COUNT(*)::int AS category_count FROM Category`
    );
    const [{ product_count }] = await query<{ product_count: number }[]>(
      `SELECT COUNT(*)::int AS product_count FROM Product`
    );

    return NextResponse.json({
      ok: true,
      db,
      category_count,
      product_count,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error('DB health check failed:', error);
    return NextResponse.json(
      { ok: false, error: 'DB health check failed' },
      { status: 500 }
    );
  }
}


