-- ============================================================================
-- COMBINED SEED FILE FOR PC BUILDER DATABASE
-- ============================================================================
-- This file can be pasted into Neon SQL Editor and safely rerun.
-- It will clear all existing data and repopulate the database.
-- ============================================================================

-- Clear all existing data (order matters due to foreign keys)
TRUNCATE TABLE OrderItem, Orders, BuildItem, Build, 
               Storage_Spec, PSU_Spec, CASE_Spec, RAM_Spec, GPU_Spec, MOBO_Spec, CPU_Spec,
               Product, "User", Category
CASCADE;

-- Reset sequences
ALTER SEQUENCE category_category_id_seq RESTART WITH 1;
ALTER SEQUENCE "User_user_id_seq" RESTART WITH 1;
ALTER SEQUENCE product_product_id_seq RESTART WITH 1;
ALTER SEQUENCE build_build_id_seq RESTART WITH 1;
ALTER SEQUENCE builditem_build_item_id_seq RESTART WITH 1;
ALTER SEQUENCE orders_order_id_seq RESTART WITH 1;
ALTER SEQUENCE orderitem_order_item_id_seq RESTART WITH 1;

-- ============================================================================
-- CATEGORIES
-- ============================================================================
INSERT INTO Category (name, slug, description, icon) VALUES
('CPU', 'cpu', 'Central Processing Units - The brain of your computer', 'cpu'),
('GPU', 'gpu', 'Graphics Processing Units - For gaming and creative work', 'gpu'),
('Motherboard', 'motherboard', 'The backbone that connects all components', 'motherboard'),
('RAM', 'ram', 'Random Access Memory - Fast temporary storage', 'ram'),
('PSU', 'psu', 'Power Supply Units - Reliable power for your system', 'psu'),
('Case', 'case', 'Computer Cases - House your components in style', 'case'),
('Storage', 'storage', 'SSDs and HDDs - Store your data', 'storage'),
('CPU Cooler', 'cooler', 'Air and liquid coolers to keep your CPU at safe temps', 'cooler'),
('Monitor', 'monitor', 'Displays for gaming and productivity', 'monitor'),
('Keyboard', 'keyboard', 'Mechanical and membrane keyboards', 'keyboard'),
('Mouse', 'mouse', 'Wired and wireless mice', 'mouse'),
('Headset', 'headset', 'Audio headsets for gaming and calls', 'headset');

-- ============================================================================
-- USERS
-- ============================================================================
INSERT INTO "User" (username, email) VALUES
('demo_user', 'demo@pcbuilder.com'),
('admin', 'admin@pcbuilder.com');

-- ============================================================================
-- PRODUCTS - CPUs (category_id = 1)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(1, 'Intel Core i9-14900K', 'Intel', 'i9-14900K', 549.99, 25, 125, 4.8, 'Flagship 24-core processor with incredible performance'),
(1, 'Intel Core i9-14900KF', 'Intel', 'i9-14900KF', 524.99, 30, 125, 4.7, '24-core processor without integrated graphics'),
(1, 'Intel Core i7-14700K', 'Intel', 'i7-14700K', 399.99, 45, 125, 4.8, '20-core processor, excellent for gaming and productivity'),
(1, 'Intel Core i7-14700KF', 'Intel', 'i7-14700KF', 379.99, 40, 125, 4.7, '20-core processor without integrated graphics'),
(1, 'Intel Core i5-14600K', 'Intel', 'i5-14600K', 299.99, 60, 125, 4.7, '14-core processor, great value for gamers'),
(1, 'Intel Core i5-14600KF', 'Intel', 'i5-14600KF', 279.99, 55, 125, 4.6, '14-core processor without integrated graphics'),
(1, 'Intel Core i5-14400F', 'Intel', 'i5-14400F', 199.99, 80, 65, 4.5, 'Budget-friendly 10-core processor'),
(1, 'Intel Core i3-14100F', 'Intel', 'i3-14100F', 119.99, 100, 58, 4.4, 'Entry-level 4-core processor'),
(1, 'Intel Core i5-12400F', 'Intel', 'i5-12400F', 149.99, 70, 65, 4.6, 'Excellent budget gaming CPU'),
(1, 'Intel Core i7-12700K', 'Intel', 'i7-12700K', 289.99, 35, 125, 4.5, '12-core performance CPU'),
(1, 'AMD Ryzen 9 7950X', 'AMD', 'Ryzen 9 7950X', 549.99, 20, 170, 4.9, '16-core flagship with exceptional multi-threaded performance'),
(1, 'AMD Ryzen 9 7950X3D', 'AMD', 'Ryzen 9 7950X3D', 649.99, 15, 120, 4.9, 'Best gaming CPU with 3D V-Cache'),
(1, 'AMD Ryzen 9 7900X', 'AMD', 'Ryzen 9 7900X', 399.99, 30, 170, 4.8, '12-core powerhouse for creators'),
(1, 'AMD Ryzen 7 7800X3D', 'AMD', 'Ryzen 7 7800X3D', 399.99, 25, 120, 4.9, 'Ultimate gaming CPU with 3D V-Cache'),
(1, 'AMD Ryzen 7 7700X', 'AMD', 'Ryzen 7 7700X', 299.99, 45, 105, 4.7, '8-core processor for gaming and streaming'),
(1, 'AMD Ryzen 5 7600X', 'AMD', 'Ryzen 5 7600X', 229.99, 55, 105, 4.6, '6-core gaming CPU with great value'),
(1, 'AMD Ryzen 5 7600', 'AMD', 'Ryzen 5 7600', 199.99, 65, 65, 4.5, 'Efficient 6-core processor'),
(1, 'AMD Ryzen 9 5950X', 'AMD', 'Ryzen 9 5950X', 399.99, 20, 105, 4.8, '16-core AM4 flagship'),
(1, 'AMD Ryzen 9 5900X', 'AMD', 'Ryzen 9 5900X', 299.99, 35, 105, 4.7, '12-core AM4 high-end processor'),
(1, 'AMD Ryzen 7 5800X3D', 'AMD', 'Ryzen 7 5800X3D', 299.99, 25, 105, 4.9, 'Best AM4 gaming CPU with 3D V-Cache'),
(1, 'AMD Ryzen 7 5800X', 'AMD', 'Ryzen 7 5800X', 199.99, 50, 105, 4.6, '8-core AM4 processor'),
(1, 'AMD Ryzen 7 5700X', 'AMD', 'Ryzen 7 5700X', 159.99, 60, 65, 4.6, 'Efficient 8-core AM4 CPU'),
(1, 'AMD Ryzen 5 5600X', 'AMD', 'Ryzen 5 5600X', 129.99, 80, 65, 4.7, 'Popular 6-core gaming CPU'),
(1, 'AMD Ryzen 5 5600', 'AMD', 'Ryzen 5 5600', 119.99, 90, 65, 4.6, 'Budget 6-core AM4 processor'),
(1, 'AMD Ryzen 5 5500', 'AMD', 'Ryzen 5 5500', 89.99, 100, 65, 4.4, 'Entry-level 6-core AM4');

-- ============================================================================
-- CPU SPECS
-- ============================================================================
INSERT INTO CPU_Spec (product_id, socket, core_count, thread_count, base_clock_ghz, boost_clock_ghz, tdp_watts) VALUES
(1, 'LGA1700', 24, 32, 3.20, 6.00, 125),
(2, 'LGA1700', 24, 32, 3.20, 6.00, 125),
(3, 'LGA1700', 20, 28, 3.40, 5.60, 125),
(4, 'LGA1700', 20, 28, 3.40, 5.60, 125),
(5, 'LGA1700', 14, 20, 3.50, 5.30, 125),
(6, 'LGA1700', 14, 20, 3.50, 5.30, 125),
(7, 'LGA1700', 10, 16, 2.50, 4.70, 65),
(8, 'LGA1700', 4, 8, 3.50, 4.70, 58),
(9, 'LGA1700', 6, 12, 2.50, 4.40, 65),
(10, 'LGA1700', 12, 20, 3.60, 5.00, 125),
(11, 'AM5', 16, 32, 4.50, 5.70, 170),
(12, 'AM5', 16, 32, 4.20, 5.70, 120),
(13, 'AM5', 12, 24, 4.70, 5.60, 170),
(14, 'AM5', 8, 16, 4.20, 5.00, 120),
(15, 'AM5', 8, 16, 4.50, 5.40, 105),
(16, 'AM5', 6, 12, 4.70, 5.30, 105),
(17, 'AM5', 6, 12, 3.80, 5.10, 65),
(18, 'AM4', 16, 32, 3.40, 4.90, 105),
(19, 'AM4', 12, 24, 3.70, 4.80, 105),
(20, 'AM4', 8, 16, 3.40, 4.50, 105),
(21, 'AM4', 8, 16, 3.80, 4.70, 105),
(22, 'AM4', 8, 16, 3.40, 4.60, 65),
(23, 'AM4', 6, 12, 3.70, 4.60, 65),
(24, 'AM4', 6, 12, 3.50, 4.40, 65),
(25, 'AM4', 6, 12, 3.60, 4.20, 65);

-- ============================================================================
-- PRODUCTS - Motherboards (category_id = 3)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(3, 'ASUS ROG Maximus Z790 Hero', 'ASUS', 'ROG Maximus Z790 Hero', 629.99, 15, 0, 4.8, 'Premium Z790 motherboard for enthusiasts'),
(3, 'ASUS ROG Strix Z790-E Gaming', 'ASUS', 'ROG Strix Z790-E', 449.99, 25, 0, 4.7, 'High-end gaming motherboard'),
(3, 'MSI MPG Z790 Edge WiFi', 'MSI', 'MPG Z790 Edge WiFi', 379.99, 30, 0, 4.6, 'Feature-rich Z790 board'),
(3, 'MSI MAG Z790 Tomahawk WiFi', 'MSI', 'MAG Z790 Tomahawk WiFi', 289.99, 40, 0, 4.7, 'Popular mid-range Z790'),
(3, 'Gigabyte Z790 Aorus Elite AX', 'Gigabyte', 'Z790 Aorus Elite AX', 269.99, 35, 0, 4.5, 'Solid Z790 with WiFi'),
(3, 'ASRock Z790 Pro RS', 'ASRock', 'Z790 Pro RS', 199.99, 45, 0, 4.4, 'Budget-friendly Z790'),
(3, 'ASUS Prime B760-Plus', 'ASUS', 'Prime B760-Plus', 159.99, 50, 0, 4.5, 'Reliable B760 motherboard'),
(3, 'MSI PRO B760M-A WiFi', 'MSI', 'PRO B760M-A WiFi', 139.99, 60, 0, 4.4, 'Compact B760 with WiFi'),
(3, 'Gigabyte B760M DS3H', 'Gigabyte', 'B760M DS3H', 99.99, 70, 0, 4.3, 'Entry-level B760 board'),
(3, 'ASUS ROG Crosshair X670E Hero', 'ASUS', 'ROG Crosshair X670E Hero', 699.99, 10, 0, 4.9, 'Flagship AM5 motherboard'),
(3, 'ASUS ROG Strix X670E-E Gaming', 'ASUS', 'ROG Strix X670E-E', 479.99, 20, 0, 4.7, 'Premium gaming AM5 board'),
(3, 'MSI MPG X670E Carbon WiFi', 'MSI', 'MPG X670E Carbon WiFi', 449.99, 25, 0, 4.6, 'Feature-packed X670E'),
(3, 'Gigabyte X670E Aorus Master', 'Gigabyte', 'X670E Aorus Master', 429.99, 20, 0, 4.7, 'High-end X670E board'),
(3, 'MSI MAG X670E Tomahawk WiFi', 'MSI', 'MAG X670E Tomahawk WiFi', 299.99, 35, 0, 4.6, 'Popular X670E choice'),
(3, 'ASUS TUF Gaming B650-Plus', 'ASUS', 'TUF Gaming B650-Plus', 179.99, 45, 0, 4.5, 'Durable B650 board'),
(3, 'MSI PRO B650-P WiFi', 'MSI', 'PRO B650-P WiFi', 159.99, 50, 0, 4.4, 'Value B650 with WiFi'),
(3, 'Gigabyte B650M DS3H', 'Gigabyte', 'B650M DS3H', 119.99, 60, 0, 4.3, 'Budget AM5 motherboard'),
(3, 'ASRock B650M-HDV/M.2', 'ASRock', 'B650M-HDV/M.2', 99.99, 55, 0, 4.2, 'Entry-level AM5 board'),
(3, 'ASUS ROG Crosshair VIII Hero', 'ASUS', 'ROG Crosshair VIII Hero', 349.99, 15, 0, 4.7, 'Premium X570 motherboard'),
(3, 'MSI MAG X570S Tomahawk WiFi', 'MSI', 'MAG X570S Tomahawk WiFi', 219.99, 30, 0, 4.6, 'Solid X570 board'),
(3, 'Gigabyte B550 Aorus Pro', 'Gigabyte', 'B550 Aorus Pro', 179.99, 40, 0, 4.5, 'Popular B550 choice'),
(3, 'ASUS TUF Gaming B550-Plus', 'ASUS', 'TUF Gaming B550-Plus', 149.99, 50, 0, 4.5, 'Reliable B550 board'),
(3, 'MSI B550-A PRO', 'MSI', 'B550-A PRO', 129.99, 55, 0, 4.4, 'Value B550 motherboard'),
(3, 'ASRock B550M Pro4', 'ASRock', 'B550M Pro4', 109.99, 60, 0, 4.3, 'Compact B550 board'),
(3, 'Gigabyte A520M DS3H', 'Gigabyte', 'A520M DS3H', 69.99, 80, 0, 4.2, 'Budget AM4 motherboard');

-- ============================================================================
-- MOTHERBOARD SPECS
-- ============================================================================
INSERT INTO MOBO_Spec (product_id, socket, form_factor, ram_type, ram_slots, max_ram_gb, pcie_version) VALUES
(26, 'LGA1700', 'ATX', 'DDR5', 4, 128, '5.0'),
(27, 'LGA1700', 'ATX', 'DDR5', 4, 128, '5.0'),
(28, 'LGA1700', 'ATX', 'DDR5', 4, 128, '5.0'),
(29, 'LGA1700', 'ATX', 'DDR5', 4, 128, '5.0'),
(30, 'LGA1700', 'ATX', 'DDR5', 4, 128, '5.0'),
(31, 'LGA1700', 'ATX', 'DDR5', 4, 128, '5.0'),
(32, 'LGA1700', 'ATX', 'DDR5', 4, 128, '5.0'),
(33, 'LGA1700', 'Micro-ATX', 'DDR5', 2, 64, '5.0'),
(34, 'LGA1700', 'Micro-ATX', 'DDR4', 2, 64, '4.0'),
(35, 'AM5', 'ATX', 'DDR5', 4, 128, '5.0'),
(36, 'AM5', 'ATX', 'DDR5', 4, 128, '5.0'),
(37, 'AM5', 'ATX', 'DDR5', 4, 128, '5.0'),
(38, 'AM5', 'ATX', 'DDR5', 4, 128, '5.0'),
(39, 'AM5', 'ATX', 'DDR5', 4, 128, '5.0'),
(40, 'AM5', 'ATX', 'DDR5', 4, 128, '5.0'),
(41, 'AM5', 'ATX', 'DDR5', 4, 128, '5.0'),
(42, 'AM5', 'Micro-ATX', 'DDR5', 2, 64, '5.0'),
(43, 'AM5', 'Micro-ATX', 'DDR5', 2, 64, '5.0'),
(44, 'AM4', 'ATX', 'DDR4', 4, 128, '4.0'),
(45, 'AM4', 'ATX', 'DDR4', 4, 128, '4.0'),
(46, 'AM4', 'ATX', 'DDR4', 4, 128, '4.0'),
(47, 'AM4', 'ATX', 'DDR4', 4, 128, '4.0'),
(48, 'AM4', 'ATX', 'DDR4', 4, 128, '4.0'),
(49, 'AM4', 'Micro-ATX', 'DDR4', 4, 128, '4.0'),
(50, 'AM4', 'Micro-ATX', 'DDR4', 2, 64, '3.0');

-- ============================================================================
-- PRODUCTS - GPUs (category_id = 2)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(2, 'NVIDIA GeForce RTX 4090 Founders Edition', 'NVIDIA', 'RTX 4090 FE', 1599.99, 10, 450, 4.9, 'The ultimate GPU for gaming and AI'),
(2, 'ASUS ROG Strix RTX 4090 OC', 'ASUS', 'ROG Strix RTX 4090', 1949.99, 8, 480, 4.9, 'Premium RTX 4090 with massive cooling'),
(2, 'MSI GeForce RTX 4090 Suprim X', 'MSI', 'RTX 4090 Suprim X', 1899.99, 10, 475, 4.8, 'Top-tier RTX 4090 variant'),
(2, 'NVIDIA GeForce RTX 4080 Super', 'NVIDIA', 'RTX 4080 Super', 999.99, 20, 320, 4.7, 'High-end gaming GPU'),
(2, 'ASUS TUF Gaming RTX 4080 Super', 'ASUS', 'TUF RTX 4080 Super', 1099.99, 15, 320, 4.7, 'Durable RTX 4080 Super'),
(2, 'Gigabyte RTX 4080 Super Gaming OC', 'Gigabyte', 'RTX 4080 Super Gaming', 1049.99, 18, 320, 4.6, 'Gaming-focused 4080 Super'),
(2, 'NVIDIA GeForce RTX 4070 Ti Super', 'NVIDIA', 'RTX 4070 Ti Super', 799.99, 25, 285, 4.7, 'Excellent 1440p gaming GPU'),
(2, 'MSI GeForce RTX 4070 Ti Super Ventus 3X', 'MSI', 'RTX 4070 Ti Super Ventus', 829.99, 20, 285, 4.6, 'Compact RTX 4070 Ti Super'),
(2, 'NVIDIA GeForce RTX 4070 Super', 'NVIDIA', 'RTX 4070 Super', 599.99, 30, 220, 4.7, 'Great value high-end GPU'),
(2, 'ASUS Dual RTX 4070 Super', 'ASUS', 'Dual RTX 4070 Super', 619.99, 25, 220, 4.6, 'Dual-fan RTX 4070 Super'),
(2, 'NVIDIA GeForce RTX 4070', 'NVIDIA', 'RTX 4070', 549.99, 35, 200, 4.6, 'Solid 1440p gaming GPU'),
(2, 'Gigabyte RTX 4070 Windforce OC', 'Gigabyte', 'RTX 4070 Windforce', 569.99, 30, 200, 4.5, 'Affordable RTX 4070'),
(2, 'NVIDIA GeForce RTX 4060 Ti 16GB', 'NVIDIA', 'RTX 4060 Ti 16GB', 449.99, 40, 165, 4.5, 'RTX 4060 Ti with more VRAM'),
(2, 'NVIDIA GeForce RTX 4060 Ti 8GB', 'NVIDIA', 'RTX 4060 Ti 8GB', 399.99, 45, 160, 4.5, 'Popular mid-range GPU'),
(2, 'MSI GeForce RTX 4060 Ti Gaming X', 'MSI', 'RTX 4060 Ti Gaming X', 429.99, 35, 165, 4.4, 'Gaming-focused 4060 Ti'),
(2, 'NVIDIA GeForce RTX 4060', 'NVIDIA', 'RTX 4060', 299.99, 50, 115, 4.4, 'Entry-level RTX 40 series'),
(2, 'ASUS Dual RTX 4060', 'ASUS', 'Dual RTX 4060', 309.99, 45, 115, 4.3, 'Budget RTX 4060'),
(2, 'AMD Radeon RX 7900 XTX', 'AMD', 'RX 7900 XTX', 949.99, 20, 355, 4.7, 'AMD flagship GPU'),
(2, 'Sapphire Nitro+ RX 7900 XTX', 'Sapphire', 'Nitro+ RX 7900 XTX', 1049.99, 15, 370, 4.7, 'Premium RX 7900 XTX variant'),
(2, 'AMD Radeon RX 7900 XT', 'AMD', 'RX 7900 XT', 749.99, 25, 315, 4.6, 'High-end AMD GPU'),
(2, 'PowerColor Red Devil RX 7900 XT', 'PowerColor', 'Red Devil RX 7900 XT', 799.99, 20, 330, 4.6, 'Overclocked 7900 XT'),
(2, 'AMD Radeon RX 7800 XT', 'AMD', 'RX 7800 XT', 499.99, 35, 263, 4.6, 'Excellent 1440p AMD GPU'),
(2, 'Sapphire Pulse RX 7800 XT', 'Sapphire', 'Pulse RX 7800 XT', 519.99, 30, 263, 4.5, 'Popular RX 7800 XT'),
(2, 'AMD Radeon RX 7700 XT', 'AMD', 'RX 7700 XT', 399.99, 40, 245, 4.5, 'Value-oriented 1440p GPU'),
(2, 'XFX Speedster SWFT 319 RX 7700 XT', 'XFX', 'SWFT 319 RX 7700 XT', 419.99, 35, 245, 4.4, 'Triple-fan 7700 XT'),
(2, 'AMD Radeon RX 7600', 'AMD', 'RX 7600', 269.99, 50, 165, 4.4, 'Budget 1080p gaming GPU'),
(2, 'Sapphire Pulse RX 7600', 'Sapphire', 'Pulse RX 7600', 279.99, 45, 165, 4.3, 'Compact RX 7600');

-- ============================================================================
-- GPU SPECS
-- ============================================================================
INSERT INTO GPU_Spec (product_id, length_mm, vram_gb, min_psu_watts, pcie_version) VALUES
(51, 336, 24, 850, '4.0'),
(52, 358, 24, 850, '4.0'),
(53, 340, 24, 850, '4.0'),
(54, 304, 16, 700, '4.0'),
(55, 305, 16, 700, '4.0'),
(56, 308, 16, 700, '4.0'),
(57, 285, 16, 700, '4.0'),
(58, 308, 16, 700, '4.0'),
(59, 244, 12, 650, '4.0'),
(60, 267, 12, 650, '4.0'),
(61, 244, 12, 650, '4.0'),
(62, 262, 12, 650, '4.0'),
(63, 240, 16, 550, '4.0'),
(64, 240, 8, 550, '4.0'),
(65, 247, 8, 550, '4.0'),
(66, 240, 8, 550, '4.0'),
(67, 240, 8, 550, '4.0'),
(68, 287, 24, 800, '4.0'),
(69, 310, 24, 800, '4.0'),
(70, 276, 20, 750, '4.0'),
(71, 320, 20, 750, '4.0'),
(72, 267, 16, 700, '4.0'),
(73, 260, 16, 700, '4.0'),
(74, 246, 12, 650, '4.0'),
(75, 266, 12, 650, '4.0'),
(76, 204, 8, 550, '4.0'),
(77, 210, 8, 550, '4.0');

-- ============================================================================
-- PRODUCTS - RAM (category_id = 4)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(4, 'G.Skill Trident Z5 RGB DDR5-6400 32GB (2x16GB)', 'G.Skill', 'Trident Z5 RGB 6400', 189.99, 40, 5, 4.8, 'High-speed DDR5 with RGB'),
(4, 'G.Skill Trident Z5 RGB DDR5-6000 32GB (2x16GB)', 'G.Skill', 'Trident Z5 RGB 6000', 169.99, 50, 5, 4.7, 'Fast DDR5 with RGB'),
(4, 'Corsair Dominator Platinum RGB DDR5-6400 32GB (2x16GB)', 'Corsair', 'Dominator Platinum 6400', 219.99, 30, 5, 4.8, 'Premium DDR5 kit'),
(4, 'Corsair Dominator Platinum RGB DDR5-6000 32GB (2x16GB)', 'Corsair', 'Dominator Platinum 6000', 189.99, 35, 5, 4.7, 'High-performance DDR5'),
(4, 'Corsair Vengeance DDR5-6000 32GB (2x16GB)', 'Corsair', 'Vengeance DDR5 6000', 139.99, 60, 5, 4.6, 'Popular DDR5 kit'),
(4, 'Corsair Vengeance DDR5-5600 32GB (2x16GB)', 'Corsair', 'Vengeance DDR5 5600', 119.99, 70, 5, 4.5, 'Value DDR5 kit'),
(4, 'Kingston Fury Beast DDR5-6000 32GB (2x16GB)', 'Kingston', 'Fury Beast 6000', 129.99, 55, 5, 4.5, 'Reliable DDR5'),
(4, 'Kingston Fury Beast DDR5-5600 32GB (2x16GB)', 'Kingston', 'Fury Beast 5600', 109.99, 65, 5, 4.4, 'Budget DDR5'),
(4, 'Crucial DDR5-4800 32GB (2x16GB)', 'Crucial', 'DDR5-4800', 89.99, 80, 5, 4.3, 'Entry-level DDR5'),
(4, 'G.Skill Trident Z5 RGB DDR5-6000 64GB (2x32GB)', 'G.Skill', 'Trident Z5 RGB 6000 64GB', 329.99, 20, 5, 4.8, '64GB high-speed DDR5'),
(4, 'G.Skill Trident Z RGB DDR4-3600 32GB (2x16GB)', 'G.Skill', 'Trident Z RGB 3600', 99.99, 60, 5, 4.7, 'Popular DDR4 with RGB'),
(4, 'G.Skill Trident Z RGB DDR4-3200 32GB (2x16GB)', 'G.Skill', 'Trident Z RGB 3200', 84.99, 70, 5, 4.6, 'Reliable DDR4 kit'),
(4, 'Corsair Vengeance RGB Pro DDR4-3600 32GB (2x16GB)', 'Corsair', 'Vengeance RGB Pro 3600', 94.99, 55, 5, 4.6, 'Gaming DDR4 with RGB'),
(4, 'Corsair Vengeance RGB Pro DDR4-3200 32GB (2x16GB)', 'Corsair', 'Vengeance RGB Pro 3200', 79.99, 65, 5, 4.5, 'Classic DDR4 kit'),
(4, 'Corsair Vengeance LPX DDR4-3600 32GB (2x16GB)', 'Corsair', 'Vengeance LPX 3600', 74.99, 80, 5, 4.6, 'Low-profile DDR4'),
(4, 'Corsair Vengeance LPX DDR4-3200 32GB (2x16GB)', 'Corsair', 'Vengeance LPX 3200', 64.99, 90, 5, 4.5, 'Budget DDR4'),
(4, 'Kingston Fury Beast DDR4-3600 32GB (2x16GB)', 'Kingston', 'Fury Beast DDR4 3600', 79.99, 60, 5, 4.5, 'Reliable DDR4'),
(4, 'Kingston Fury Beast DDR4-3200 32GB (2x16GB)', 'Kingston', 'Fury Beast DDR4 3200', 69.99, 75, 5, 4.4, 'Value DDR4'),
(4, 'Crucial Ballistix DDR4-3200 32GB (2x16GB)', 'Crucial', 'Ballistix 3200', 59.99, 85, 5, 4.4, 'Budget DDR4 kit'),
(4, 'TeamGroup T-Force Delta RGB DDR4-3200 32GB (2x16GB)', 'TeamGroup', 'T-Force Delta RGB', 69.99, 55, 5, 4.3, 'Affordable RGB DDR4'),
(4, 'G.Skill Ripjaws V DDR4-3600 16GB (2x8GB)', 'G.Skill', 'Ripjaws V 3600', 49.99, 100, 5, 4.5, 'Compact DDR4 kit'),
(4, 'Corsair Vengeance LPX DDR4-3200 16GB (2x8GB)', 'Corsair', 'Vengeance LPX 3200 16GB', 39.99, 120, 5, 4.5, 'Entry DDR4 kit');

-- ============================================================================
-- RAM SPECS
-- ============================================================================
INSERT INTO RAM_Spec (product_id, ram_type, speed_mhz, size_gb, modules, latency) VALUES
(78, 'DDR5', 6400, 32, 2, 'CL32'),
(79, 'DDR5', 6000, 32, 2, 'CL30'),
(80, 'DDR5', 6400, 32, 2, 'CL32'),
(81, 'DDR5', 6000, 32, 2, 'CL30'),
(82, 'DDR5', 6000, 32, 2, 'CL30'),
(83, 'DDR5', 5600, 32, 2, 'CL36'),
(84, 'DDR5', 6000, 32, 2, 'CL36'),
(85, 'DDR5', 5600, 32, 2, 'CL36'),
(86, 'DDR5', 4800, 32, 2, 'CL40'),
(87, 'DDR5', 6000, 64, 2, 'CL30'),
(88, 'DDR4', 3600, 32, 2, 'CL16'),
(89, 'DDR4', 3200, 32, 2, 'CL16'),
(90, 'DDR4', 3600, 32, 2, 'CL18'),
(91, 'DDR4', 3200, 32, 2, 'CL16'),
(92, 'DDR4', 3600, 32, 2, 'CL18'),
(93, 'DDR4', 3200, 32, 2, 'CL16'),
(94, 'DDR4', 3600, 32, 2, 'CL18'),
(95, 'DDR4', 3200, 32, 2, 'CL16'),
(96, 'DDR4', 3200, 32, 2, 'CL16'),
(97, 'DDR4', 3200, 32, 2, 'CL16'),
(98, 'DDR4', 3600, 16, 2, 'CL16'),
(99, 'DDR4', 3200, 16, 2, 'CL16');

-- ============================================================================
-- PRODUCTS - Cases (category_id = 6)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(6, 'Lian Li O11 Dynamic EVO', 'Lian Li', 'O11 Dynamic EVO', 169.99, 30, 0, 4.8, 'Premium showcase case'),
(6, 'Lian Li O11 Dynamic', 'Lian Li', 'O11 Dynamic', 139.99, 40, 0, 4.7, 'Popular dual-chamber case'),
(6, 'NZXT H7 Flow', 'NZXT', 'H7 Flow', 129.99, 45, 0, 4.6, 'High-airflow mid-tower'),
(6, 'NZXT H7', 'NZXT', 'H7', 139.99, 35, 0, 4.5, 'Clean aesthetic mid-tower'),
(6, 'Corsair 4000D Airflow', 'Corsair', 'iCUE 4000D Airflow', 104.99, 55, 0, 4.7, 'Best-selling airflow case'),
(6, 'Corsair 5000D Airflow', 'Corsair', 'iCUE 5000D Airflow', 164.99, 35, 0, 4.7, 'Spacious high-airflow case'),
(6, 'Fractal Design Torrent', 'Fractal Design', 'Torrent', 189.99, 25, 0, 4.8, 'Ultimate airflow design'),
(6, 'Fractal Design North', 'Fractal Design', 'North', 139.99, 40, 0, 4.6, 'Wood-panel aesthetic case'),
(6, 'Phanteks Eclipse G360A', 'Phanteks', 'Eclipse G360A', 89.99, 60, 0, 4.5, 'Value airflow case'),
(6, 'be quiet! Pure Base 500DX', 'be quiet!', 'Pure Base 500DX', 109.99, 45, 0, 4.6, 'Quiet high-airflow case'),
(6, 'Cooler Master MasterBox TD500 Mesh', 'Cooler Master', 'TD500 Mesh', 109.99, 40, 0, 4.5, 'Mesh front case with ARGB'),
(6, 'HYTE Y60', 'HYTE', 'Y60', 199.99, 20, 0, 4.7, 'Panoramic glass case'),
(6, 'Lian Li Lancool II Mesh', 'Lian Li', 'Lancool II Mesh', 119.99, 50, 0, 4.6, 'Popular mesh case'),
(6, 'NZXT H5 Flow', 'NZXT', 'H5 Flow', 94.99, 50, 0, 4.5, 'Compact high-airflow case'),
(6, 'Corsair 4000D Airflow Micro-ATX', 'Corsair', '4000D mATX Airflow', 89.99, 45, 0, 4.4, 'Compact version of 4000D'),
(6, 'Fractal Design Meshify C Mini', 'Fractal Design', 'Meshify C Mini', 99.99, 40, 0, 4.5, 'Compact mesh case'),
(6, 'Cooler Master NR400', 'Cooler Master', 'NR400', 69.99, 55, 0, 4.4, 'Budget mATX case'),
(6, 'Thermaltake S100', 'Thermaltake', 'S100', 59.99, 60, 0, 4.3, 'Entry-level mATX case'),
(6, 'DeepCool CC560', 'DeepCool', 'CC560', 69.99, 50, 0, 4.4, 'Affordable airflow case'),
(6, 'NZXT H1 V2', 'NZXT', 'H1 V2', 399.99, 15, 0, 4.6, 'Premium ITX with built-in PSU/AIO'),
(6, 'Lian Li A4-H2O', 'Lian Li', 'A4-H2O', 159.99, 25, 0, 4.5, 'Compact ITX with AIO support'),
(6, 'Cooler Master NR200P', 'Cooler Master', 'NR200P', 119.99, 35, 0, 4.7, 'Popular ITX case'),
(6, 'SSUPD Meshroom S', 'SSUPD', 'Meshroom S', 139.99, 20, 0, 4.5, 'Mesh ITX case');

-- ============================================================================
-- CASE SPECS
-- ============================================================================
INSERT INTO CASE_Spec (product_id, max_gpu_length_mm, supported_form_factor, max_psu_length_mm, drive_bays_25, drive_bays_35) VALUES
(100, 420, 'ATX', 200, 4, 2),
(101, 395, 'ATX', 200, 4, 2),
(102, 400, 'ATX', 200, 4, 2),
(103, 400, 'ATX', 200, 4, 2),
(104, 360, 'ATX', 180, 2, 2),
(105, 400, 'ATX', 225, 4, 2),
(106, 461, 'ATX', 200, 4, 4),
(107, 355, 'ATX', 200, 2, 2),
(108, 360, 'ATX', 180, 2, 2),
(109, 369, 'ATX', 225, 5, 2),
(110, 410, 'ATX', 180, 2, 2),
(111, 400, 'ATX', 200, 4, 2),
(112, 384, 'ATX', 210, 3, 2),
(113, 365, 'Micro-ATX', 180, 2, 2),
(114, 360, 'Micro-ATX', 180, 2, 2),
(115, 315, 'Micro-ATX', 175, 3, 2),
(116, 350, 'Micro-ATX', 160, 2, 2),
(117, 330, 'Micro-ATX', 160, 2, 2),
(118, 370, 'Micro-ATX', 160, 2, 2),
(119, 324, 'Mini-ITX', 0, 1, 0),
(120, 322, 'Mini-ITX', 130, 2, 0),
(121, 330, 'Mini-ITX', 180, 3, 1),
(122, 336, 'Mini-ITX', 160, 2, 0);

-- ============================================================================
-- PRODUCTS - PSUs (category_id = 5)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(5, 'Corsair RM1000x', 'Corsair', 'RM1000x', 189.99, 30, 0, 4.8, '1000W 80+ Gold fully modular'),
(5, 'Corsair RM850x', 'Corsair', 'RM850x', 139.99, 45, 0, 4.8, '850W 80+ Gold fully modular'),
(5, 'Corsair RM750x', 'Corsair', 'RM750x', 119.99, 55, 0, 4.7, '750W 80+ Gold fully modular'),
(5, 'Corsair RM650x', 'Corsair', 'RM650x', 99.99, 60, 0, 4.6, '650W 80+ Gold fully modular'),
(5, 'Seasonic Focus GX-1000', 'Seasonic', 'Focus GX-1000', 179.99, 25, 0, 4.8, '1000W 80+ Gold premium PSU'),
(5, 'Seasonic Focus GX-850', 'Seasonic', 'Focus GX-850', 139.99, 40, 0, 4.7, '850W 80+ Gold premium PSU'),
(5, 'Seasonic Focus GX-750', 'Seasonic', 'Focus GX-750', 109.99, 50, 0, 4.7, '750W 80+ Gold premium PSU'),
(5, 'Seasonic Focus GX-650', 'Seasonic', 'Focus GX-650', 89.99, 55, 0, 4.6, '650W 80+ Gold premium PSU'),
(5, 'EVGA SuperNOVA 1000 G6', 'EVGA', 'SuperNOVA 1000 G6', 169.99, 30, 0, 4.7, '1000W 80+ Gold compact design'),
(5, 'EVGA SuperNOVA 850 G6', 'EVGA', 'SuperNOVA 850 G6', 129.99, 40, 0, 4.6, '850W 80+ Gold compact design'),
(5, 'EVGA SuperNOVA 750 G6', 'EVGA', 'SuperNOVA 750 G6', 99.99, 50, 0, 4.6, '750W 80+ Gold compact design'),
(5, 'be quiet! Straight Power 12 1000W', 'be quiet!', 'Straight Power 12 1000W', 199.99, 20, 0, 4.8, '1000W 80+ Platinum silent PSU'),
(5, 'be quiet! Straight Power 12 850W', 'be quiet!', 'Straight Power 12 850W', 159.99, 30, 0, 4.7, '850W 80+ Platinum silent PSU'),
(5, 'be quiet! Pure Power 12 M 750W', 'be quiet!', 'Pure Power 12 M 750W', 109.99, 45, 0, 4.6, '750W 80+ Gold quiet PSU'),
(5, 'Corsair HX1500i', 'Corsair', 'HX1500i', 399.99, 10, 0, 4.9, '1500W 80+ Platinum for extreme builds'),
(5, 'Corsair HX1200', 'Corsair', 'HX1200', 279.99, 15, 0, 4.8, '1200W 80+ Platinum high-end PSU'),
(5, 'MSI MPG A1000G', 'MSI', 'MPG A1000G', 159.99, 30, 0, 4.6, '1000W 80+ Gold gaming PSU'),
(5, 'MSI MPG A850GF', 'MSI', 'MPG A850GF', 119.99, 40, 0, 4.5, '850W 80+ Gold gaming PSU'),
(5, 'MSI MPG A750GF', 'MSI', 'MPG A750GF', 99.99, 50, 0, 4.5, '750W 80+ Gold gaming PSU'),
(5, 'Thermaltake Toughpower GF3 1000W', 'Thermaltake', 'Toughpower GF3 1000W', 169.99, 25, 0, 4.6, '1000W ATX 3.0 ready PSU'),
(5, 'Thermaltake Toughpower GF3 850W', 'Thermaltake', 'Toughpower GF3 850W', 129.99, 35, 0, 4.5, '850W ATX 3.0 ready PSU'),
(5, 'ASUS ROG Strix 1000W', 'ASUS', 'ROG Strix 1000W', 219.99, 20, 0, 4.7, '1000W 80+ Gold ROG PSU'),
(5, 'ASUS ROG Strix 850W', 'ASUS', 'ROG Strix 850W', 169.99, 30, 0, 4.6, '850W 80+ Gold ROG PSU'),
(5, 'Corsair CV650', 'Corsair', 'CV650', 59.99, 70, 0, 4.3, '650W 80+ Bronze budget PSU'),
(5, 'Corsair CV550', 'Corsair', 'CV550', 49.99, 80, 0, 4.2, '550W 80+ Bronze budget PSU'),
(5, 'EVGA 600 BR', 'EVGA', '600 BR', 54.99, 65, 0, 4.3, '600W 80+ Bronze reliable PSU'),
(5, 'Thermaltake Smart 600W', 'Thermaltake', 'Smart 600W', 49.99, 75, 0, 4.2, '600W 80+ budget option'),
(5, 'Cooler Master MWE Gold 650', 'Cooler Master', 'MWE Gold 650', 79.99, 50, 0, 4.4, '650W 80+ Gold value PSU');

-- ============================================================================
-- PSU SPECS
-- ============================================================================
INSERT INTO PSU_Spec (product_id, wattage, efficiency_rating, modular, psu_length_mm) VALUES
(123, 1000, '80+ Gold', 'Full', 160),
(124, 850, '80+ Gold', 'Full', 160),
(125, 750, '80+ Gold', 'Full', 160),
(126, 650, '80+ Gold', 'Full', 160),
(127, 1000, '80+ Gold', 'Full', 170),
(128, 850, '80+ Gold', 'Full', 170),
(129, 750, '80+ Gold', 'Full', 170),
(130, 650, '80+ Gold', 'Full', 170),
(131, 1000, '80+ Gold', 'Full', 150),
(132, 850, '80+ Gold', 'Full', 150),
(133, 750, '80+ Gold', 'Full', 150),
(134, 1000, '80+ Platinum', 'Full', 180),
(135, 850, '80+ Platinum', 'Full', 180),
(136, 750, '80+ Gold', 'Full', 160),
(137, 1500, '80+ Platinum', 'Full', 200),
(138, 1200, '80+ Platinum', 'Full', 180),
(139, 1000, '80+ Gold', 'Full', 160),
(140, 850, '80+ Gold', 'Full', 160),
(141, 750, '80+ Gold', 'Full', 160),
(142, 1000, '80+ Gold', 'Full', 160),
(143, 850, '80+ Gold', 'Full', 160),
(144, 1000, '80+ Gold', 'Full', 160),
(145, 850, '80+ Gold', 'Full', 160),
(146, 650, '80+ Bronze', 'Non-Modular', 140),
(147, 550, '80+ Bronze', 'Non-Modular', 140),
(148, 600, '80+ Bronze', 'Non-Modular', 140),
(149, 600, '80+ White', 'Non-Modular', 150),
(150, 650, '80+ Gold', 'Semi', 150);

-- ============================================================================
-- PRODUCTS - Storage (category_id = 7)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(7, 'Samsung 990 Pro 2TB', 'Samsung', '990 Pro 2TB', 179.99, 40, 8, 4.9, 'Top-tier Gen4 NVMe SSD'),
(7, 'Samsung 990 Pro 1TB', 'Samsung', '990 Pro 1TB', 109.99, 60, 8, 4.9, 'High-performance Gen4 SSD'),
(7, 'Samsung 980 Pro 2TB', 'Samsung', '980 Pro 2TB', 149.99, 45, 7, 4.8, 'Reliable Gen4 NVMe'),
(7, 'Samsung 980 Pro 1TB', 'Samsung', '980 Pro 1TB', 89.99, 70, 7, 4.8, 'Popular Gen4 SSD'),
(7, 'WD Black SN850X 2TB', 'Western Digital', 'SN850X 2TB', 169.99, 35, 7, 4.8, 'Gaming-focused Gen4 SSD'),
(7, 'WD Black SN850X 1TB', 'Western Digital', 'SN850X 1TB', 99.99, 55, 7, 4.8, 'Fast gaming SSD'),
(7, 'Seagate FireCuda 530 2TB', 'Seagate', 'FireCuda 530 2TB', 179.99, 30, 8, 4.7, 'High-endurance Gen4 SSD'),
(7, 'Seagate FireCuda 530 1TB', 'Seagate', 'FireCuda 530 1TB', 99.99, 50, 8, 4.7, 'Durable gaming SSD'),
(7, 'Crucial T700 2TB', 'Crucial', 'T700 2TB', 299.99, 20, 11, 4.8, 'Gen5 NVMe flagship'),
(7, 'Crucial T700 1TB', 'Crucial', 'T700 1TB', 179.99, 30, 11, 4.7, 'Fastest Gen5 SSD'),
(7, 'SK Hynix Platinum P41 2TB', 'SK Hynix', 'Platinum P41 2TB', 159.99, 35, 7, 4.8, 'Excellent Gen4 performance'),
(7, 'SK Hynix Platinum P41 1TB', 'SK Hynix', 'Platinum P41 1TB', 89.99, 55, 7, 4.7, 'Fast and reliable SSD'),
(7, 'Crucial P5 Plus 2TB', 'Crucial', 'P5 Plus 2TB', 129.99, 45, 6, 4.6, 'Value Gen4 SSD'),
(7, 'Crucial P5 Plus 1TB', 'Crucial', 'P5 Plus 1TB', 74.99, 65, 6, 4.6, 'Affordable Gen4 SSD'),
(7, 'WD Blue SN580 2TB', 'Western Digital', 'SN580 2TB', 119.99, 50, 5, 4.5, 'Budget Gen4 SSD'),
(7, 'WD Blue SN580 1TB', 'Western Digital', 'SN580 1TB', 64.99, 70, 5, 4.5, 'Entry Gen4 SSD'),
(7, 'Kingston NV2 2TB', 'Kingston', 'NV2 2TB', 89.99, 60, 4, 4.4, 'Value NVMe SSD'),
(7, 'Kingston NV2 1TB', 'Kingston', 'NV2 1TB', 49.99, 80, 4, 4.4, 'Budget NVMe SSD'),
(7, 'Samsung 870 EVO 2TB', 'Samsung', '870 EVO 2TB', 169.99, 40, 4, 4.8, 'Best SATA SSD'),
(7, 'Samsung 870 EVO 1TB', 'Samsung', '870 EVO 1TB', 89.99, 60, 4, 4.8, 'Reliable SATA SSD'),
(7, 'Samsung 870 EVO 500GB', 'Samsung', '870 EVO 500GB', 49.99, 80, 4, 4.7, 'Popular SATA SSD'),
(7, 'Crucial MX500 2TB', 'Crucial', 'MX500 2TB', 139.99, 45, 3, 4.7, 'Reliable SATA SSD'),
(7, 'Crucial MX500 1TB', 'Crucial', 'MX500 1TB', 69.99, 65, 3, 4.7, 'Value SATA SSD'),
(7, 'WD Blue 3D NAND 2TB', 'Western Digital', 'Blue 3D 2TB', 149.99, 40, 3, 4.6, 'Dependable SATA SSD'),
(7, 'WD Blue 3D NAND 1TB', 'Western Digital', 'Blue 3D 1TB', 79.99, 55, 3, 4.6, 'Budget SATA SSD'),
(7, 'Seagate Barracuda 8TB', 'Seagate', 'Barracuda 8TB', 139.99, 30, 9, 4.5, 'High-capacity storage'),
(7, 'Seagate Barracuda 4TB', 'Seagate', 'Barracuda 4TB', 79.99, 50, 7, 4.5, 'Popular storage drive'),
(7, 'Seagate Barracuda 2TB', 'Seagate', 'Barracuda 2TB', 54.99, 70, 6, 4.4, 'Budget mass storage'),
(7, 'WD Blue 4TB', 'Western Digital', 'Blue 4TB', 84.99, 45, 7, 4.5, 'Reliable storage HDD'),
(7, 'WD Blue 2TB', 'Western Digital', 'Blue 2TB', 54.99, 65, 6, 4.4, 'Entry-level HDD'),
(7, 'Toshiba X300 8TB', 'Toshiba', 'X300 8TB', 159.99, 25, 9, 4.4, 'Performance HDD'),
(7, 'Toshiba P300 4TB', 'Toshiba', 'P300 4TB', 74.99, 40, 7, 4.3, 'Budget performance HDD');

-- ============================================================================
-- STORAGE SPECS
-- ============================================================================
INSERT INTO Storage_Spec (product_id, storage_type, capacity_gb, form_factor, read_speed_mbps, write_speed_mbps) VALUES
(151, 'NVMe', 2000, 'M.2', 7450, 6900),
(152, 'NVMe', 1000, 'M.2', 7450, 6900),
(153, 'NVMe', 2000, 'M.2', 7000, 5100),
(154, 'NVMe', 1000, 'M.2', 7000, 5100),
(155, 'NVMe', 2000, 'M.2', 7300, 6600),
(156, 'NVMe', 1000, 'M.2', 7300, 6350),
(157, 'NVMe', 2000, 'M.2', 7300, 6900),
(158, 'NVMe', 1000, 'M.2', 7300, 6000),
(159, 'NVMe', 2000, 'M.2', 12400, 11800),
(160, 'NVMe', 1000, 'M.2', 11700, 9500),
(161, 'NVMe', 2000, 'M.2', 7000, 6500),
(162, 'NVMe', 1000, 'M.2', 7000, 6500),
(163, 'NVMe', 2000, 'M.2', 6600, 5000),
(164, 'NVMe', 1000, 'M.2', 6600, 5000),
(165, 'NVMe', 2000, 'M.2', 4150, 4150),
(166, 'NVMe', 1000, 'M.2', 4150, 4150),
(167, 'NVMe', 2000, 'M.2', 3500, 2800),
(168, 'NVMe', 1000, 'M.2', 3500, 2100),
(169, 'SSD', 2000, '2.5"', 560, 530),
(170, 'SSD', 1000, '2.5"', 560, 530),
(171, 'SSD', 500, '2.5"', 560, 530),
(172, 'SSD', 2000, '2.5"', 560, 510),
(173, 'SSD', 1000, '2.5"', 560, 510),
(174, 'SSD', 2000, '2.5"', 560, 530),
(175, 'SSD', 1000, '2.5"', 560, 530),
(176, 'HDD', 8000, '3.5"', 190, 190),
(177, 'HDD', 4000, '3.5"', 190, 190),
(178, 'HDD', 2000, '3.5"', 220, 220),
(179, 'HDD', 4000, '3.5"', 175, 175),
(180, 'HDD', 2000, '3.5"', 175, 175),
(181, 'HDD', 8000, '3.5"', 260, 260),
(182, 'HDD', 4000, '3.5"', 190, 190);

-- ============================================================================
-- PRODUCTS - CPU Coolers (category_id = 8)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(8, 'Noctua NH-D15 chromax.black', 'Noctua', 'NH-D15 chromax.black', 109.95, 30, 0, 4.8, 'Premium dual-tower air CPU cooler with dual 140mm fans'),
(8, 'Noctua NH-U12A', 'Noctua', 'NH-U12A', 119.95, 30, 0, 4.8, 'Premium 120mm-class air CPU cooler with dual fans'),
(8, 'Noctua NH-U12S redux', 'Noctua', 'NH-U12S redux', 54.95, 40, 0, 4.7, 'Streamlined 120mm air CPU cooler designed for excellent value'),
(8, 'be quiet! Dark Rock Pro 4', 'be quiet!', 'Dark Rock Pro 4', 89.90, 25, 0, 4.7, 'High-end dual-tower air CPU cooler designed for quiet operation'),
(8, 'be quiet! Dark Rock 4', 'be quiet!', 'Dark Rock 4', 74.90, 25, 0, 4.6, 'High-performance single-tower air CPU cooler with silent fan'),
(8, 'Cooler Master Hyper 212 Black Edition', 'Cooler Master', 'Hyper 212 Black Edition', 49.99, 50, 0, 4.5, 'Classic tower air CPU cooler with 120mm fan'),
(8, 'DeepCool AK620', 'DeepCool', 'AK620', 64.99, 40, 0, 4.6, 'Dual-tower air CPU cooler with dual 120mm fans'),
(8, 'DeepCool AK400', 'DeepCool', 'AK400', 34.99, 60, 0, 4.5, 'Tower air CPU cooler with 120mm fan for efficient cooling'),
(8, 'ARCTIC Liquid Freezer II 240', 'ARCTIC', 'Liquid Freezer II 240', 109.99, 30, 0, 4.7, '240mm all-in-one liquid CPU cooler'),
(8, 'ARCTIC Liquid Freezer II 360', 'ARCTIC', 'Liquid Freezer II 360', 139.99, 25, 0, 4.7, '360mm all-in-one liquid CPU cooler'),
(8, 'Corsair iCUE H100i RGB ELITE', 'Corsair', 'H100i RGB ELITE', 139.99, 25, 0, 4.6, '240mm AIO liquid CPU cooler with iCUE support'),
(8, 'Corsair iCUE H150i ELITE CAPELLIX XT', 'Corsair', 'H150i ELITE CAPELLIX XT', 229.99, 20, 0, 4.6, '360mm AIO liquid CPU cooler with high-performance fans'),
(8, 'NZXT Kraken 240', 'NZXT', 'Kraken 240', 139.99, 25, 0, 4.6, '240mm AIO liquid CPU cooler with LCD display'),
(8, 'NZXT Kraken 360', 'NZXT', 'Kraken 360', 179.99, 20, 0, 4.6, '360mm AIO liquid CPU cooler with LCD display'),
(8, 'Lian Li Galahad II Trinity 240', 'Lian Li', 'Galahad II Trinity 240', 129.99, 20, 0, 4.6, '240mm AIO liquid CPU cooler'),
(8, 'ASUS ROG Ryujin III 360', 'ASUS', 'ROG Ryujin III 360', 359.99, 10, 0, 4.6, 'Premium 360mm AIO liquid CPU cooler'),
(8, 'Thermalright Peerless Assassin 120 SE', 'Thermalright', 'Peerless Assassin 120 SE', 39.90, 50, 0, 4.6, 'Value dual-tower air CPU cooler with dual 120mm fans'),
(8, 'Scythe Fuma 2 Rev.B', 'Scythe', 'Fuma 2 Rev.B', 64.99, 25, 0, 4.6, 'Dual-tower air CPU cooler optimized for quiet operation'),
(8, 'EK-Nucleus AIO CR360 Lux D-RGB', 'EK', 'Nucleus AIO CR360 Lux D-RGB', 179.99, 15, 0, 4.6, '360mm AIO liquid CPU cooler with D-RGB lighting'),
(8, 'Cooler Master MasterLiquid ML240L V2 RGB', 'Cooler Master', 'MasterLiquid ML240L V2 RGB', 89.99, 30, 0, 4.5, '240mm AIO liquid CPU cooler with RGB lighting'),
-- Out of stock coolers
(8, 'Noctua NH-L9i-17xx chromax.black', 'Noctua', 'NH-L9i-17xx chromax.black', 59.95, 0, 0, 4.6, 'Low-profile CPU cooler for small form factor builds'),
(8, 'be quiet! Pure Rock 2', 'be quiet!', 'Pure Rock 2', 44.90, 0, 0, 4.5, 'Quiet tower CPU cooler designed for entry to mid-range systems'),
(8, 'DeepCool LS720', 'DeepCool', 'LS720', 139.99, 0, 0, 4.6, '360mm AIO liquid CPU cooler with ARGB fans'),
(8, 'NZXT Kraken Z73', 'NZXT', 'Kraken Z73', 279.99, 0, 0, 4.5, '360mm AIO liquid CPU cooler with LCD display'),
(8, 'Corsair iCUE H170i ELITE CAPELLIX XT', 'Corsair', 'H170i ELITE CAPELLIX XT', 299.99, 0, 0, 4.5, '420mm AIO liquid CPU cooler with iCUE support');

-- ============================================================================
-- PRODUCTS - Monitors (category_id = 9)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(9, 'Dell UltraSharp U2723QE', 'Dell', 'U2723QE', 619.99, 10, 0, 4.6, '27-inch 4K UHD IPS monitor with USB-C hub'),
(9, 'Dell S2721DGF', 'Dell', 'S2721DGF', 449.99, 10, 0, 4.5, '27-inch QHD gaming monitor with high refresh rate'),
(9, 'LG 27GP850-B', 'LG', '27GP850-B', 399.99, 12, 0, 4.6, '27-inch QHD gaming monitor with fast IPS panel'),
(9, 'LG 27GL850-B', 'LG', '27GL850-B', 349.99, 12, 0, 4.5, '27-inch QHD Nano IPS gaming monitor'),
(9, 'LG 32GQ950-B', 'LG', '32GQ950-B', 899.99, 6, 0, 4.5, '32-inch 4K gaming monitor designed for high detail'),
(9, 'Samsung Odyssey G7 32-inch', 'Samsung', 'Odyssey G7', 699.99, 6, 0, 4.4, '32-inch curved QHD gaming monitor'),
(9, 'Samsung Odyssey G9', 'Samsung', 'Odyssey G9', 1399.99, 4, 0, 4.4, '49-inch super ultrawide curved gaming monitor'),
(9, 'ASUS TUF Gaming VG27AQ', 'ASUS', 'VG27AQ', 329.99, 10, 0, 4.4, '27-inch QHD gaming monitor'),
(9, 'ASUS ROG Swift PG279QM', 'ASUS', 'PG279QM', 799.99, 5, 0, 4.5, '27-inch QHD esports gaming monitor'),
(9, 'ASUS ROG Swift OLED PG27AQDM', 'ASUS', 'PG27AQDM', 999.99, 4, 0, 4.6, '27-inch OLED gaming monitor'),
(9, 'Gigabyte M27Q', 'Gigabyte', 'M27Q', 299.99, 12, 0, 4.4, '27-inch QHD gaming monitor'),
(9, 'Gigabyte M32U', 'Gigabyte', 'M32U', 649.99, 6, 0, 4.5, '32-inch 4K gaming monitor'),
(9, 'Acer Nitro XV272U', 'Acer', 'XV272U', 299.99, 10, 0, 4.4, '27-inch QHD gaming monitor'),
(9, 'Acer Predator XB273U GX', 'Acer', 'XB273U GX', 699.99, 5, 0, 4.4, '27-inch QHD esports gaming monitor'),
(9, 'BenQ MOBIUZ EX2710Q', 'BenQ', 'EX2710Q', 399.99, 8, 0, 4.4, '27-inch QHD gaming monitor with HDRi'),
(9, 'BenQ PD2705U', 'BenQ', 'PD2705U', 549.99, 6, 0, 4.5, '27-inch 4K UHD designer monitor'),
(9, 'MSI Optix MAG274QRF-QD', 'MSI', 'MAG274QRF-QD', 449.99, 8, 0, 4.5, '27-inch QHD gaming monitor with wide color'),
(9, 'ViewSonic Elite XG270QG', 'ViewSonic', 'XG270QG', 599.99, 6, 0, 4.4, '27-inch QHD gaming monitor'),
(9, 'HP OMEN 27qs', 'HP', 'OMEN 27qs', 349.99, 8, 0, 4.4, '27-inch QHD gaming monitor'),
(9, 'AOC CQ27G2', 'AOC', 'CQ27G2', 249.99, 10, 0, 4.3, '27-inch curved QHD gaming monitor'),
-- Out of stock monitors
(9, 'Alienware AW3423DWF', 'Alienware', 'AW3423DWF', 999.99, 0, 0, 4.6, '34-inch QD-OLED ultrawide gaming monitor'),
(9, 'BenQ ZOWIE XL2546K', 'BenQ', 'XL2546K', 499.99, 0, 0, 4.5, '24.5-inch esports gaming monitor with high refresh rate'),
(9, 'ASUS ProArt PA278CV', 'ASUS', 'PA278CV', 329.99, 0, 0, 4.5, '27-inch QHD professional monitor with USB-C'),
(9, 'Samsung Smart Monitor M8', 'Samsung', 'Smart Monitor M8', 699.99, 0, 0, 4.3, '32-inch smart monitor with streaming apps and USB-C'),
(9, 'LG OLED evo C2 42-inch', 'LG', 'OLED42C2', 999.99, 0, 0, 4.6, '42-inch OLED display often used as a gaming monitor');

-- ============================================================================
-- PRODUCTS - Keyboards (category_id = 10)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(10, 'Keychron Q1', 'Keychron', 'Q1', 169.00, 20, 0, 4.5, 'Customizable mechanical keyboard with aluminum case'),
(10, 'Keychron K2', 'Keychron', 'K2', 79.00, 30, 0, 4.4, 'Compact 75% wireless mechanical keyboard'),
(10, 'Keychron K8 Pro', 'Keychron', 'K8 Pro', 109.00, 25, 0, 4.4, 'Tenkeyless wireless mechanical keyboard with QMK/VIA support'),
(10, 'Logitech G PRO X TKL', 'Logitech G', 'PRO X TKL', 199.99, 20, 0, 4.5, 'Tournament-grade tenkeyless gaming keyboard'),
(10, 'Logitech G915 TKL', 'Logitech G', 'G915 TKL', 229.99, 15, 0, 4.4, 'Wireless low-profile mechanical gaming keyboard'),
(10, 'Corsair K70 RGB PRO', 'Corsair', 'K70 RGB PRO', 169.99, 20, 0, 4.4, 'Mechanical gaming keyboard with aluminum frame and per-key RGB'),
(10, 'Corsair K65 RGB MINI', 'Corsair', 'K65 RGB MINI', 109.99, 20, 0, 4.4, 'Compact 60% mechanical gaming keyboard'),
(10, 'Razer Huntsman V2', 'Razer', 'Huntsman V2', 189.99, 15, 0, 4.4, 'Optical gaming keyboard designed for fast actuation'),
(10, 'Razer BlackWidow V4', 'Razer', 'BlackWidow V4', 169.99, 15, 0, 4.4, 'Mechanical gaming keyboard with per-key RGB'),
(10, 'SteelSeries Apex Pro TKL', 'SteelSeries', 'Apex Pro TKL', 189.99, 15, 0, 4.5, 'Adjustable actuation mechanical gaming keyboard (TKL)'),
(10, 'SteelSeries Apex 3', 'SteelSeries', 'Apex 3', 49.99, 35, 0, 4.3, 'RGB gaming keyboard with quiet switches and IP32 resistance'),
(10, 'Ducky One 3 Mini', 'Ducky', 'One 3 Mini', 119.00, 20, 0, 4.5, '60% mechanical keyboard with hot-swappable switches'),
(10, 'Ducky One 3 TKL', 'Ducky', 'One 3 TKL', 129.00, 20, 0, 4.5, 'Tenkeyless mechanical keyboard with hot-swappable switches'),
(10, 'Glorious GMMK Pro', 'Glorious', 'GMMK Pro', 169.99, 20, 0, 4.4, '75% barebones mechanical keyboard with rotary knob'),
(10, 'Glorious GMMK 2', 'Glorious', 'GMMK 2', 119.99, 20, 0, 4.4, 'Compact mechanical keyboard with hot-swappable sockets'),
(10, 'ASUS ROG Strix Scope II 96', 'ASUS', 'ROG Strix Scope II 96', 179.99, 15, 0, 4.4, '96% gaming keyboard with compact layout and RGB'),
(10, 'ASUS ROG Claymore II', 'ASUS', 'ROG Claymore II', 249.99, 10, 0, 4.4, 'Modular wireless mechanical gaming keyboard with detachable numpad'),
(10, 'HyperX Alloy Origins', 'HyperX', 'Alloy Origins', 109.99, 20, 0, 4.4, 'Compact mechanical gaming keyboard with aluminum body and RGB'),
(10, 'HyperX Alloy FPS Pro', 'HyperX', 'Alloy FPS Pro', 69.99, 25, 0, 4.3, 'Tenkeyless mechanical gaming keyboard'),
(10, 'Wooting 60HE', 'Wooting', '60HE', 174.99, 15, 0, 4.6, '60% analog mechanical keyboard with rapid trigger capability'),
-- Out of stock keyboards
(10, 'Corsair K100 RGB', 'Corsair', 'K100 RGB', 249.99, 0, 0, 4.4, 'Flagship mechanical gaming keyboard with macro controls and RGB'),
(10, 'Razer Huntsman Mini', 'Razer', 'Huntsman Mini', 119.99, 0, 0, 4.4, 'Compact 60% optical gaming keyboard'),
(10, 'SteelSeries Apex 7', 'SteelSeries', 'Apex 7', 149.99, 0, 0, 4.4, 'Mechanical gaming keyboard with OLED smart display'),
(10, 'Logitech MX Keys', 'Logitech', 'MX Keys', 119.99, 0, 0, 4.5, 'Wireless illuminated keyboard for productivity'),
(10, 'Logitech G413 SE', 'Logitech G', 'G413 SE', 69.99, 0, 0, 4.3, 'Mechanical gaming keyboard with durable aluminum top case');

-- ============================================================================
-- PRODUCTS - Mice (category_id = 11)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(11, 'Logitech G PRO X SUPERLIGHT 2', 'Logitech G', 'PRO X SUPERLIGHT 2', 159.99, 20, 0, 4.6, 'Ultra-lightweight wireless gaming mouse'),
(11, 'Logitech G502 X', 'Logitech G', 'G502 X', 79.99, 30, 0, 4.6, 'Wired gaming mouse with customizable controls'),
(11, 'Logitech G305 LIGHTSPEED', 'Logitech G', 'G305 LIGHTSPEED', 59.99, 35, 0, 4.5, 'Wireless gaming mouse with LIGHTSPEED connection'),
(11, 'Logitech G703 LIGHTSPEED', 'Logitech G', 'G703 LIGHTSPEED', 99.99, 20, 0, 4.5, 'Wireless ergonomic gaming mouse'),
(11, 'Logitech G903 LIGHTSPEED', 'Logitech G', 'G903 LIGHTSPEED', 149.99, 15, 0, 4.4, 'Wireless gaming mouse with ambidextrous design'),
(11, 'Razer DeathAdder V3 Pro', 'Razer', 'DeathAdder V3 Pro', 149.99, 20, 0, 4.6, 'Wireless ergonomic esports mouse'),
(11, 'Razer Viper V2 Pro', 'Razer', 'Viper V2 Pro', 149.99, 15, 0, 4.6, 'Ultra-lightweight wireless esports mouse'),
(11, 'Razer Basilisk V3', 'Razer', 'Basilisk V3', 69.99, 25, 0, 4.5, 'Wired customizable gaming mouse with RGB lighting'),
(11, 'Razer Naga V2 Pro', 'Razer', 'Naga V2 Pro', 179.99, 10, 0, 4.5, 'Wireless MMO gaming mouse with modular side plates'),
(11, 'SteelSeries Rival 600', 'SteelSeries', 'Rival 600', 79.99, 20, 0, 4.4, 'Wired gaming mouse with dual sensor system'),
(11, 'SteelSeries Aerox 3 Wireless', 'SteelSeries', 'Aerox 3 Wireless', 99.99, 20, 0, 4.4, 'Ultra-lightweight wireless gaming mouse'),
(11, 'SteelSeries Prime Wireless', 'SteelSeries', 'Prime Wireless', 129.99, 15, 0, 4.4, 'Wireless esports mouse with ergonomic shape'),
(11, 'Corsair M65 RGB ULTRA', 'Corsair', 'M65 RGB ULTRA', 79.99, 20, 0, 4.4, 'Wired FPS gaming mouse with adjustable weights'),
(11, 'Corsair HARPOON RGB WIRELESS', 'Corsair', 'HARPOON RGB WIRELESS', 59.99, 25, 0, 4.3, 'Wireless gaming mouse with compact ergonomic design'),
(11, 'Corsair DARK CORE RGB PRO SE', 'Corsair', 'DARK CORE RGB PRO SE', 89.99, 20, 0, 4.3, 'Wireless gaming mouse with Qi wireless charging support'),
(11, 'Glorious Model O Wireless', 'Glorious', 'Model O Wireless', 79.99, 20, 0, 4.4, 'Ultra-lightweight wireless gaming mouse with honeycomb shell'),
(11, 'Glorious Model D', 'Glorious', 'Model D', 49.99, 25, 0, 4.4, 'Ergonomic lightweight gaming mouse'),
(11, 'Zowie EC2-C', 'Zowie', 'EC2-C', 69.99, 20, 0, 4.4, 'Ergonomic esports mouse designed for competitive play'),
(11, 'Zowie FK2-C', 'Zowie', 'FK2-C', 69.99, 20, 0, 4.4, 'Ambidextrous esports mouse designed for competitive play'),
(11, 'HyperX Pulsefire Haste 2 Wireless', 'HyperX', 'Pulsefire Haste 2 Wireless', 89.99, 20, 0, 4.4, 'Lightweight wireless gaming mouse'),
-- Out of stock mice
(11, 'Logitech MX Master 3S', 'Logitech', 'MX Master 3S', 99.99, 0, 0, 4.6, 'Wireless mouse designed for productivity with MagSpeed scrolling'),
(11, 'Logitech MX Anywhere 3', 'Logitech', 'MX Anywhere 3', 79.99, 0, 0, 4.5, 'Compact wireless mouse for travel and multi-device use'),
(11, 'Razer Orochi V2', 'Razer', 'Orochi V2', 69.99, 0, 0, 4.4, 'Compact wireless gaming mouse designed for portability'),
(11, 'Razer Viper Mini', 'Razer', 'Viper Mini', 39.99, 0, 0, 4.5, 'Lightweight wired gaming mouse for small-to-medium hands'),
(11, 'SteelSeries Rival 3', 'SteelSeries', 'Rival 3', 29.99, 0, 0, 4.3, 'Wired gaming mouse designed for durability and performance');

-- ============================================================================
-- PRODUCTS - Headsets (category_id = 12)
-- ============================================================================
INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(12, 'SteelSeries Arctis Nova Pro Wireless', 'SteelSeries', 'Arctis Nova Pro Wireless', 349.99, 20, 0, 4.6, 'Wireless gaming headset with active noise cancellation and base station'),
(12, 'SteelSeries Arctis Nova 7', 'SteelSeries', 'Arctis Nova 7', 179.99, 25, 0, 4.5, 'Wireless multi-platform gaming headset with USB-C dongle and Bluetooth'),
(12, 'SteelSeries Arctis Nova 1', 'SteelSeries', 'Arctis Nova 1', 59.99, 40, 0, 4.4, 'Wired gaming headset with lightweight design and clear voice mic'),
(12, 'HyperX Cloud II', 'HyperX', 'Cloud II', 99.99, 35, 0, 4.5, 'Comfortable wired gaming headset with USB sound card'),
(12, 'HyperX Cloud Alpha Wireless', 'HyperX', 'Cloud Alpha Wireless', 199.99, 20, 0, 4.5, 'Wireless gaming headset known for long battery life'),
(12, 'Logitech G PRO X 2 LIGHTSPEED', 'Logitech G', 'PRO X 2 LIGHTSPEED', 249.99, 20, 0, 4.5, 'Wireless gaming headset with PRO-G audio drivers and detachable mic'),
(12, 'Logitech G733 LIGHTSPEED', 'Logitech G', 'G733 LIGHTSPEED', 149.99, 25, 0, 4.4, 'Lightweight wireless gaming headset with RGB lighting'),
(12, 'Razer BlackShark V2 Pro', 'Razer', 'BlackShark V2 Pro', 199.99, 20, 0, 4.5, 'Wireless esports headset with detachable microphone'),
(12, 'Razer Kraken V3 HyperSense', 'Razer', 'Kraken V3 HyperSense', 129.99, 20, 0, 4.4, 'Wired gaming headset with haptic feedback'),
(12, 'Razer Barracuda X', 'Razer', 'Barracuda X', 99.99, 25, 0, 4.4, 'Wireless headset with USB-C dongle for multi-platform use'),
(12, 'Corsair HS80 RGB Wireless', 'Corsair', 'HS80 RGB Wireless', 149.99, 25, 0, 4.4, 'Wireless gaming headset with immersive spatial audio support'),
(12, 'Corsair Virtuoso RGB Wireless XT', 'Corsair', 'Virtuoso RGB Wireless XT', 269.99, 15, 0, 4.4, 'Premium wireless gaming headset with dual wireless connections'),
(12, 'Sony INZONE H9', 'Sony', 'INZONE H9', 299.99, 15, 0, 4.4, 'Wireless gaming headset with noise cancellation'),
(12, 'Sony INZONE H7', 'Sony', 'INZONE H7', 229.99, 15, 0, 4.4, 'Wireless gaming headset with low-latency connection'),
(12, 'EPOS H6PRO Closed', 'EPOS', 'H6PRO Closed', 179.00, 15, 0, 4.4, 'Wired gaming headset with detachable microphone (closed-back)'),
(12, 'Sennheiser PC38X', 'Sennheiser', 'PC38X', 169.00, 20, 0, 4.6, 'Open-back gaming headset with broadcast-quality microphone'),
(12, 'Astro A50 Wireless + Base Station', 'ASTRO', 'A50 Wireless', 299.99, 10, 0, 4.4, 'Wireless gaming headset with base station dock'),
(12, 'Turtle Beach Stealth 700 Gen 2 MAX', 'Turtle Beach', 'Stealth 700 Gen 2 MAX', 199.99, 15, 0, 4.4, 'Wireless gaming headset with long battery life'),
(12, 'Beyerdynamic MMX 300 (2nd Generation)', 'beyerdynamic', 'MMX 300 (2nd Gen)', 299.00, 10, 0, 4.6, 'Closed-back gaming headset with studio-grade sound'),
(12, 'JBL Quantum 910 Wireless', 'JBL', 'Quantum 910 Wireless', 299.95, 10, 0, 4.4, 'Wireless gaming headset with spatial audio support'),
-- Out of stock headsets
(12, 'Logitech G Astro A40 TR + MixAmp Pro TR', 'Logitech G', 'A40 TR + MixAmp Pro TR', 249.99, 0, 0, 4.4, 'Wired gaming headset bundle with MixAmp for audio control'),
(12, 'Sennheiser GAME ONE', 'Sennheiser', 'GAME ONE', 129.95, 0, 0, 4.5, 'Open-back gaming headset with integrated microphone'),
(12, 'Bose QuietComfort 35 II Gaming Headset', 'Bose', 'QC35 II Gaming', 329.00, 0, 0, 4.4, 'Gaming headset based on QuietComfort headphones with boom mic accessory'),
(12, 'Razer Kraken Kitty V2', 'Razer', 'Kraken Kitty V2', 99.99, 0, 0, 4.3, 'Wired gaming headset with kitty ear design and RGB lighting'),
(12, 'Audio-Technica ATH-M50xSTS', 'Audio-Technica', 'ATH-M50xSTS', 199.00, 0, 0, 4.5, 'Studio headphone with integrated streaming microphone');

-- ============================================================================
-- BUILDS
-- ============================================================================
INSERT INTO Build (user_id, name, description) VALUES
(1, 'High-End Gaming PC', 'Flagship build for 4K gaming'),
(1, 'Budget Gaming Build', 'Great 1080p gaming on a budget'),
(1, 'Workstation Build', 'Productivity and content creation');

INSERT INTO BuildItem (build_id, product_id, slot_type) VALUES
(1, 14, 'CPU'),
(1, 39, 'MOBO'),
(1, 54, 'GPU'),
(1, 79, 'RAM'),
(1, 124, 'PSU'),
(1, 100, 'CASE'),
(1, 151, 'STORAGE');

-- ============================================================================
-- SAMPLE ORDERS
-- ============================================================================

-- Order 1: High-end build (delivered)
WITH items(product_id, quantity, unit_price) AS (
  VALUES
    (14, 1, 399.99),
    (39, 1, 299.99),
    (54, 1, 999.99),
    (79, 1, 169.99),
    (124, 1, 139.99),
    (100, 1, 169.99),
    (151, 1, 179.99)
),
new_order AS (
  INSERT INTO Orders (user_id, total_price, status, shipping_address)
  SELECT
    1,
    ROUND(SUM(quantity * unit_price)::numeric, 2) AS total_price,
    'delivered'::order_status_enum,
    'Koc University, Sariyer, Istanbul 34450, Turkey' AS shipping_address
  FROM items
  RETURNING order_id
)
INSERT INTO OrderItem (order_id, product_id, quantity, unit_price)
SELECT new_order.order_id, items.product_id, items.quantity, items.unit_price
FROM new_order
CROSS JOIN items;

-- Order 2: Budget build (shipped)
WITH items(product_id, quantity, unit_price) AS (
  VALUES
    (23, 1, 129.99),
    (47, 1, 149.99),
    (76, 1, 269.99),
    (98, 1, 49.99),
    (146, 1, 59.99),
    (115, 1, 99.99),
    (154, 1, 89.99)
),
new_order AS (
  INSERT INTO Orders (user_id, total_price, status, shipping_address)
  SELECT
    1,
    ROUND(SUM(quantity * unit_price)::numeric, 2) AS total_price,
    'shipped'::order_status_enum,
    'Koc University, Sariyer, Istanbul 34450, Turkey' AS shipping_address
  FROM items
  RETURNING order_id
)
INSERT INTO OrderItem (order_id, product_id, quantity, unit_price)
SELECT new_order.order_id, items.product_id, items.quantity, items.unit_price
FROM new_order
CROSS JOIN items;

-- Order 3: Ultimate build (processing)
WITH items(product_id, quantity, unit_price) AS (
  VALUES
    (12, 1, 649.99),
    (35, 1, 699.99),
    (51, 1, 1599.99),
    (87, 1, 329.99),
    (137, 1, 399.99),
    (106, 1, 189.99),
    (159, 1, 299.99)
),
new_order AS (
  INSERT INTO Orders (user_id, total_price, status, shipping_address)
  SELECT
    2,
    ROUND(SUM(quantity * unit_price)::numeric, 2) AS total_price,
    'processing'::order_status_enum,
    'Koc University, Sariyer, Istanbul 34450, Turkey' AS shipping_address
  FROM items
  RETURNING order_id
)
INSERT INTO OrderItem (order_id, product_id, quantity, unit_price)
SELECT new_order.order_id, items.product_id, items.quantity, items.unit_price
FROM new_order
CROSS JOIN items;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================
SELECT 'Categories' AS table_name, COUNT(*)::int AS count FROM Category
UNION ALL SELECT 'Users', COUNT(*) FROM "User"
UNION ALL SELECT 'Products', COUNT(*) FROM Product
UNION ALL SELECT 'CPU Specs', COUNT(*) FROM CPU_Spec
UNION ALL SELECT 'MOBO Specs', COUNT(*) FROM MOBO_Spec
UNION ALL SELECT 'GPU Specs', COUNT(*) FROM GPU_Spec
UNION ALL SELECT 'RAM Specs', COUNT(*) FROM RAM_Spec
UNION ALL SELECT 'Case Specs', COUNT(*) FROM CASE_Spec
UNION ALL SELECT 'PSU Specs', COUNT(*) FROM PSU_Spec
UNION ALL SELECT 'Storage Specs', COUNT(*) FROM Storage_Spec
UNION ALL SELECT 'Builds', COUNT(*) FROM Build
UNION ALL SELECT 'Build Items', COUNT(*) FROM BuildItem
UNION ALL SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL SELECT 'Order Items', COUNT(*) FROM OrderItem;

-- Products per category
SELECT c.name AS category, COUNT(p.product_id)::int AS products
FROM Category c
LEFT JOIN Product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name
ORDER BY c.category_id;
