import { NextRequest, NextResponse } from 'next/server';
import { query, execute } from '@/lib/db';
import { Build } from '@/lib/types';

const DEMO_USER_ID = 1;

export async function GET() {
  try {
    const builds = await query<Build>(
      `SELECT b.*, 
              COUNT(bi.product_id) AS part_count,
              COALESCE(SUM(p.price), 0) AS total_price,
              COALESCE(SUM(p.power_watts), 0) AS total_watts
       FROM Build b
       LEFT JOIN BuildItem bi ON b.build_id = bi.build_id
       LEFT JOIN Product p ON bi.product_id = p.product_id
       WHERE b.user_id = $1
       GROUP BY b.build_id
       ORDER BY b.updated_at DESC`,
      [DEMO_USER_ID]
    );
    return NextResponse.json(builds);
  } catch (error) {
    console.error('Error fetching builds:', error);
    return NextResponse.json(
      { error: 'Failed to fetch builds' },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { name, description } = body;

    if (!name) {
      return NextResponse.json(
        { error: 'Build name is required' },
        { status: 400 }
      );
    }

    const result = await execute(
      'INSERT INTO Build (user_id, name, description) VALUES ($1, $2, $3) RETURNING build_id',
      [DEMO_USER_ID, name, description || null]
    );

    const newBuild = await query<Build>(
      'SELECT * FROM Build WHERE build_id = $1',
      [result.insertId]
    );

    return NextResponse.json(newBuild[0], { status: 201 });
  } catch (error) {
    console.error('Error creating build:', error);
    return NextResponse.json(
      { error: 'Failed to create build' },
      { status: 500 }
    );
  }
}
