'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';

interface User {
  user_id: number;
  username: string;
  email: string;
  created_at: string;
  build_count: number;
  order_count: number;
}

interface OrderItem {
  product_id: number;
  product_name: string;
  quantity: number;
  unit_price: number;
}

interface Order {
  order_id: number;
  user_id: number;
  total_price: number;
  status: string;
  shipping_address: string;
  created_at: string;
  item_count: number;
  items: OrderItem[];
}

const statusColors: Record<string, string> = {
  pending: 'bg-yellow-100 text-yellow-800',
  processing: 'bg-blue-100 text-blue-800',
  shipped: 'bg-purple-100 text-purple-800',
  delivered: 'bg-green-100 text-green-800',
  cancelled: 'bg-red-100 text-red-800',
};

export default function AccountPage() {
  const [users, setUsers] = useState<User[]>([]);
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  const [updatingOrder, setUpdatingOrder] = useState<number | null>(null);

  useEffect(() => {
    fetchUsers();
  }, []);

  useEffect(() => {
    if (selectedUser) {
      fetchOrders(selectedUser.user_id);
      // Store selected user in localStorage for other pages
      localStorage.setItem('selectedUserId', selectedUser.user_id.toString());
    }
  }, [selectedUser]);

  async function fetchUsers() {
    try {
      const res = await fetch('/api/users');
      const data = await res.json();
      setUsers(data);
      // Try to restore previously selected user
      const savedUserId = localStorage.getItem('selectedUserId');
      if (savedUserId) {
        const user = data.find((u: User) => u.user_id === parseInt(savedUserId));
        if (user) setSelectedUser(user);
      } else if (data.length > 0) {
        setSelectedUser(data[0]);
      }
    } catch (error) {
      console.error('Error fetching users:', error);
    } finally {
      setLoading(false);
    }
  }

  async function fetchOrders(userId: number) {
    try {
      const res = await fetch(`/api/orders?userId=${userId}`);
      const data = await res.json();
      setOrders(data);
    } catch (error) {
      console.error('Error fetching orders:', error);
    }
  }

  async function updateOrderStatus(orderId: number, newStatus: string) {
    setUpdatingOrder(orderId);
    try {
      const res = await fetch(`/api/orders/${orderId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status: newStatus }),
      });
      if (res.ok && selectedUser) {
        fetchOrders(selectedUser.user_id);
      }
    } catch (error) {
      console.error('Error updating order:', error);
    } finally {
      setUpdatingOrder(null);
    }
  }

  async function deleteOrder(orderId: number) {
    if (!confirm('Are you sure you want to delete this order?')) return;
    
    setUpdatingOrder(orderId);
    try {
      const res = await fetch(`/api/orders/${orderId}`, {
        method: 'DELETE',
      });
      if (res.ok && selectedUser) {
        fetchOrders(selectedUser.user_id);
      } else {
        const data = await res.json();
        alert(data.error || 'Failed to delete order');
      }
    } catch (error) {
      console.error('Error deleting order:', error);
    } finally {
      setUpdatingOrder(null);
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-muted-foreground font-mono">loading...</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen">
      {/* Header */}
      <div className="border-b border-border">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 py-12">
          <nav className="flex items-center gap-2 text-sm text-muted-foreground mb-4 font-mono">
            <Link href="/" className="hover:text-foreground transition-colors">~</Link>
            <span>/</span>
            <span className="text-foreground">account</span>
          </nav>
          <h1 className="text-3xl font-semibold mb-2">./account</h1>
          <p className="text-muted-foreground font-mono text-sm">
            {'// user management and order history (demo)'}
          </p>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8">
        <div className="grid lg:grid-cols-3 gap-8">
          {/* User Selection Sidebar */}
          <div className="lg:col-span-1">
            <Card className="p-5">
              <h2 className="font-semibold mb-4 font-mono text-sm">select_user()</h2>
              <div className="space-y-2">
                {users.map((user) => (
                  <button
                    key={user.user_id}
                    onClick={() => setSelectedUser(user)}
                    className={`w-full text-left p-3 border transition-colors ${
                      selectedUser?.user_id === user.user_id
                        ? 'border-foreground bg-foreground text-background'
                        : 'border-border hover:border-foreground/50'
                    }`}
                  >
                    <div className="font-medium">{user.username}</div>
                    <div className="text-xs opacity-70 font-mono">{user.email}</div>
                    <div className="flex gap-4 mt-2 text-xs opacity-70">
                      <span>{user.build_count} builds</span>
                      <span>{user.order_count} orders</span>
                    </div>
                  </button>
                ))}
              </div>

              {selectedUser && (
                <>
                  <Separator className="my-4" />
                  <div className="text-xs text-muted-foreground font-mono">
                    <div className="mb-1">user_id: {selectedUser.user_id}</div>
                    <div className="mb-1">created: {new Date(selectedUser.created_at).toLocaleDateString()}</div>
                  </div>
                </>
              )}
            </Card>

            {/* Quick Actions */}
            <Card className="p-5 mt-4">
              <h3 className="font-semibold mb-4 font-mono text-sm">quick_actions()</h3>
              <div className="space-y-2">
                <Link href="/builder">
                  <Button variant="outline" className="w-full font-mono text-sm justify-start">
                    → new_build()
                  </Button>
                </Link>
                <Link href="/deals">
                  <Button variant="outline" className="w-full font-mono text-sm justify-start">
                    → browse_deals()
                  </Button>
                </Link>
              </div>
            </Card>
          </div>

          {/* Orders */}
          <div className="lg:col-span-2">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-xl font-semibold">Order History</h2>
              <span className="text-sm text-muted-foreground font-mono">
                [{orders.length}] orders
              </span>
            </div>

            {orders.length === 0 ? (
              <Card className="p-12 text-center">
                <div className="text-4xl mb-4">📦</div>
                <h3 className="font-semibold mb-2">No orders yet</h3>
                <p className="text-sm text-muted-foreground mb-4">
                  Create a build and place an order to see it here
                </p>
                <Link href="/builder">
                  <Button className="font-mono text-sm">start_building()</Button>
                </Link>
              </Card>
            ) : (
              <div className="space-y-4">
                {orders.map((order) => (
                  <Card key={order.order_id} className="p-5">
                    <div className="flex items-start justify-between mb-4">
                      <div>
                        <div className="font-mono text-sm text-muted-foreground">
                          Order #{order.order_id}
                        </div>
                        <div className="font-semibold text-lg">
                          ${Number(order.total_price).toFixed(2)}
                        </div>
                        <div className="text-xs text-muted-foreground">
                          {new Date(order.created_at).toLocaleDateString('en-US', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric',
                          })}
                        </div>
                      </div>
                      <Badge className={statusColors[order.status] || 'bg-gray-100'}>
                        {order.status}
                      </Badge>
                    </div>

                    {/* Order Items */}
                    <div className="bg-muted p-3 mb-4">
                      <div className="text-xs font-mono text-muted-foreground mb-2">
                        items: [{order.items?.length || order.item_count}]
                      </div>
                      <div className="space-y-1">
                        {order.items?.slice(0, 3).map((item, idx) => (
                          <div key={idx} className="flex justify-between text-sm">
                            <span className="truncate flex-1">{item.product_name}</span>
                            <span className="font-mono ml-2">${Number(item.unit_price).toFixed(2)}</span>
                          </div>
                        ))}
                        {order.items && order.items.length > 3 && (
                          <div className="text-xs text-muted-foreground">
                            +{order.items.length - 3} more items
                          </div>
                        )}
                      </div>
                    </div>

                    {/* Order Actions */}
                    {order.status === 'pending' ? (
                      <div className="flex items-center gap-2">
                        <span className="text-xs text-muted-foreground font-mono">
                          status: pending (awaiting processing)
                        </span>
                        <Button
                          variant="outline"
                          size="sm"
                          className="text-xs h-7 text-red-600 border-red-200 hover:bg-red-50"
                          disabled={updatingOrder === order.order_id}
                          onClick={() => deleteOrder(order.order_id)}
                        >
                          {updatingOrder === order.order_id ? 'deleting...' : 'delete_order()'}
                        </Button>
                      </div>
                    ) : (
                      <div className="flex items-center gap-2 flex-wrap">
                        <span className="text-xs text-muted-foreground font-mono">update_status:</span>
                        {['processing', 'shipped', 'delivered', 'cancelled'].map((status) => (
                          <Button
                            key={status}
                            variant={order.status === status ? 'default' : 'outline'}
                            size="sm"
                            className="text-xs h-7"
                            disabled={updatingOrder === order.order_id}
                            onClick={() => updateOrderStatus(order.order_id, status)}
                          >
                            {status}
                          </Button>
                        ))}
                      </div>
                    )}
                  </Card>
                ))}
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
