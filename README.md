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
- **Database**: MySQL 8.x
- **ORM**: mysql2/promise (raw SQL with prepared statements)

## Project Structure

```
├── db/
│   ├── schema.sql      # Database schema (CREATE TABLE statements)
│   └── seed.sql        # Sample data (180+ products)
├── docs/
│   ├── er-diagram.mmd  # Mermaid ER diagram
│   └── advanced-queries.md  # Documentation of 5 advanced SQL queries
├── src/
│   ├── app/
│   │   ├── api/        # API routes
│   │   ├── builder/    # PC Builder pages
│   │   ├── category/   # Category pages
│   │   ├── deals/      # Deals page
│   │   ├── product/    # Product detail pages
│   │   └── top-brands/ # Top Brands page
│   ├── components/     # Reusable UI components
│   └── lib/
│       ├── db.ts       # Database connection pool
│       └── types.ts    # TypeScript type definitions
└── env.example         # Environment variables template
```

## Setup Instructions

### Prerequisites

- Node.js 18+ installed
- MySQL 8.x installed and running
- A MySQL user with database creation privileges

### 1. Clone and Install Dependencies

```bash
cd COMP306_project
npm install
```

### 2. Configure Environment Variables

Copy the example environment file and edit it with your MySQL credentials:

```bash
cp env.example .env.local
```

Edit `.env.local`:
```
MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_PASSWORD=your_password
MYSQL_DATABASE=pc_builder
MYSQL_PORT=3306
```

### 3. Set Up the Database

Run the schema and seed files in MySQL:

```bash
# Option 1: Using mysql CLI
mysql -u root -p < db/schema.sql
mysql -u root -p pc_builder < db/seed.sql

# Option 2: Using MySQL Workbench
# 1. Open schema.sql and execute
# 2. Open seed.sql and execute
```

### 4. Start the Development Server

```bash
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000) in your browser.

## Database Schema

### Tables (12 total)

1. **Category** - Product categories
2. **User** - User accounts
3. **Product** - Main product information
4. **Build** - User PC builds
5. **BuildItem** - Parts in a build (with unique slot constraint)
6. **CPU_Spec** - CPU-specific specifications
7. **MOBO_Spec** - Motherboard specifications
8. **GPU_Spec** - Graphics card specifications
9. **RAM_Spec** - Memory specifications
10. **PSU_Spec** - Power supply specifications
11. **CASE_Spec** - Case specifications
12. **Storage_Spec** - SSD/HDD specifications
13. **Orders** - Customer orders (optional)
14. **OrderItem** - Order line items (optional)

### Key Relationships

- Category 1:N Product
- Product 1:0..1 Spec tables (depending on category)
- User 1:N Build
- Build 1:N BuildItem (with UNIQUE constraint on build_id + slot_type)

## Advanced SQL Queries (5 Required)

All 5 advanced queries are integrated into the UI:

| Query | Type | UI Location |
|-------|------|-------------|
| **Q1**: Compatible Motherboards | Nested Subquery + JOIN | Builder → Compatible Motherboards |
| **Q2**: Compatible Cases | Multiple Nested Subqueries | Builder → Compatible Cases |
| **Q3**: PSU Recommendation | Aggregate (SUM) + Derived Calculation | Builder → Recommend PSU |
| **Q4**: Deals | Correlated Subquery with AVG | Deals page |
| **Q5**: Top Brands | GROUP BY + HAVING | Top Brands page |

See `docs/advanced-queries.md` for detailed SQL and explanations.

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

## Sample Data

The seed file includes:
- 7 categories
- 25+ CPUs (Intel LGA1700, AMD AM5, AMD AM4)
- 25+ Motherboards (matching sockets)
- 27+ GPUs (NVIDIA RTX 40 series, AMD RX 7000)
- 22+ RAM kits (DDR4 and DDR5)
- 28+ PSUs (550W to 1500W)
- 23+ Cases (ATX, Micro-ATX, Mini-ITX)
- 32+ Storage devices (NVMe, SATA SSD, HDD)
- 1 demo build

## For the Report

1. **ER Diagram**: Use `docs/er-diagram.mmd` in [Mermaid Live Editor](https://mermaid.live/)
2. **CREATE TABLE Statements**: Copy from `db/schema.sql`
3. **Data Sources**: Realistic PC parts data inspired by Newegg/PCPartPicker
4. **Advanced SQL Queries**: Copy from `docs/advanced-queries.md`
5. **Screenshots**: Capture Home, Category, Builder, Deals, Top Brands pages

## License

This project was created for educational purposes as part of COMP306 course at Koç University.

