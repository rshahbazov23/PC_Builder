import type { Metadata } from 'next';
import { Roboto_Mono } from 'next/font/google';
import './globals.css';
import { Header } from '@/components/Header';
import { Footer } from '@/components/Footer';

const robotoMono = Roboto_Mono({
  subsets: ['latin'],
  variable: '--font-roboto-mono',
  display: 'swap',
});

export const metadata: Metadata = {
  title: 'ku_build // Build Your Machine',
  description: 'Browse PC parts, check compatibility, and build your perfect gaming or workstation PC. COMP306 DBMS Project.',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={robotoMono.variable}>
      <body className="min-h-screen flex flex-col bg-background text-foreground antialiased">
        <Header />
        <main className="flex-1">
          {children}
        </main>
        <Footer />
      </body>
    </html>
  );
}
