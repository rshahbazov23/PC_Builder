'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { Input } from '@/components/ui/input';

interface Build {
  build_id: number;
  name: string;
}

export function AddToBuildButton({ productId, disabled }: { productId: number; disabled: boolean }) {
  const router = useRouter();
  const [builds, setBuilds] = useState<Build[]>([]);
  const [showModal, setShowModal] = useState(false);
  const [loading, setLoading] = useState(false);
  const [newBuildName, setNewBuildName] = useState('');
  const [message, setMessage] = useState('');

  useEffect(() => {
    if (showModal) {
      fetch('/api/builds')
        .then(res => res.json())
        .then(data => setBuilds(data))
        .catch(err => console.error('Error fetching builds:', err));
    }
  }, [showModal]);

  const handleAddToBuild = async (buildId: number) => {
    setLoading(true);
    try {
      const res = await fetch(`/api/builds/${buildId}/items`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ product_id: productId }),
      });
      
      if (res.ok) {
        setMessage('added to build');
        setTimeout(() => {
          setShowModal(false);
          setMessage('');
          router.push(`/builder/${buildId}`);
        }, 1000);
      } else {
        setMessage('error: failed to add');
      }
    } catch (error) {
      setMessage('error: network');
    } finally {
      setLoading(false);
    }
  };

  const handleCreateBuild = async () => {
    if (!newBuildName.trim()) return;
    
    setLoading(true);
    try {
      const res = await fetch('/api/builds', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: newBuildName }),
      });
      
      if (res.ok) {
        const newBuild = await res.json();
        await handleAddToBuild(newBuild.build_id);
      }
    } catch (error) {
      setMessage('error: create failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      <Button
        onClick={() => setShowModal(true)}
        disabled={disabled}
        size="lg"
        className="font-mono"
      >
        add_to_build()
      </Button>

      {/* Modal */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          <div className="absolute inset-0 bg-background/80 backdrop-blur-sm" onClick={() => setShowModal(false)} />
          <Card className="relative max-w-md w-full p-6">
            <button
              onClick={() => setShowModal(false)}
              className="absolute top-4 right-4 text-muted-foreground hover:text-foreground transition-colors"
            >
              ×
            </button>

            <h3 className="text-lg font-semibold mb-6">./add_to_build</h3>

            {message && (
              <div className="mb-4 p-3 bg-muted text-sm font-mono">
                {message}
              </div>
            )}

            {/* Existing Builds */}
            {builds.length > 0 && (
              <div className="mb-6">
                <h4 className="text-xs font-mono text-muted-foreground mb-3">
                  existing builds
                </h4>
                <div className="space-y-2 max-h-48 overflow-y-auto">
                  {builds.map((build) => (
                    <button
                      key={build.build_id}
                      onClick={() => handleAddToBuild(build.build_id)}
                      disabled={loading}
                      className="w-full p-3 text-left border border-border hover:border-foreground transition-colors text-sm"
                    >
                      {build.name}
                    </button>
                  ))}
                </div>
              </div>
            )}

            {/* Create New Build */}
            <div>
              <h4 className="text-xs font-mono text-muted-foreground mb-3">
                create new build
              </h4>
              <div className="flex gap-2">
                <Input
                  type="text"
                  value={newBuildName}
                  onChange={(e) => setNewBuildName(e.target.value)}
                  placeholder="build_name"
                  className="font-mono"
                />
                <Button
                  onClick={handleCreateBuild}
                  disabled={loading || !newBuildName.trim()}
                  className="font-mono"
                >
                  create
                </Button>
              </div>
            </div>
          </Card>
        </div>
      )}
    </>
  );
}
