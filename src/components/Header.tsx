'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { Logo } from './Logo';

export function Header() {
  const pathname = usePathname();

  const isActive = (path: string) => pathname === path || pathname.startsWith(path + '/');

  return (
    <header className="sticky top-0 z-50 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 border-b border-border">
      <div className="max-w-6xl mx-auto px-4 sm:px-6">
        <div className="flex items-center justify-between h-14">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-2 group">
            <Logo className="w-12 h-12" />
            <span className="font-mono font-semibold tracking-tight">ku_build</span>
          </Link>

          {/* Navigation */}
          <nav className="hidden md:flex items-center gap-1">
            <NavLink href="/" active={pathname === '/'}>index</NavLink>
            <span className="text-muted-foreground/50">/</span>
            <NavLink href="/category/cpu" active={isActive('/category')}>browse</NavLink>
            <span className="text-muted-foreground/50">/</span>
            <NavLink href="/builder" active={isActive('/builder')}>build</NavLink>
            <span className="text-muted-foreground/50">/</span>
            <NavLink href="/deals" active={isActive('/deals')}>deals</NavLink>
            <span className="text-muted-foreground/50">/</span>
            <NavLink href="/top-brands" active={isActive('/top-brands')}>brands</NavLink>
          </nav>

          {/* CTA */}
          <Link
            href="/builder"
            className="hidden sm:inline-flex items-center gap-2 px-4 py-1.5 border border-foreground text-sm font-medium hover:bg-foreground hover:text-background transition-colors"
          >
            <span className="text-muted-foreground">$</span>
            new_build
          </Link>

          {/* Mobile menu */}
          <button className="md:hidden p-2 hover:bg-muted rounded transition-colors">
            <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
        </div>
      </div>
    </header>
  );
}

function NavLink({ href, active, children }: { href: string; active: boolean; children: React.ReactNode }) {
  return (
    <Link
      href={href}
      className={`px-2 py-1 text-sm transition-colors ${
        active
          ? 'text-foreground'
          : 'text-muted-foreground hover:text-foreground'
      }`}
    >
      {active && <span className="text-foreground mr-1">→</span>}
      {children}
    </Link>
  );
}
