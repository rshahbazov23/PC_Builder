import { Pool } from 'pg';

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  // This will surface clearly in Vercel logs instead of failing silently.
  throw new Error('DATABASE_URL is not set');
}

const isLocal =
  connectionString.includes('localhost') || connectionString.includes('127.0.0.1');

const pool = new Pool({
  connectionString,
  max: 10,
  // Neon requires SSL. Locally, most people run without SSL.
  ssl: isLocal ? undefined : { rejectUnauthorized: false },
});

export async function query<T>(sql: string, params?: unknown[]): Promise<T> {
  const result = await pool.query(sql, params);
  return result.rows as T;
}

export async function queryOne<T>(sql: string, params?: unknown[]): Promise<T | null> {
  const result = await pool.query(sql, params);
  return result.rows.length > 0 ? result.rows[0] as T : null;
}

export async function execute(sql: string, params?: unknown[]): Promise<{ rowCount: number; insertId?: number }> {
  const result = await pool.query(sql, params);
  let insertId: number | undefined;
  if (result.rows && result.rows[0]) {
    const firstRow = result.rows[0];
    const firstKey = Object.keys(firstRow)[0];
    if (firstKey && typeof firstRow[firstKey] === 'number') {
      insertId = firstRow[firstKey];
    }
  }
  return { rowCount: result.rowCount || 0, insertId };
}

export default pool;
