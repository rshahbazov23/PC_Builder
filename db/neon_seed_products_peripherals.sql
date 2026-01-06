-- Paste this into the Neon SQL Editor for your `neondb` database:
-- https://console.neon.tech/app/projects/spring-king-03823268/branches/br-proud-leaf-ah9or1ks/sql-editor?database=neondb
--
-- Inserts 20+ real products into each of these categories:
-- cooler, headset, keyboard, monitor, mouse
--
-- Notes:
-- - Prices are set as typical MSRP/retail USD values; adjust if you want different pricing.
-- - Safe category mapping: uses Category.slug (no hard-coded category_id).

-- =========================
-- CPU COOLERS (slug: cooler)
-- =========================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'cooler')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price, v.stock_qty, v.power_watts, v.rating, v.description
FROM (
  VALUES
    ('Noctua NH-D15 chromax.black', 'Noctua', 'NH-D15 chromax.black', 109.95, 30, 0, 4.8, 'Premium dual-tower air CPU cooler with dual 140mm fans'),
    ('Noctua NH-U12A', 'Noctua', 'NH-U12A', 119.95, 30, 0, 4.8, 'Premium 120mm-class air CPU cooler with dual fans'),
    ('Noctua NH-U12S redux', 'Noctua', 'NH-U12S redux', 54.95, 40, 0, 4.7, 'Streamlined 120mm air CPU cooler designed for excellent value'),
    ('be quiet! Dark Rock Pro 4', 'be quiet!', 'Dark Rock Pro 4', 89.90, 25, 0, 4.7, 'High-end dual-tower air CPU cooler designed for quiet operation'),
    ('be quiet! Dark Rock 4', 'be quiet!', 'Dark Rock 4', 74.90, 25, 0, 4.6, 'High-performance single-tower air CPU cooler with silent fan'),
    ('Cooler Master Hyper 212 Black Edition', 'Cooler Master', 'Hyper 212 Black Edition', 49.99, 50, 0, 4.5, 'Classic tower air CPU cooler with 120mm fan'),
    ('DeepCool AK620', 'DeepCool', 'AK620', 64.99, 40, 0, 4.6, 'Dual-tower air CPU cooler with dual 120mm fans'),
    ('DeepCool AK400', 'DeepCool', 'AK400', 34.99, 60, 0, 4.5, 'Tower air CPU cooler with 120mm fan for efficient cooling'),
    ('ARCTIC Liquid Freezer II 240', 'ARCTIC', 'Liquid Freezer II 240', 109.99, 30, 0, 4.7, '240mm all-in-one liquid CPU cooler'),
    ('ARCTIC Liquid Freezer II 360', 'ARCTIC', 'Liquid Freezer II 360', 139.99, 25, 0, 4.7, '360mm all-in-one liquid CPU cooler'),
    ('Corsair iCUE H100i RGB ELITE', 'Corsair', 'H100i RGB ELITE', 139.99, 25, 0, 4.6, '240mm AIO liquid CPU cooler with iCUE support'),
    ('Corsair iCUE H150i ELITE CAPELLIX XT', 'Corsair', 'H150i ELITE CAPELLIX XT', 229.99, 20, 0, 4.6, '360mm AIO liquid CPU cooler with high-performance fans'),
    ('NZXT Kraken 240', 'NZXT', 'Kraken 240', 139.99, 25, 0, 4.6, '240mm AIO liquid CPU cooler with LCD display'),
    ('NZXT Kraken 360', 'NZXT', 'Kraken 360', 179.99, 20, 0, 4.6, '360mm AIO liquid CPU cooler with LCD display'),
    ('Lian Li Galahad II Trinity 240', 'Lian Li', 'Galahad II Trinity 240', 129.99, 20, 0, 4.6, '240mm AIO liquid CPU cooler'),
    ('ASUS ROG Ryujin III 360', 'ASUS', 'ROG Ryujin III 360', 359.99, 10, 0, 4.6, 'Premium 360mm AIO liquid CPU cooler'),
    ('Thermalright Peerless Assassin 120 SE', 'Thermalright', 'Peerless Assassin 120 SE', 39.90, 50, 0, 4.6, 'Value dual-tower air CPU cooler with dual 120mm fans'),
    ('Scythe Fuma 2 Rev.B', 'Scythe', 'Fuma 2 Rev.B', 64.99, 25, 0, 4.6, 'Dual-tower air CPU cooler optimized for quiet operation'),
    ('EK-Nucleus AIO CR360 Lux D-RGB', 'EK', 'Nucleus AIO CR360 Lux D-RGB', 179.99, 15, 0, 4.6, '360mm AIO liquid CPU cooler with D-RGB lighting'),
    ('Cooler Master MasterLiquid ML240L V2 RGB', 'Cooler Master', 'MasterLiquid ML240L V2 RGB', 89.99, 30, 0, 4.5, '240mm AIO liquid CPU cooler with RGB lighting'),
    -- out of stock
    ('Noctua NH-L9i-17xx chromax.black', 'Noctua', 'NH-L9i-17xx chromax.black', 59.95, 0, 0, 4.6, 'Low-profile CPU cooler for small form factor builds'),
    ('be quiet! Pure Rock 2', 'be quiet!', 'Pure Rock 2', 44.90, 0, 0, 4.5, 'Quiet tower CPU cooler designed for entry to mid-range systems'),
    ('DeepCool LS720', 'DeepCool', 'LS720', 139.99, 0, 0, 4.6, '360mm AIO liquid CPU cooler with ARGB fans'),
    ('NZXT Kraken Z73', 'NZXT', 'Kraken Z73', 279.99, 0, 0, 4.5, '360mm AIO liquid CPU cooler with LCD display'),
    ('Corsair iCUE H170i ELITE CAPELLIX XT', 'Corsair', 'H170i ELITE CAPELLIX XT', 299.99, 0, 0, 4.5, '420mm AIO liquid CPU cooler with iCUE support')
) AS v(name, brand, model, price, stock_qty, power_watts, rating, description)
CROSS JOIN cat;

-- ======================
-- HEADSETS (slug: headset)
-- ======================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'headset')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price, v.stock_qty, v.power_watts, v.rating, v.description
FROM (
  VALUES
    ('SteelSeries Arctis Nova Pro Wireless', 'SteelSeries', 'Arctis Nova Pro Wireless', 349.99, 20, 0, 4.6, 'Wireless gaming headset with active noise cancellation and base station'),
    ('SteelSeries Arctis Nova 7', 'SteelSeries', 'Arctis Nova 7', 179.99, 25, 0, 4.5, 'Wireless multi-platform gaming headset with USB-C dongle and Bluetooth'),
    ('SteelSeries Arctis Nova 1', 'SteelSeries', 'Arctis Nova 1', 59.99, 40, 0, 4.4, 'Wired gaming headset with lightweight design and clear voice mic'),
    ('HyperX Cloud II', 'HyperX', 'Cloud II', 99.99, 35, 0, 4.5, 'Comfortable wired gaming headset with USB sound card'),
    ('HyperX Cloud Alpha Wireless', 'HyperX', 'Cloud Alpha Wireless', 199.99, 20, 0, 4.5, 'Wireless gaming headset known for long battery life'),
    ('Logitech G PRO X 2 LIGHTSPEED', 'Logitech G', 'PRO X 2 LIGHTSPEED', 249.99, 20, 0, 4.5, 'Wireless gaming headset with PRO-G audio drivers and detachable mic'),
    ('Logitech G733 LIGHTSPEED', 'Logitech G', 'G733 LIGHTSPEED', 149.99, 25, 0, 4.4, 'Lightweight wireless gaming headset with RGB lighting'),
    ('Razer BlackShark V2 Pro', 'Razer', 'BlackShark V2 Pro', 199.99, 20, 0, 4.5, 'Wireless esports headset with detachable microphone'),
    ('Razer Kraken V3 HyperSense', 'Razer', 'Kraken V3 HyperSense', 129.99, 20, 0, 4.4, 'Wired gaming headset with haptic feedback'),
    ('Razer Barracuda X', 'Razer', 'Barracuda X', 99.99, 25, 0, 4.4, 'Wireless headset with USB-C dongle for multi-platform use'),
    ('Corsair HS80 RGB Wireless', 'Corsair', 'HS80 RGB Wireless', 149.99, 25, 0, 4.4, 'Wireless gaming headset with immersive spatial audio support'),
    ('Corsair Virtuoso RGB Wireless XT', 'Corsair', 'Virtuoso RGB Wireless XT', 269.99, 15, 0, 4.4, 'Premium wireless gaming headset with dual wireless connections'),
    ('Sony INZONE H9', 'Sony', 'INZONE H9', 299.99, 15, 0, 4.4, 'Wireless gaming headset with noise cancellation'),
    ('Sony INZONE H7', 'Sony', 'INZONE H7', 229.99, 15, 0, 4.4, 'Wireless gaming headset with low-latency connection'),
    ('EPOS H6PRO Closed', 'EPOS', 'H6PRO Closed', 179.00, 15, 0, 4.4, 'Wired gaming headset with detachable microphone (closed-back)'),
    ('Sennheiser PC38X', 'Sennheiser', 'PC38X', 169.00, 20, 0, 4.6, 'Open-back gaming headset with broadcast-quality microphone'),
    ('Astro A50 Wireless + Base Station', 'ASTRO', 'A50 Wireless', 299.99, 10, 0, 4.4, 'Wireless gaming headset with base station dock'),
    ('Turtle Beach Stealth 700 Gen 2 MAX', 'Turtle Beach', 'Stealth 700 Gen 2 MAX', 199.99, 15, 0, 4.4, 'Wireless gaming headset with long battery life'),
    ('Beyerdynamic MMX 300 (2nd Generation)', 'beyerdynamic', 'MMX 300 (2nd Gen)', 299.00, 10, 0, 4.6, 'Closed-back gaming headset with studio-grade sound'),
    ('JBL Quantum 910 Wireless', 'JBL', 'Quantum 910 Wireless', 299.95, 10, 0, 4.4, 'Wireless gaming headset with spatial audio support'),
    -- out of stock
    ('Logitech G Astro A40 TR + MixAmp Pro TR', 'Logitech G', 'A40 TR + MixAmp Pro TR', 249.99, 0, 0, 4.4, 'Wired gaming headset bundle with MixAmp for audio control'),
    ('Sennheiser GAME ONE', 'Sennheiser', 'GAME ONE', 129.95, 0, 0, 4.5, 'Open-back gaming headset with integrated microphone'),
    ('Bose QuietComfort 35 II Gaming Headset', 'Bose', 'QC35 II Gaming', 329.00, 0, 0, 4.4, 'Gaming headset based on QuietComfort headphones with boom mic accessory'),
    ('Razer Kraken Kitty V2', 'Razer', 'Kraken Kitty V2', 99.99, 0, 0, 4.3, 'Wired gaming headset with kitty ear design and RGB lighting'),
    ('Audio-Technica ATH-M50xSTS', 'Audio-Technica', 'ATH-M50xSTS', 199.00, 0, 0, 4.5, 'Studio headphone with integrated streaming microphone')
) AS v(name, brand, model, price, stock_qty, power_watts, rating, description)
CROSS JOIN cat;

-- =======================
-- KEYBOARDS (slug: keyboard)
-- =======================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'keyboard')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price, v.stock_qty, v.power_watts, v.rating, v.description
FROM (
  VALUES
    ('Keychron Q1', 'Keychron', 'Q1', 169.00, 20, 0, 4.5, 'Customizable mechanical keyboard with aluminum case'),
    ('Keychron K2', 'Keychron', 'K2', 79.00, 30, 0, 4.4, 'Compact 75% wireless mechanical keyboard'),
    ('Keychron K8 Pro', 'Keychron', 'K8 Pro', 109.00, 25, 0, 4.4, 'Tenkeyless wireless mechanical keyboard with QMK/VIA support'),
    ('Logitech G PRO X TKL', 'Logitech G', 'PRO X TKL', 199.99, 20, 0, 4.5, 'Tournament-grade tenkeyless gaming keyboard'),
    ('Logitech G915 TKL', 'Logitech G', 'G915 TKL', 229.99, 15, 0, 4.4, 'Wireless low-profile mechanical gaming keyboard'),
    ('Corsair K70 RGB PRO', 'Corsair', 'K70 RGB PRO', 169.99, 20, 0, 4.4, 'Mechanical gaming keyboard with aluminum frame and per-key RGB'),
    ('Corsair K65 RGB MINI', 'Corsair', 'K65 RGB MINI', 109.99, 20, 0, 4.4, 'Compact 60% mechanical gaming keyboard'),
    ('Razer Huntsman V2', 'Razer', 'Huntsman V2', 189.99, 15, 0, 4.4, 'Optical gaming keyboard designed for fast actuation'),
    ('Razer BlackWidow V4', 'Razer', 'BlackWidow V4', 169.99, 15, 0, 4.4, 'Mechanical gaming keyboard with per-key RGB'),
    ('SteelSeries Apex Pro TKL', 'SteelSeries', 'Apex Pro TKL', 189.99, 15, 0, 4.5, 'Adjustable actuation mechanical gaming keyboard (TKL)'),
    ('SteelSeries Apex 3', 'SteelSeries', 'Apex 3', 49.99, 35, 0, 4.3, 'RGB gaming keyboard with quiet switches and IP32 resistance'),
    ('Ducky One 3 Mini', 'Ducky', 'One 3 Mini', 119.00, 20, 0, 4.5, '60% mechanical keyboard with hot-swappable switches'),
    ('Ducky One 3 TKL', 'Ducky', 'One 3 TKL', 129.00, 20, 0, 4.5, 'Tenkeyless mechanical keyboard with hot-swappable switches'),
    ('Glorious GMMK Pro', 'Glorious', 'GMMK Pro', 169.99, 20, 0, 4.4, '75% barebones mechanical keyboard with rotary knob'),
    ('Glorious GMMK 2', 'Glorious', 'GMMK 2', 119.99, 20, 0, 4.4, 'Compact mechanical keyboard with hot-swappable sockets'),
    ('ASUS ROG Strix Scope II 96', 'ASUS', 'ROG Strix Scope II 96', 179.99, 15, 0, 4.4, '96% gaming keyboard with compact layout and RGB'),
    ('ASUS ROG Claymore II', 'ASUS', 'ROG Claymore II', 249.99, 10, 0, 4.4, 'Modular wireless mechanical gaming keyboard with detachable numpad'),
    ('HyperX Alloy Origins', 'HyperX', 'Alloy Origins', 109.99, 20, 0, 4.4, 'Compact mechanical gaming keyboard with aluminum body and RGB'),
    ('HyperX Alloy FPS Pro', 'HyperX', 'Alloy FPS Pro', 69.99, 25, 0, 4.3, 'Tenkeyless mechanical gaming keyboard'),
    ('Wooting 60HE', 'Wooting', '60HE', 174.99, 15, 0, 4.6, '60% analog mechanical keyboard with rapid trigger capability'),
    -- out of stock
    ('Corsair K100 RGB', 'Corsair', 'K100 RGB', 249.99, 0, 0, 4.4, 'Flagship mechanical gaming keyboard with macro controls and RGB'),
    ('Razer Huntsman Mini', 'Razer', 'Huntsman Mini', 119.99, 0, 0, 4.4, 'Compact 60% optical gaming keyboard'),
    ('SteelSeries Apex 7', 'SteelSeries', 'Apex 7', 149.99, 0, 0, 4.4, 'Mechanical gaming keyboard with OLED smart display'),
    ('Logitech MX Keys', 'Logitech', 'MX Keys', 119.99, 0, 0, 4.5, 'Wireless illuminated keyboard for productivity'),
    ('Logitech G413 SE', 'Logitech G', 'G413 SE', 69.99, 0, 0, 4.3, 'Mechanical gaming keyboard with durable aluminum top case')
) AS v(name, brand, model, price, stock_qty, power_watts, rating, description)
CROSS JOIN cat;

-- ======================
-- MONITORS (slug: monitor)
-- ======================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'monitor')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price, v.stock_qty, v.power_watts, v.rating, v.description
FROM (
  VALUES
    ('Dell UltraSharp U2723QE', 'Dell', 'U2723QE', 619.99, 10, 0, 4.6, '27-inch 4K UHD IPS monitor with USB-C hub'),
    ('Dell S2721DGF', 'Dell', 'S2721DGF', 449.99, 10, 0, 4.5, '27-inch QHD gaming monitor with high refresh rate'),
    ('LG 27GP850-B', 'LG', '27GP850-B', 399.99, 12, 0, 4.6, '27-inch QHD gaming monitor with fast IPS panel'),
    ('LG 27GL850-B', 'LG', '27GL850-B', 349.99, 12, 0, 4.5, '27-inch QHD Nano IPS gaming monitor'),
    ('LG 32GQ950-B', 'LG', '32GQ950-B', 899.99, 6, 0, 4.5, '32-inch 4K gaming monitor designed for high detail'),
    ('Samsung Odyssey G7 32-inch', 'Samsung', 'Odyssey G7', 699.99, 6, 0, 4.4, '32-inch curved QHD gaming monitor'),
    ('Samsung Odyssey G9', 'Samsung', 'Odyssey G9', 1399.99, 4, 0, 4.4, '49-inch super ultrawide curved gaming monitor'),
    ('ASUS TUF Gaming VG27AQ', 'ASUS', 'VG27AQ', 329.99, 10, 0, 4.4, '27-inch QHD gaming monitor'),
    ('ASUS ROG Swift PG279QM', 'ASUS', 'PG279QM', 799.99, 5, 0, 4.5, '27-inch QHD esports gaming monitor'),
    ('ASUS ROG Swift OLED PG27AQDM', 'ASUS', 'PG27AQDM', 999.99, 4, 0, 4.6, '27-inch OLED gaming monitor'),
    ('Gigabyte M27Q', 'Gigabyte', 'M27Q', 299.99, 12, 0, 4.4, '27-inch QHD gaming monitor'),
    ('Gigabyte M32U', 'Gigabyte', 'M32U', 649.99, 6, 0, 4.5, '32-inch 4K gaming monitor'),
    ('Acer Nitro XV272U', 'Acer', 'XV272U', 299.99, 10, 0, 4.4, '27-inch QHD gaming monitor'),
    ('Acer Predator XB273U GX', 'Acer', 'XB273U GX', 699.99, 5, 0, 4.4, '27-inch QHD esports gaming monitor'),
    ('BenQ MOBIUZ EX2710Q', 'BenQ', 'EX2710Q', 399.99, 8, 0, 4.4, '27-inch QHD gaming monitor with HDRi'),
    ('BenQ PD2705U', 'BenQ', 'PD2705U', 549.99, 6, 0, 4.5, '27-inch 4K UHD designer monitor'),
    ('MSI Optix MAG274QRF-QD', 'MSI', 'MAG274QRF-QD', 449.99, 8, 0, 4.5, '27-inch QHD gaming monitor with wide color'),
    ('ViewSonic Elite XG270QG', 'ViewSonic', 'XG270QG', 599.99, 6, 0, 4.4, '27-inch QHD gaming monitor'),
    ('HP OMEN 27qs', 'HP', 'OMEN 27qs', 349.99, 8, 0, 4.4, '27-inch QHD gaming monitor'),
    ('AOC CQ27G2', 'AOC', 'CQ27G2', 249.99, 10, 0, 4.3, '27-inch curved QHD gaming monitor'),
    -- out of stock
    ('Alienware AW3423DWF', 'Alienware', 'AW3423DWF', 999.99, 0, 0, 4.6, '34-inch QD-OLED ultrawide gaming monitor'),
    ('BenQ ZOWIE XL2546K', 'BenQ', 'XL2546K', 499.99, 0, 0, 4.5, '24.5-inch esports gaming monitor with high refresh rate'),
    ('ASUS ProArt PA278CV', 'ASUS', 'PA278CV', 329.99, 0, 0, 4.5, '27-inch QHD professional monitor with USB-C'),
    ('Samsung Smart Monitor M8', 'Samsung', 'Smart Monitor M8', 699.99, 0, 0, 4.3, '32-inch smart monitor with streaming apps and USB-C'),
    ('LG OLED evo C2 42-inch', 'LG', 'OLED42C2', 999.99, 0, 0, 4.6, '42-inch OLED display often used as a gaming monitor')
) AS v(name, brand, model, price, stock_qty, power_watts, rating, description)
CROSS JOIN cat;

-- ====================
-- MICE (slug: mouse)
-- ====================
WITH cat AS (SELECT category_id FROM Category WHERE slug = 'mouse')
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description)
SELECT
  cat.category_id,
  v.name, v.brand, v.model, v.price, v.stock_qty, v.power_watts, v.rating, v.description
FROM (
  VALUES
    ('Logitech G PRO X SUPERLIGHT 2', 'Logitech G', 'PRO X SUPERLIGHT 2', 159.99, 20, 0, 4.6, 'Ultra-lightweight wireless gaming mouse'),
    ('Logitech G502 X', 'Logitech G', 'G502 X', 79.99, 30, 0, 4.6, 'Wired gaming mouse with customizable controls'),
    ('Logitech G305 LIGHTSPEED', 'Logitech G', 'G305 LIGHTSPEED', 59.99, 35, 0, 4.5, 'Wireless gaming mouse with LIGHTSPEED connection'),
    ('Logitech G703 LIGHTSPEED', 'Logitech G', 'G703 LIGHTSPEED', 99.99, 20, 0, 4.5, 'Wireless ergonomic gaming mouse'),
    ('Logitech G903 LIGHTSPEED', 'Logitech G', 'G903 LIGHTSPEED', 149.99, 15, 0, 4.4, 'Wireless gaming mouse with ambidextrous design'),
    ('Razer DeathAdder V3 Pro', 'Razer', 'DeathAdder V3 Pro', 149.99, 20, 0, 4.6, 'Wireless ergonomic esports mouse'),
    ('Razer Viper V2 Pro', 'Razer', 'Viper V2 Pro', 149.99, 15, 0, 4.6, 'Ultra-lightweight wireless esports mouse'),
    ('Razer Basilisk V3', 'Razer', 'Basilisk V3', 69.99, 25, 0, 4.5, 'Wired customizable gaming mouse with RGB lighting'),
    ('Razer Naga V2 Pro', 'Razer', 'Naga V2 Pro', 179.99, 10, 0, 4.5, 'Wireless MMO gaming mouse with modular side plates'),
    ('SteelSeries Rival 600', 'SteelSeries', 'Rival 600', 79.99, 20, 0, 4.4, 'Wired gaming mouse with dual sensor system'),
    ('SteelSeries Aerox 3 Wireless', 'SteelSeries', 'Aerox 3 Wireless', 99.99, 20, 0, 4.4, 'Ultra-lightweight wireless gaming mouse'),
    ('SteelSeries Prime Wireless', 'SteelSeries', 'Prime Wireless', 129.99, 15, 0, 4.4, 'Wireless esports mouse with ergonomic shape'),
    ('Corsair M65 RGB ULTRA', 'Corsair', 'M65 RGB ULTRA', 79.99, 20, 0, 4.4, 'Wired FPS gaming mouse with adjustable weights'),
    ('Corsair HARPOON RGB WIRELESS', 'Corsair', 'HARPOON RGB WIRELESS', 59.99, 25, 0, 4.3, 'Wireless gaming mouse with compact ergonomic design'),
    ('Corsair DARK CORE RGB PRO SE', 'Corsair', 'DARK CORE RGB PRO SE', 89.99, 20, 0, 4.3, 'Wireless gaming mouse with Qi wireless charging support'),
    ('Glorious Model O Wireless', 'Glorious', 'Model O Wireless', 79.99, 20, 0, 4.4, 'Ultra-lightweight wireless gaming mouse with honeycomb shell'),
    ('Glorious Model D', 'Glorious', 'Model D', 49.99, 25, 0, 4.4, 'Ergonomic lightweight gaming mouse'),
    ('Zowie EC2-C', 'Zowie', 'EC2-C', 69.99, 20, 0, 4.4, 'Ergonomic esports mouse designed for competitive play'),
    ('Zowie FK2-C', 'Zowie', 'FK2-C', 69.99, 20, 0, 4.4, 'Ambidextrous esports mouse designed for competitive play'),
    ('HyperX Pulsefire Haste 2 Wireless', 'HyperX', 'Pulsefire Haste 2 Wireless', 89.99, 20, 0, 4.4, 'Lightweight wireless gaming mouse'),
    -- out of stock
    ('Logitech MX Master 3S', 'Logitech', 'MX Master 3S', 99.99, 0, 0, 4.6, 'Wireless mouse designed for productivity with MagSpeed scrolling'),
    ('Logitech MX Anywhere 3', 'Logitech', 'MX Anywhere 3', 79.99, 0, 0, 4.5, 'Compact wireless mouse for travel and multi-device use'),
    ('Razer Orochi V2', 'Razer', 'Orochi V2', 69.99, 0, 0, 4.4, 'Compact wireless gaming mouse designed for portability'),
    ('Razer Viper Mini', 'Razer', 'Viper Mini', 39.99, 0, 0, 4.5, 'Lightweight wired gaming mouse for small-to-medium hands'),
    ('SteelSeries Rival 3', 'SteelSeries', 'Rival 3', 29.99, 0, 0, 4.3, 'Wired gaming mouse designed for durability and performance')
) AS v(name, brand, model, price, stock_qty, power_watts, rating, description)
CROSS JOIN cat;

-- Verification
SELECT c.slug, c.name, COUNT(p.product_id)::int AS product_count
FROM Category c
LEFT JOIN Product p ON p.category_id = c.category_id
WHERE c.slug IN ('cooler', 'headset', 'keyboard', 'monitor', 'mouse')
GROUP BY c.slug, c.name
ORDER BY c.slug ASC;


