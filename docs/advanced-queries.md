# Advanced SQL Queries

## COMP306 Database Management Systems Project
## PC Builder Store - Advanced SQL Queries Documentation

This document describes the 5 sophisticated SQL queries used in our project, as required by the COMP306 rubric. Each query uses advanced SQL features (nested queries, GROUP BY with HAVING, aggregate functions, etc.) and is meaningfully integrated into the application's UI.

---

## Query 1: Compatible Motherboards
**Type:** Nested Subquery + JOIN  
**Location:** `/api/builds/[id]/compatible/motherboards`  
**UI Integration:** Builder page → "Compatible Motherboards" button

### Purpose
Finds all motherboards that are compatible with the CPU selected in the user's build. Compatibility is determined by matching CPU socket to motherboard socket.

### SQL Query
```sql
SELECT 
  p.product_id, p.name, p.brand, p.model, p.price, 
  p.stock_qty, p.power_watts, p.rating, p.image_url, p.description,
  m.socket, m.form_factor, m.ram_type, m.max_ram_gb, m.ram_slots,
  c.name AS category_name, c.slug AS category_slug
FROM Product p
JOIN MOBO_Spec m ON m.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
WHERE c.slug = 'motherboard'
  AND p.stock_qty > 0
  AND m.socket = (
    /* Nested subquery: Get the socket of CPU in this build */
    SELECT cpu_spec.socket
    FROM BuildItem bi
    JOIN CPU_Spec cpu_spec ON cpu_spec.product_id = bi.product_id
    WHERE bi.build_id = ? AND bi.slot_type = 'CPU'
  )
ORDER BY p.rating DESC, p.price ASC
```

### Advanced Features
- **Nested Subquery**: The WHERE clause contains a subquery that retrieves the CPU socket from the build
- **Multiple JOINs**: Connects Product, MOBO_Spec, and Category tables
- **Dynamic Filtering**: Only returns motherboards matching the selected CPU's socket

---

## Query 2: Compatible Cases
**Type:** Multiple Nested Subqueries  
**Location:** `/api/builds/[id]/compatible/cases`  
**UI Integration:** Builder page → "Compatible Cases" button

### Purpose
Finds cases that can physically fit both the selected GPU (by length) and motherboard (by form factor).

### SQL Query
```sql
SELECT 
  p.product_id, p.name, p.brand, p.model, p.price, 
  p.stock_qty, p.power_watts, p.rating, p.image_url, p.description,
  cs.max_gpu_length_mm, cs.supported_form_factor, 
  cs.max_psu_length_mm, cs.drive_bays_25, cs.drive_bays_35,
  c.name AS category_name, c.slug AS category_slug
FROM Product p
JOIN CASE_Spec cs ON cs.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
WHERE c.slug = 'case'
  AND p.stock_qty > 0
  /* Subquery #1: Check GPU length compatibility */
  AND cs.max_gpu_length_mm >= COALESCE(
    (
      SELECT g.length_mm
      FROM BuildItem bi
      JOIN GPU_Spec g ON g.product_id = bi.product_id
      WHERE bi.build_id = ? AND bi.slot_type = 'GPU'
    ), 0
  )
  /* Subquery #2: Check form factor compatibility */
  AND (
    cs.supported_form_factor = 'ATX' 
    OR cs.supported_form_factor = COALESCE(
      (
        SELECT m.form_factor
        FROM BuildItem bi
        JOIN MOBO_Spec m ON m.product_id = bi.product_id
        WHERE bi.build_id = ? AND bi.slot_type = 'MOBO'
      ), cs.supported_form_factor
    )
    OR (
      cs.supported_form_factor = 'Micro-ATX' 
      AND COALESCE(
        (
          SELECT m.form_factor
          FROM BuildItem bi
          JOIN MOBO_Spec m ON m.product_id = bi.product_id
          WHERE bi.build_id = ? AND bi.slot_type = 'MOBO'
        ), 'Mini-ITX'
      ) IN ('Micro-ATX', 'Mini-ITX')
    )
  )
ORDER BY p.rating DESC, p.price ASC
```

### Advanced Features
- **Multiple Independent Subqueries**: Two separate subqueries for GPU and motherboard compatibility
- **COALESCE Function**: Handles cases where GPU or motherboard hasn't been selected yet
- **Complex Boolean Logic**: Implements form factor hierarchy (ATX > Micro-ATX > Mini-ITX)

---

## Query 3: PSU Recommendation
**Type:** Aggregate Function + Nested Subquery with Calculation  
**Location:** `/api/builds/[id]/recommend/psu`  
**UI Integration:** Builder page → "Recommend PSU" button

### Purpose
Recommends PSUs that can handle the total power consumption of all parts in the build, with a 20% safety overhead.

### SQL Query
```sql
SELECT 
  p.product_id, p.name, p.brand, p.model, p.price, 
  p.stock_qty, p.power_watts, p.rating, p.image_url, p.description,
  ps.wattage, ps.efficiency_rating, ps.modular, ps.psu_length_mm,
  c.name AS category_name, c.slug AS category_slug,
  /* Calculate headroom: how much extra wattage this PSU provides */
  (ps.wattage - CEIL(1.2 * (
    SELECT COALESCE(SUM(pr.power_watts), 0)
    FROM BuildItem bi
    JOIN Product pr ON pr.product_id = bi.product_id
    WHERE bi.build_id = ?
  ))) AS headroom_watts
FROM Product p
JOIN PSU_Spec ps ON ps.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
WHERE c.slug = 'psu'
  AND p.stock_qty > 0
  /* PSU wattage must be at least 1.2x total build power */
  AND ps.wattage >= CEIL(1.2 * (
    SELECT COALESCE(SUM(pr.power_watts), 0)
    FROM BuildItem bi
    JOIN Product pr ON pr.product_id = bi.product_id
    WHERE bi.build_id = ?
  ))
ORDER BY ps.wattage ASC, p.rating DESC, p.price ASC
```

### Advanced Features
- **SUM Aggregate**: Calculates total power consumption across all build items
- **CEIL Function**: Rounds up for safety margin
- **Mathematical Calculation**: Multiplies by 1.2 for 20% headroom
- **Derived Column**: Calculates headroom_watts showing extra capacity

---

## Query 4: Deals (Products Below Category Average)
**Type:** Correlated Subquery with AVG Aggregate  
**Location:** `/api/deals`  
**UI Integration:** Deals page, Home page deals section

### Purpose
Finds products that are priced below their category's average price - identifying "deals" or good value products.

### SQL Query
```sql
SELECT 
  p.product_id, p.name, p.brand, p.model, p.price, 
  p.stock_qty, p.power_watts, p.rating, p.image_url, p.description,
  c.name AS category_name, c.slug AS category_slug,
  /* Correlated subquery: Calculate average price for THIS product's category */
  (
    SELECT AVG(p2.price)
    FROM Product p2
    WHERE p2.category_id = p.category_id
  ) AS category_avg_price,
  /* Calculate savings: how much below average this product is */
  (
    (
      SELECT AVG(p2.price)
      FROM Product p2
      WHERE p2.category_id = p.category_id
    ) - p.price
  ) AS savings_amount,
  /* Calculate savings percentage */
  ROUND(
    (
      (
        (
          SELECT AVG(p2.price)
          FROM Product p2
          WHERE p2.category_id = p.category_id
        ) - p.price
      ) / (
        SELECT AVG(p2.price)
        FROM Product p2
        WHERE p2.category_id = p.category_id
      ) * 100
    ), 1
  ) AS savings_percentage
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE p.stock_qty > 0
  /* Only show products BELOW their category average */
  AND p.price < (
    SELECT AVG(p2.price)
    FROM Product p2
    WHERE p2.category_id = p.category_id
  )
ORDER BY savings_percentage DESC, p.rating DESC
```

### Advanced Features
- **Correlated Subquery**: Inner query references outer query's `category_id`
- **AVG Aggregate**: Calculates category-specific average prices
- **Multiple Derived Columns**: Computes category_avg_price, savings_amount, savings_percentage
- **ROUND Function**: Formats percentage to one decimal place

---

## Query 5: Top Brands
**Type:** GROUP BY + HAVING with Multiple Aggregates  
**Location:** `/api/top-brands`  
**UI Integration:** Top Brands page

### Purpose
Identifies the best brands in each category based on having sufficient product variety (3+ products) and high quality (4.0+ average rating).

### SQL Query
```sql
SELECT 
  c.name AS category_name,
  c.slug AS category_slug,
  p.brand,
  /* Aggregate functions over the group */
  COUNT(*) AS num_products,
  ROUND(AVG(p.rating), 2) AS avg_rating,
  ROUND(AVG(p.price), 2) AS avg_price,
  MIN(p.price) AS min_price,
  MAX(p.price) AS max_price,
  SUM(p.stock_qty) AS total_stock
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE p.stock_qty > 0
/* GROUP BY category and brand to aggregate per brand per category */
GROUP BY c.category_id, c.name, c.slug, p.brand
/* HAVING filters groups after aggregation */
/* Only include brands with enough products AND good ratings */
HAVING 
  COUNT(*) >= 3 
  AND AVG(p.rating) >= 4.0
ORDER BY c.name ASC, avg_rating DESC, num_products DESC
```

### Advanced Features
- **GROUP BY Multiple Columns**: Groups by both category and brand
- **HAVING Clause**: Filters groups based on aggregate conditions
- **Multiple Aggregate Functions**: COUNT, AVG, MIN, MAX, SUM
- **Post-Aggregation Filtering**: HAVING with multiple conditions

---

## Summary Table

| Query | Type | Advanced Features | UI Location |
|-------|------|-------------------|-------------|
| Q1 | Nested Subquery + JOIN | Subquery in WHERE, dynamic socket matching | Builder → Compatible Motherboards |
| Q2 | Multiple Nested Subqueries | Two subqueries, COALESCE, complex logic | Builder → Compatible Cases |
| Q3 | Aggregate + Nested Subquery | SUM, CEIL, 1.2x multiplier, derived column | Builder → Recommend PSU |
| Q4 | Correlated Subquery | AVG in correlated subquery, derived columns | Deals page |
| Q5 | GROUP BY + HAVING | Multiple aggregates, HAVING with conditions | Top Brands page |

---

## How to Test

1. Start the application: `npm run dev`
2. Visit `/builder` and create a new build
3. Add a CPU, then click "Compatible Motherboards" (Query 1)
4. Add GPU + Motherboard, then click "Compatible Cases" (Query 2)
5. Add any parts, then click "Recommend PSU" (Query 3)
6. Visit `/deals` page (Query 4)
7. Visit `/top-brands` page (Query 5)


