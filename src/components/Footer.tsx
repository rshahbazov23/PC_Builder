import Link from 'next/link';
import { Logo } from './Logo';

export function Footer() {
  return (
    <footer className="border-t border-border mt-auto">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Brand */}
          <div className="col-span-1 md:col-span-2">
            <Link href="/" className="inline-flex items-center gap-2 mb-4">
              <Logo className="w-8 h-8" />
              <span className="font-mono font-semibold">ku_build</span>
            </Link>
            <p className="text-sm text-muted-foreground max-w-sm leading-relaxed">
              Build your machine with confidence. 
              Automatic compatibility checking, power calculations, 
              and curated deals.
            </p>
          </div>

          {/* Components */}
          <div>
            <h3 className="text-sm font-medium mb-4">
              <span className="text-muted-foreground">./</span>components
            </h3>
            <ul className="space-y-2 text-sm">
              <FooterLink href="/category/cpu">cpu</FooterLink>
              <FooterLink href="/category/gpu">gpu</FooterLink>
              <FooterLink href="/category/motherboard">motherboard</FooterLink>
              <FooterLink href="/category/ram">memory</FooterLink>
              <FooterLink href="/category/storage">storage</FooterLink>
              <FooterLink href="/category/psu">psu</FooterLink>
              <FooterLink href="/category/case">case</FooterLink>
            </ul>
          </div>

          {/* Tools */}
          <div>
            <h3 className="text-sm font-medium mb-4">
              <span className="text-muted-foreground">./</span>tools
            </h3>
            <ul className="space-y-2 text-sm">
              <FooterLink href="/builder">build_new()</FooterLink>
              <FooterLink href="/deals">find_deals()</FooterLink>
              <FooterLink href="/top-brands">top_brands()</FooterLink>
            </ul>
          </div>
        </div>

        <div className="border-t border-border mt-8 pt-8 flex flex-col sm:flex-row justify-between items-center gap-4">
          <p className="text-xs text-muted-foreground">
            © {new Date().getFullYear()} ku_build
          </p>
          <p className="text-xs text-muted-foreground font-mono">
            {'v1.0.0'}
          </p>
        </div>
      </div>
    </footer>
  );
}

function FooterLink({ href, children }: { href: string; children: React.ReactNode }) {
  return (
    <li>
      <Link
        href={href}
        className="text-muted-foreground hover:text-foreground transition-colors inline-flex items-center gap-1"
      >
        <span className="text-muted-foreground/50">-</span>
        {children}
      </Link>
    </li>
  );
}
