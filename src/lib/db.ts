import { Pool, QueryResultRow } from 'pg';

const pool = new Pool({
  host: process.env.PGHOST,
  user: process.env.PGUSER,
  password: process.env.PGPASSWORD,
  database: process.env.PGDATABASE,
  port: parseInt(process.env.PGPORT || '5432'),
  max: 10,
});

export async function query<T extends QueryResultRow>(sql: string, params?: unknown[]): Promise<T[]> {
  const result = await pool.query<T>(sql, params);
  return result.rows;
}

export async function queryOne<T extends QueryResultRow>(sql: string, params?: unknown[]): Promise<T | null> {
  const results = await query<T>(sql, params);
  return results.length > 0 ? results[0] : null;
}

export async function execute(sql: string, params?: unknown[]): Promise<{ rowCount: number; insertId?: number }> {
  const result = await pool.query(sql, params);
  const insertId = result.rows && result.rows[0] && result.rows[0].id ? result.rows[0].id : undefined;
  return { rowCount: result.rowCount || 0, insertId };
}

export default pool;
