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
- **Database**: PostgreSQL (production: Neon Postgres `neondb`)
- **Driver**: pg (raw SQL with parameterized queries)
- **Deployment**: Vercel
- **Language**: Mostly TypeScript (with a few JS config files)

## Setup Instructions

You can either use the deployed website or run it locally.

### Option A) Use the deployed website (recommended for grading)
- **Live URL (Vercel)**: [pc-builder-two-sigma.vercel.app](https://pc-builder-two-sigma.vercel.app/)

### Option B) Run locally (full guide)

#### 0) Install prerequisites
- **Git** (to clone the repository)
- **Node.js 18+** ([download](https://nodejs.org/en/download))
- **PostgreSQL 14+** ([download](https://www.postgresql.org/download/))

Verify installs:

```bash
node -v
npm -v
psql --version
```

##### macOS (Homebrew)

```bash
brew install nvm postgresql@14
brew services start postgresql@14
```

Then install Node 18 using nvm:

```bash
nvm install 18
nvm use 18
```

##### Windows
- Install **Node.js 18+** from the Node.js link above.
- Install **PostgreSQL 14+** from the PostgreSQL link above (set a password for the `postgres` user during installation).
- Use **PowerShell** (or Git Bash) to run the commands below.

##### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable --now postgresql
```

#### 1) Clone the repository + install dependencies

```bash
git clone <https://github.com/rshahbazov23/PC_Builder.git>
cd COMP306_Project
npm install
```

#### 2) Configure environment variables

Create the local env file:

```bash
cp env.example .env.local
```

Edit `.env.local` and set your local Postgres connection:

```txt
DATABASE_URL=postgresql://postgres:your_password@localhost:5432/neondb
```

Notes:
- If your local Postgres user is not `postgres`, replace it.
- If you don’t use a password locally, you can omit it:
  `postgresql://postgres@localhost:5432/neondb`

#### 3) Create and seed the database

This project’s schema file **creates the `neondb` database** and connects to it (it uses `psql` commands like `\\c`), so please run it via `psql`.

**Option 1 (recommended):**

```bash
npm run db:setup
```

**Option 2 (manual):**

```bash
psql -U postgres -f db/schema.sql
psql -U postgres -d neondb -f db/seed_combined.sql
```

If you get permission errors, run these commands with a Postgres user that has database creation privileges (or create the DB manually).

#### 4) Run the app

```bash
npm run dev
```

Open:
- `http://localhost:3000`

#### Troubleshooting
- **“DATABASE_URL is not set”**: make sure `.env.local` exists and contains `DATABASE_URL=...`
- **psql cannot connect**: ensure PostgreSQL is running, and the username/password are correct
- **permission denied creating database**: use a superuser (often `postgres`) or a user with CREATEDB privileges

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
