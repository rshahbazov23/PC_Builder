import { NextResponse } from 'next/server';
import { query } from '@/lib/db';
import { User } from '@/lib/types';

export async function GET() {
  try {
    const users = await query<User[]>(`
      SELECT 
        u.user_id, 
        u.username, 
        u.email, 
        u.created_at,
        (SELECT COUNT(*) FROM Build b WHERE b.user_id = u.user_id) AS build_count,
        (SELECT COUNT(*) FROM Orders o WHERE o.user_id = u.user_id) AS order_count
      FROM "User" u
      ORDER BY u.user_id
    `);
    return NextResponse.json(users);
  } catch (error) {
    console.error('Error fetching users:', error);
    return NextResponse.json({ error: 'Failed to fetch users' }, { status: 500 });
  }
}
