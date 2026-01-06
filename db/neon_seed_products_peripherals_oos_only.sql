-- Paste this into the Neon SQL Editor for your `neondb` database:
-- https://console.neon.tech/app/projects/spring-king-03823268/branches/br-proud-leaf-ah9or1ks/sql-editor?database=neondb
--
-- Out-of-stock ONLY (stock_qty = 0) inserts for:
-- cooler, headset, keyboard, monitor, mouse
--
-- Safe to run multiple times:
-- - Uses a NOT EXISTS guard on (category_id, name, brand, model) to prevent duplicates.

-- =========================
-- CPU COOLERS (slug: cooler)
-- =========================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'cooler')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price,
  0 AS stock_qty,
  0 AS power_watts,
  v.rating, v.description
FROM cat
CROSS JOIN (
  VALUES
    ('Noctua NH-L9i-17xx chromax.black', 'Noctua', 'NH-L9i-17xx chromax.black', 59.95, 4.6, 'Low-profile CPU cooler for small form factor builds'),
    ('be quiet! Pure Rock 2', 'be quiet!', 'Pure Rock 2', 44.90, 4.5, 'Quiet tower CPU cooler designed for entry to mid-range systems'),
    ('DeepCool LS720', 'DeepCool', 'LS720', 139.99, 4.6, '360mm AIO liquid CPU cooler with ARGB fans'),
    ('NZXT Kraken Z73', 'NZXT', 'Kraken Z73', 279.99, 4.5, '360mm AIO liquid CPU cooler with LCD display'),
    ('Corsair iCUE H170i ELITE CAPELLIX XT', 'Corsair', 'H170i ELITE CAPELLIX XT', 299.99, 4.5, '420mm AIO liquid CPU cooler with iCUE support')
) AS v(name, brand, model, price, rating, description)
WHERE NOT EXISTS (
  SELECT 1
  FROM Product p
  WHERE p.category_id = cat.category_id
    AND p.name = v.name
    AND p.brand = v.brand
    AND COALESCE(p.model, '') = COALESCE(v.model, '')
);

-- ======================
-- HEADSETS (slug: headset)
-- ======================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'headset')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price,
  0 AS stock_qty,
  0 AS power_watts,
  v.rating, v.description
FROM cat
CROSS JOIN (
  VALUES
    ('Logitech G Astro A40 TR + MixAmp Pro TR', 'Logitech G', 'A40 TR + MixAmp Pro TR', 249.99, 4.4, 'Wired gaming headset bundle with MixAmp for audio control'),
    ('Sennheiser GAME ONE', 'Sennheiser', 'GAME ONE', 129.95, 4.5, 'Open-back gaming headset with integrated microphone'),
    ('Bose QuietComfort 35 II Gaming Headset', 'Bose', 'QC35 II Gaming', 329.00, 4.4, 'Gaming headset based on QuietComfort headphones with boom mic accessory'),
    ('Razer Kraken Kitty V2', 'Razer', 'Kraken Kitty V2', 99.99, 4.3, 'Wired gaming headset with kitty ear design and RGB lighting'),
    ('Audio-Technica ATH-M50xSTS', 'Audio-Technica', 'ATH-M50xSTS', 199.00, 4.5, 'Studio headphone with integrated streaming microphone')
) AS v(name, brand, model, price, rating, description)
WHERE NOT EXISTS (
  SELECT 1
  FROM Product p
  WHERE p.category_id = cat.category_id
    AND p.name = v.name
    AND p.brand = v.brand
    AND COALESCE(p.model, '') = COALESCE(v.model, '')
);

-- =======================
-- KEYBOARDS (slug: keyboard)
-- =======================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'keyboard')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price,
  0 AS stock_qty,
  0 AS power_watts,
  v.rating, v.description
FROM cat
CROSS JOIN (
  VALUES
    ('Corsair K100 RGB', 'Corsair', 'K100 RGB', 249.99, 4.4, 'Flagship mechanical gaming keyboard with macro controls and RGB'),
    ('Razer Huntsman Mini', 'Razer', 'Huntsman Mini', 119.99, 4.4, 'Compact 60% optical gaming keyboard'),
    ('SteelSeries Apex 7', 'SteelSeries', 'Apex 7', 149.99, 4.4, 'Mechanical gaming keyboard with OLED smart display'),
    ('Logitech MX Keys', 'Logitech', 'MX Keys', 119.99, 4.5, 'Wireless illuminated keyboard for productivity'),
    ('Logitech G413 SE', 'Logitech G', 'G413 SE', 69.99, 4.3, 'Mechanical gaming keyboard with durable aluminum top case')
) AS v(name, brand, model, price, rating, description)
WHERE NOT EXISTS (
  SELECT 1
  FROM Product p
  WHERE p.category_id = cat.category_id
    AND p.name = v.name
    AND p.brand = v.brand
    AND COALESCE(p.model, '') = COALESCE(v.model, '')
);

-- ======================
-- MONITORS (slug: monitor)
-- ======================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'monitor')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price,
  0 AS stock_qty,
  0 AS power_watts,
  v.rating, v.description
FROM cat
CROSS JOIN (
  VALUES
    ('Alienware AW3423DWF', 'Alienware', 'AW3423DWF', 999.99, 4.6, '34-inch QD-OLED ultrawide gaming monitor'),
    ('BenQ ZOWIE XL2546K', 'BenQ', 'XL2546K', 499.99, 4.5, '24.5-inch esports gaming monitor with high refresh rate'),
    ('ASUS ProArt PA278CV', 'ASUS', 'PA278CV', 329.99, 4.5, '27-inch QHD professional monitor with USB-C'),
    ('Samsung Smart Monitor M8', 'Samsung', 'Smart Monitor M8', 699.99, 4.3, '32-inch smart monitor with streaming apps and USB-C'),
    ('LG OLED evo C2 42-inch', 'LG', 'OLED42C2', 999.99, 4.6, '42-inch OLED display often used as a gaming monitor')
) AS v(name, brand, model, price, rating, description)
WHERE NOT EXISTS (
  SELECT 1
  FROM Product p
  WHERE p.category_id = cat.category_id
    AND p.name = v.name
    AND p.brand = v.brand
    AND COALESCE(p.model, '') = COALESCE(v.model, '')
);

-- ====================
-- MICE (slug: mouse)
-- ====================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'mouse')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price,
  0 AS stock_qty,
  0 AS power_watts,
  v.rating, v.description
FROM cat
CROSS JOIN (
  VALUES
    ('Logitech MX Master 3S', 'Logitech', 'MX Master 3S', 99.99, 4.6, 'Wireless mouse designed for productivity with MagSpeed scrolling'),
    ('Logitech MX Anywhere 3', 'Logitech', 'MX Anywhere 3', 79.99, 4.5, 'Compact wireless mouse for travel and multi-device use'),
    ('Razer Orochi V2', 'Razer', 'Orochi V2', 69.99, 4.4, 'Compact wireless gaming mouse designed for portability'),
    ('Razer Viper Mini', 'Razer', 'Viper Mini', 39.99, 4.5, 'Lightweight wired gaming mouse for small-to-medium hands'),
    ('SteelSeries Rival 3', 'SteelSeries', 'Rival 3', 29.99, 4.3, 'Wired gaming mouse designed for durability and performance')
) AS v(name, brand, model, price, rating, description)
WHERE NOT EXISTS (
  SELECT 1
  FROM Product p
  WHERE p.category_id = cat.category_id
    AND p.name = v.name
    AND p.brand = v.brand
    AND COALESCE(p.model, '') = COALESCE(v.model, '')
);

-- Verification
SELECT
  c.slug,
  COUNT(*) FILTER (WHERE p.stock_qty > 0)::int AS in_stock,
  COUNT(*) FILTER (WHERE p.stock_qty = 0)::int AS out_of_stock
FROM Category c
LEFT JOIN Product p ON p.category_id = c.category_id
WHERE c.slug IN ('cooler', 'headset', 'keyboard', 'monitor', 'mouse')
GROUP BY c.slug
ORDER BY c.slug ASC;


