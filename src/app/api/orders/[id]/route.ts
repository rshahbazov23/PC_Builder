import { NextResponse } from 'next/server';
import { query, execute } from '@/lib/db';

interface OrderDetail {
  order_id: number;
  user_id: number;
  username: string;
  total_price: number;
  status: string;
  shipping_address: string;
  created_at: string;
}

export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const orderId = parseInt(params.id);

    const orders = await query<OrderDetail[]>(`
      SELECT 
        o.order_id,
        o.user_id,
        u.username,
        o.total_price,
        o.status,
        o.shipping_address,
        o.created_at
      FROM Orders o
      JOIN "User" u ON o.user_id = u.user_id
      WHERE o.order_id = $1
    `, [orderId]);

    if (orders.length === 0) {
      return NextResponse.json({ error: 'Order not found' }, { status: 404 });
    }

    const order = orders[0];

    // Get order items
    const items = await query<{
      product_id: number;
      product_name: string;
      brand: string;
      quantity: number;
      unit_price: number;
      image_url: string | null;
    }[]>(`
      SELECT 
        oi.product_id,
        p.name AS product_name,
        p.brand,
        oi.quantity,
        oi.unit_price,
        p.image_url
      FROM OrderItem oi
      JOIN Product p ON oi.product_id = p.product_id
      WHERE oi.order_id = $1
    `, [orderId]);

    return NextResponse.json({ ...order, items });
  } catch (error) {
    console.error('Error fetching order:', error);
    return NextResponse.json({ error: 'Failed to fetch order' }, { status: 500 });
  }
}

export async function PATCH(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const orderId = parseInt(params.id);
    const body = await request.json();
    const { status } = body;

    // Pending orders (newly created) cannot have their status changed
    const existingOrder = await query<{ status: string }[]>(
      `SELECT status FROM Orders WHERE order_id = $1`,
      [orderId]
    );
    
    if (existingOrder.length > 0 && existingOrder[0].status === 'pending') {
      return NextResponse.json({ error: 'Pending orders cannot have their status changed' }, { status: 400 });
    }

    const validStatuses = ['pending', 'processing', 'shipped', 'delivered', 'cancelled'];
    if (!validStatuses.includes(status)) {
      return NextResponse.json({ error: 'Invalid status' }, { status: 400 });
    }

    await execute(
      `UPDATE Orders SET status = $1::order_status_enum WHERE order_id = $2`,
      [status, orderId]
    );

    return NextResponse.json({ success: true, message: 'Order status updated' });
  } catch (error) {
    console.error('Error updating order:', error);
    return NextResponse.json({ error: 'Failed to update order' }, { status: 500 });
  }
}

export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const orderId = parseInt(params.id);

    // Only pending orders can be deleted
    const existingOrder = await query<{ status: string }[]>(
      `SELECT status FROM Orders WHERE order_id = $1`,
      [orderId]
    );

    if (existingOrder.length === 0) {
      return NextResponse.json({ error: 'Order not found' }, { status: 404 });
    }

    if (existingOrder[0].status !== 'pending') {
      return NextResponse.json({ error: 'Only pending orders can be deleted' }, { status: 400 });
    }

    // Delete order items first (cascade should handle this, but being explicit)
    await execute(`DELETE FROM OrderItem WHERE order_id = $1`, [orderId]);
    
    // Delete the order
    await execute(`DELETE FROM Orders WHERE order_id = $1`, [orderId]);

    return NextResponse.json({ success: true, message: 'Order deleted' });
  } catch (error) {
    console.error('Error deleting order:', error);
    return NextResponse.json({ error: 'Failed to delete order' }, { status: 500 });
  }
}
