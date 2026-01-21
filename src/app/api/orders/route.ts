import { NextResponse } from 'next/server';
import { query, queryOne, execute } from '@/lib/db';

interface OrderWithItems {
  order_id: number;
  user_id: number;
  total_price: number;
  status: string;
  shipping_address: string;
  created_at: string;
  item_count: number;
  items: {
    product_id: number;
    product_name: string;
    quantity: number;
    unit_price: number;
  }[];
}

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const userId = searchParams.get('userId');

    let sql = `
      SELECT 
        o.order_id,
        o.user_id,
        o.total_price,
        o.status,
        o.shipping_address,
        o.created_at,
        COUNT(oi.order_item_id) AS item_count
      FROM Orders o
      LEFT JOIN OrderItem oi ON o.order_id = oi.order_id
    `;

    const params: number[] = [];
    if (userId) {
      sql += ` WHERE o.user_id = $1`;
      params.push(parseInt(userId));
    }

    sql += ` GROUP BY o.order_id ORDER BY o.created_at DESC`;

    const orders = await query<OrderWithItems[]>(sql, params);

    // Fetch items for each order
    for (const order of orders) {
      const items = await query<OrderWithItems['items'][0][]>(`
        SELECT 
          oi.product_id,
          p.name AS product_name,
          oi.quantity,
          oi.unit_price
        FROM OrderItem oi
        JOIN Product p ON oi.product_id = p.product_id
        WHERE oi.order_id = $1
      `, [order.order_id]);
      order.items = items;
    }

    return NextResponse.json(orders);
  } catch (error) {
    console.error('Error fetching orders:', error);
    return NextResponse.json({ error: 'Failed to fetch orders' }, { status: 500 });
  }
}

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { userId, buildId, shippingAddress } = body;

    if (!userId || !buildId) {
      return NextResponse.json({ error: 'userId and buildId are required' }, { status: 400 });
    }

    // Get build items with prices
    const buildItems = await query<{ product_id: number; price: number }[]>(`
      SELECT bi.product_id, p.price
      FROM BuildItem bi
      JOIN Product p ON bi.product_id = p.product_id
      WHERE bi.build_id = $1
    `, [buildId]);

    if (buildItems.length === 0) {
      return NextResponse.json({ error: 'Build has no items' }, { status: 400 });
    }

    // Calculate total price
    const totalPrice = buildItems.reduce((sum, item) => sum + Number(item.price), 0);

    // Create order
    const orderResult = await queryOne<{ order_id: number }>(
      `INSERT INTO Orders (user_id, total_price, status, shipping_address) 
       VALUES ($1, $2, 'pending', $3) RETURNING order_id`,
      [userId, totalPrice, shippingAddress || 'Default Address']
    );

    if (!orderResult) {
      return NextResponse.json({ error: 'Failed to create order' }, { status: 500 });
    }

    const orderId = orderResult.order_id;

    // Create order items
    for (const item of buildItems) {
      await execute(
        `INSERT INTO OrderItem (order_id, product_id, quantity, unit_price) 
         VALUES ($1, $2, 1, $3)`,
        [orderId, item.product_id, item.price]
      );
    }

    return NextResponse.json({ 
      success: true, 
      orderId,
      message: 'Order created successfully'
    });
  } catch (error) {
    console.error('Error creating order:', error);
    return NextResponse.json({ error: 'Failed to create order' }, { status: 500 });
  }
}
