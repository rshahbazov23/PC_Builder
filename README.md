# PC Builder Store

A "mini-Newegg" PC parts store and PC Builder application built for COMP306 Database Management Systems course project.

## Features

- **Browse Products**: View PC components by category (CPU, GPU, Motherboard, RAM, PSU, Case, Storage)
- **Product Details**: See detailed specifications for each component
- **PC Builder**: Create custom PC builds with compatibility checking
- **Compatibility System**:
  - CPU ↔ Motherboard socket matching
  - RAM ↔ Motherboard DDR type matching
  - GPU length ↔ Case clearance checking
  - Motherboard form factor ↔ Case compatibility
  - PSU wattage recommendations based on build power consumption
- **Deals Page**: Find products priced below their category average
- **Top Brands**: Discover highly-rated brands with good product variety

## Tech Stack

- **Frontend**: Next.js 14 (App Router) + TypeScript + Tailwind CSS
- **Backend**: Next.js API Routes
- **Database**: Neon Postgres (`neondb`)
- **Driver**: pg (raw SQL with parameterized queries)
- **Deployment**: Vercel
- **Language**: Mostly TypeScript (with a few JS config files)

## Setup Instructions

You can either use the deployed website or run it locally:

- **Deployed (Vercel)**: [pc-builder-two-sigma.vercel.app](https://pc-builder-two-sigma.vercel.app/)
- **Local setup**: Follow the steps below.

### Prerequisites

- Node.js 18+ installed
- PostgreSQL 14+ installed and running
- A PostgreSQL user with database creation privileges

### 1. Clone and Install Dependencies

```bash
cd COMP306_project
npm install
```

### 2. Configure Environment Variables

Copy the example environment file and edit it with your PostgreSQL credentials:

```bash
cp env.example .env.local
```

Edit `.env.local`:
```
DATABASE_URL=postgresql://postgres:your_password@localhost:5432/neondb
```

### 3. Set Up the Database

Run the schema and seed files in PostgreSQL:

```bash
psql -U postgres -f db/schema.sql
psql -U postgres -d neondb -f db/seed.sql
```

Or use the npm script:

```bash
npm run db:setup
```

### 4. Start the Development Server

```bash
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000) in your browser.

## API Endpoints

### Products & Categories
- `GET /api/categories` - List all categories
- `GET /api/products?category=cpu&brand=Intel&minPrice=100&maxPrice=500` - List products with filters
- `GET /api/products/[id]` - Get product details with specs

### Builds
- `GET /api/builds` - List user's builds
- `POST /api/builds` - Create new build
- `GET /api/builds/[id]` - Get build details
- `DELETE /api/builds/[id]` - Delete a build
- `POST /api/builds/[id]/items` - Add part to build
- `DELETE /api/builds/[id]/items?slot_type=CPU` - Remove part from build

### Advanced Query Endpoints
- `GET /api/builds/[id]/compatible/motherboards` - Query 1
- `GET /api/builds/[id]/compatible/ram` - RAM compatibility
- `GET /api/builds/[id]/compatible/cases` - Query 2
- `GET /api/builds/[id]/recommend/psu` - Query 3
- `GET /api/deals` - Query 4
- `GET /api/top-brands` - Query 5

## License

This project was created for educational purposes as part of COMP306 course at Koç University.
