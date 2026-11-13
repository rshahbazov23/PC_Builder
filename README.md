# PC Builder Store

A PC parts store with a build configurator that checks whether the chosen components fit together. It was the course project for Database Management Systems (COMP 306) at Koç University.

The store lists 307 products in 12 categories. In the builder you pick a part for each slot, and the app checks every choice against what is already in the build.

## Features

- **Catalog.** Browse products by category, filter by brand and price, and open a product to see its full specifications.
- **PC builder.** Create a build, add or remove a part for each slot, and turn a finished build into an order.
- **Compatibility checks**, each computed in SQL from the build's current parts:
  - CPU socket against motherboard socket
  - memory type (DDR generation) against the motherboard
  - graphics card length against case clearance
  - motherboard form factor against the case
  - power supplies with at least 1.2 times the build's total power draw
- **Deals.** Products priced below the average of their category, ranked by how far below.
- **Top brands.** For each category, brands with enough products in stock and a high average rating.

## How it is built

| Layer | Choice |
|---|---|
| Front end | Next.js 14 (App Router), TypeScript, Tailwind CSS |
| Back end | Next.js API routes |
| Database | PostgreSQL, queried with hand-written parameterized SQL through `pg`, with no ORM |

The schema in [db/schema.sql](db/schema.sql) has 14 tables: categories and products, one specification table for each component type (CPU, motherboard, graphics card, case, power supply, memory, storage), builds and their items, orders and their items, and users. It uses enum types for build slots and order status, indexes on product category, brand and price, and a trigger that updates a build's timestamp.

The project's five advanced queries each sit behind their own endpoint:

| Endpoint | Query |
|---|---|
| `GET /api/builds/[id]/compatible/motherboards` | Motherboards whose socket matches the build's CPU |
| `GET /api/builds/[id]/compatible/cases` | Cases that fit the build's motherboard and graphics card |
| `GET /api/builds/[id]/recommend/psu` | Power supplies with enough wattage, using an aggregate over the build's parts in a nested subquery |
| `GET /api/deals` | Products below their category's average price, using correlated subqueries |
| `GET /api/top-brands` | Brands per category, using `GROUP BY` and `HAVING` on product count and average rating |

## Running it locally

You need Git, Node.js 18 or later, and PostgreSQL 14 or later.

### 1. Clone and install

```bash
git clone https://github.com/rshahbazov23/PC_Builder.git
cd PC_Builder
npm install
```

### 2. Set the database connection

```bash
cp env.example .env.local
```

Edit `.env.local` so that `DATABASE_URL` points at your local PostgreSQL:

```txt
DATABASE_URL=postgresql://postgres:your_password@localhost:5432/neondb
```

Replace `postgres` if your local user has another name, and leave out the password if you don't use one.

### 3. Create and seed the database

The schema file creates a database called `neondb` and connects to it, so run it through `psql`:

```bash
psql -U postgres -f db/schema.sql
psql -U postgres -d neondb -f db/seed_combined.sql
psql -U postgres -d neondb -f db/migration_add_product_images.sql
```

`npm run db:setup` runs the first two commands for you. The third adds the image URLs for all 307 products, and the product images do not show without it.

### 4. Start the app

```bash
npm run dev
```

Then open http://localhost:3000.

### Troubleshooting

- **"DATABASE_URL is not set"**: check that `.env.local` exists and contains `DATABASE_URL=...`.
- **`psql` cannot connect**: check that PostgreSQL is running and that the user name and password are right. On macOS with Homebrew, start it with `brew services start postgresql@14`.
- **Permission denied creating the database**: use a superuser, often `postgres`, or a user with the `CREATEDB` privilege.
- **"role 'postgres' does not exist"**: with Homebrew PostgreSQL on macOS the default user is your system user name. Either use that name in `.env.local` and in the `psql` commands, or create the role with `psql -d postgres -c "CREATE ROLE postgres WITH SUPERUSER LOGIN PASSWORD 'your_password';"`.
- **Images not showing**: run the image migration from step 3.

## API

### Products and categories

- `GET /api/categories` lists all categories.
- `GET /api/products?category=cpu&brand=Intel&minPrice=100&maxPrice=500` lists products with filters.
- `GET /api/products/[id]` returns one product with its specifications.

### Builds

- `GET /api/builds` lists builds.
- `POST /api/builds` creates a build.
- `GET /api/builds/[id]` returns one build.
- `DELETE /api/builds/[id]` deletes a build.
- `POST /api/builds/[id]/items` adds a part to a build.
- `DELETE /api/builds/[id]/items?slot_type=CPU` removes a part from a build.
- `GET /api/builds/[id]/compatible/ram` lists memory that matches the build's motherboard.

### Orders

- `GET /api/orders?userId=1` lists orders, optionally for one user.
- `POST /api/orders` creates an order from a build.
- `GET /api/orders/[id]` returns one order with its items.
- `PATCH /api/orders/[id]` updates an order's status.
- `DELETE /api/orders/[id]` deletes an order; only pending orders can be deleted.

### Other

- `GET /api/users` lists users with their build and order counts.
- `GET /api/health` reports database status and row counts.
