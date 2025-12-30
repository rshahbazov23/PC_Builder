'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';

interface Build {
  build_id: number;
  name: string;
  created_at: string;
  part_count: number;
  total_price: number;
  total_watts: number;
}

export default function BuilderPage() {
  const router = useRouter();
  const [builds, setBuilds] = useState<Build[]>([]);
  const [loading, setLoading] = useState(true);
  const [creating, setCreating] = useState(false);

  useEffect(() => {
    fetchBuilds();
  }, []);

  const fetchBuilds = async () => {
    try {
      const res = await fetch('/api/builds');
      const data = await res.json();
      setBuilds(data);
    } catch (error) {
      console.error('Error fetching builds:', error);
    } finally {
      setLoading(false);
    }
  };

  const startNewBuild = async () => {
    setCreating(true);
    try {
      const res = await fetch('/api/builds', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: `Build #${builds.length + 1}` }),
      });
      
      if (res.ok) {
        const newBuild = await res.json();
        router.push(`/builder/${newBuild.build_id}`);
      }
    } catch (error) {
      console.error('Error creating build:', error);
      setCreating(false);
    }
  };

  const deleteBuild = async (e: React.MouseEvent, buildId: number) => {
    e.preventDefault();
    e.stopPropagation();
    if (!confirm('Delete this build?')) return;
    
    try {
      await fetch(`/api/builds/${buildId}`, { method: 'DELETE' });
      fetchBuilds();
    } catch (error) {
      console.error('Error deleting build:', error);
    }
  };

  return (
    <div className="min-h-screen bg-muted/30">
      {/* Hero */}
      <section className="bg-background border-b border-border">
        <div className="max-w-4xl mx-auto px-4 py-16 text-center">
          <h1 className="text-3xl md:text-4xl font-bold mb-4">PC Builder</h1>
          <p className="text-muted-foreground mb-8 max-w-md mx-auto">
            Select your components and we'll check compatibility automatically. 
            CPU sockets, RAM types, GPU clearance — all handled.
          </p>
          <Button 
            size="lg" 
            onClick={startNewBuild}
            disabled={creating}
            className="text-lg px-8 py-6"
          >
            {creating ? 'Creating...' : 'Start New Build →'}
          </Button>
        </div>
      </section>

      {/* Recent Builds */}
      <div className="max-w-4xl mx-auto px-4 py-8">
        {!loading && builds.length > 0 && (
          <>
            <h2 className="text-sm text-muted-foreground mb-4">Your Recent Builds</h2>
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {builds.slice(0, 6).map((build) => (
                <Link 
                  key={build.build_id} 
                  href={`/builder/${build.build_id}`}
                  className="block"
                >
                  <Card className="p-4 hover:border-foreground/30 transition-colors h-full">
                    <div className="flex justify-between items-start mb-3">
                      <h3 className="font-semibold">{build.name}</h3>
                      <button
                        onClick={(e) => deleteBuild(e, build.build_id)}
                        className="text-muted-foreground hover:text-destructive text-lg leading-none"
                      >
                        ×
                      </button>
                    </div>
                    <div className="text-sm text-muted-foreground mb-2">
                      {build.part_count || 0}/7 parts • {build.total_watts || 0}W
                    </div>
                    <div className="text-lg font-bold">
                      ${Number(build.total_price || 0).toFixed(2)}
                    </div>
                  </Card>
                </Link>
              ))}
            </div>
          </>
        )}

        {!loading && builds.length === 0 && (
          <div className="text-center text-muted-foreground py-8">
            <p>No builds yet. Click above to start your first one!</p>
          </div>
        )}
      </div>
    </div>
  );
}
