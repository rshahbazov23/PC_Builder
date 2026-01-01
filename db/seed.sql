INSERT INTO Category (name, slug, description, icon) VALUES
('CPU', 'cpu', 'Central Processing Units - The brain of your computer', 'cpu'),
('GPU', 'gpu', 'Graphics Processing Units - For gaming and creative work', 'gpu'),
('Motherboard', 'motherboard', 'The backbone that connects all components', 'motherboard'),
('RAM', 'ram', 'Random Access Memory - Fast temporary storage', 'ram'),
('PSU', 'psu', 'Power Supply Units - Reliable power for your system', 'psu'),
('Case', 'case', 'Computer Cases - House your components in style', 'case'),
('Storage', 'storage', 'SSDs and HDDs - Store your data', 'storage');

INSERT INTO "User" (username, email) VALUES
('demo_user', 'demo@pcbuilder.com'),
('admin', 'admin@pcbuilder.com');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(1, 'Intel Core i9-14900K', 'Intel', 'i9-14900K', 549.99, 25, 125, 4.8, 'Flagship 24-core processor with incredible performance'),
(1, 'Intel Core i9-14900KF', 'Intel', 'i9-14900KF', 524.99, 30, 125, 4.7, '24-core processor without integrated graphics'),
(1, 'Intel Core i7-14700K', 'Intel', 'i7-14700K', 399.99, 45, 125, 4.8, '20-core processor, excellent for gaming and productivity'),
(1, 'Intel Core i7-14700KF', 'Intel', 'i7-14700KF', 379.99, 40, 125, 4.7, '20-core processor without integrated graphics'),
(1, 'Intel Core i5-14600K', 'Intel', 'i5-14600K', 299.99, 60, 125, 4.7, '14-core processor, great value for gamers'),
(1, 'Intel Core i5-14600KF', 'Intel', 'i5-14600KF', 279.99, 55, 125, 4.6, '14-core processor without integrated graphics'),
(1, 'Intel Core i5-14400F', 'Intel', 'i5-14400F', 199.99, 80, 65, 4.5, 'Budget-friendly 10-core processor'),
(1, 'Intel Core i3-14100F', 'Intel', 'i3-14100F', 119.99, 100, 58, 4.4, 'Entry-level 4-core processor');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(1, 'Intel Core i5-12400F', 'Intel', 'i5-12400F', 149.99, 70, 65, 4.6, 'Excellent budget gaming CPU'),
(1, 'Intel Core i7-12700K', 'Intel', 'i7-12700K', 289.99, 35, 125, 4.5, '12-core performance CPU');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(1, 'AMD Ryzen 9 7950X', 'AMD', 'Ryzen 9 7950X', 549.99, 20, 170, 4.9, '16-core flagship with exceptional multi-threaded performance'),
(1, 'AMD Ryzen 9 7950X3D', 'AMD', 'Ryzen 9 7950X3D', 649.99, 15, 120, 4.9, 'Best gaming CPU with 3D V-Cache'),
(1, 'AMD Ryzen 9 7900X', 'AMD', 'Ryzen 9 7900X', 399.99, 30, 170, 4.8, '12-core powerhouse for creators'),
(1, 'AMD Ryzen 7 7800X3D', 'AMD', 'Ryzen 7 7800X3D', 399.99, 25, 120, 4.9, 'Ultimate gaming CPU with 3D V-Cache'),
(1, 'AMD Ryzen 7 7700X', 'AMD', 'Ryzen 7 7700X', 299.99, 45, 105, 4.7, '8-core processor for gaming and streaming'),
(1, 'AMD Ryzen 5 7600X', 'AMD', 'Ryzen 5 7600X', 229.99, 55, 105, 4.6, '6-core gaming CPU with great value'),
(1, 'AMD Ryzen 5 7600', 'AMD', 'Ryzen 5 7600', 199.99, 65, 65, 4.5, 'Efficient 6-core processor');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(1, 'AMD Ryzen 9 5950X', 'AMD', 'Ryzen 9 5950X', 399.99, 20, 105, 4.8, '16-core AM4 flagship'),
(1, 'AMD Ryzen 9 5900X', 'AMD', 'Ryzen 9 5900X', 299.99, 35, 105, 4.7, '12-core AM4 high-end processor'),
(1, 'AMD Ryzen 7 5800X3D', 'AMD', 'Ryzen 7 5800X3D', 299.99, 25, 105, 4.9, 'Best AM4 gaming CPU with 3D V-Cache'),
(1, 'AMD Ryzen 7 5800X', 'AMD', 'Ryzen 7 5800X', 199.99, 50, 105, 4.6, '8-core AM4 processor'),
(1, 'AMD Ryzen 7 5700X', 'AMD', 'Ryzen 7 5700X', 159.99, 60, 65, 4.6, 'Efficient 8-core AM4 CPU'),
(1, 'AMD Ryzen 5 5600X', 'AMD', 'Ryzen 5 5600X', 129.99, 80, 65, 4.7, 'Popular 6-core gaming CPU'),
(1, 'AMD Ryzen 5 5600', 'AMD', 'Ryzen 5 5600', 119.99, 90, 65, 4.6, 'Budget 6-core AM4 processor'),
(1, 'AMD Ryzen 5 5500', 'AMD', 'Ryzen 5 5500', 89.99, 100, 65, 4.4, 'Entry-level 6-core AM4');

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

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(3, 'ASUS ROG Maximus Z790 Hero', 'ASUS', 'ROG Maximus Z790 Hero', 629.99, 15, 0, 4.8, 'Premium Z790 motherboard for enthusiasts'),
(3, 'ASUS ROG Strix Z790-E Gaming', 'ASUS', 'ROG Strix Z790-E', 449.99, 25, 0, 4.7, 'High-end gaming motherboard'),
(3, 'MSI MPG Z790 Edge WiFi', 'MSI', 'MPG Z790 Edge WiFi', 379.99, 30, 0, 4.6, 'Feature-rich Z790 board'),
(3, 'MSI MAG Z790 Tomahawk WiFi', 'MSI', 'MAG Z790 Tomahawk WiFi', 289.99, 40, 0, 4.7, 'Popular mid-range Z790'),
(3, 'Gigabyte Z790 Aorus Elite AX', 'Gigabyte', 'Z790 Aorus Elite AX', 269.99, 35, 0, 4.5, 'Solid Z790 with WiFi'),
(3, 'ASRock Z790 Pro RS', 'ASRock', 'Z790 Pro RS', 199.99, 45, 0, 4.4, 'Budget-friendly Z790'),
(3, 'ASUS Prime B760-Plus', 'ASUS', 'Prime B760-Plus', 159.99, 50, 0, 4.5, 'Reliable B760 motherboard'),
(3, 'MSI PRO B760M-A WiFi', 'MSI', 'PRO B760M-A WiFi', 139.99, 60, 0, 4.4, 'Compact B760 with WiFi'),
(3, 'Gigabyte B760M DS3H', 'Gigabyte', 'B760M DS3H', 99.99, 70, 0, 4.3, 'Entry-level B760 board');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(3, 'ASUS ROG Crosshair X670E Hero', 'ASUS', 'ROG Crosshair X670E Hero', 699.99, 10, 0, 4.9, 'Flagship AM5 motherboard'),
(3, 'ASUS ROG Strix X670E-E Gaming', 'ASUS', 'ROG Strix X670E-E', 479.99, 20, 0, 4.7, 'Premium gaming AM5 board'),
(3, 'MSI MPG X670E Carbon WiFi', 'MSI', 'MPG X670E Carbon WiFi', 449.99, 25, 0, 4.6, 'Feature-packed X670E'),
(3, 'Gigabyte X670E Aorus Master', 'Gigabyte', 'X670E Aorus Master', 429.99, 20, 0, 4.7, 'High-end X670E board'),
(3, 'MSI MAG X670E Tomahawk WiFi', 'MSI', 'MAG X670E Tomahawk WiFi', 299.99, 35, 0, 4.6, 'Popular X670E choice'),
(3, 'ASUS TUF Gaming B650-Plus', 'ASUS', 'TUF Gaming B650-Plus', 179.99, 45, 0, 4.5, 'Durable B650 board'),
(3, 'MSI PRO B650-P WiFi', 'MSI', 'PRO B650-P WiFi', 159.99, 50, 0, 4.4, 'Value B650 with WiFi'),
(3, 'Gigabyte B650M DS3H', 'Gigabyte', 'B650M DS3H', 119.99, 60, 0, 4.3, 'Budget AM5 motherboard'),
(3, 'ASRock B650M-HDV/M.2', 'ASRock', 'B650M-HDV/M.2', 99.99, 55, 0, 4.2, 'Entry-level AM5 board');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(3, 'ASUS ROG Crosshair VIII Hero', 'ASUS', 'ROG Crosshair VIII Hero', 349.99, 15, 0, 4.7, 'Premium X570 motherboard'),
(3, 'MSI MAG X570S Tomahawk WiFi', 'MSI', 'MAG X570S Tomahawk WiFi', 219.99, 30, 0, 4.6, 'Solid X570 board'),
(3, 'Gigabyte B550 Aorus Pro', 'Gigabyte', 'B550 Aorus Pro', 179.99, 40, 0, 4.5, 'Popular B550 choice'),
(3, 'ASUS TUF Gaming B550-Plus', 'ASUS', 'TUF Gaming B550-Plus', 149.99, 50, 0, 4.5, 'Reliable B550 board'),
(3, 'MSI B550-A PRO', 'MSI', 'B550-A PRO', 129.99, 55, 0, 4.4, 'Value B550 motherboard'),
(3, 'ASRock B550M Pro4', 'ASRock', 'B550M Pro4', 109.99, 60, 0, 4.3, 'Compact B550 board'),
(3, 'Gigabyte A520M DS3H', 'Gigabyte', 'A520M DS3H', 69.99, 80, 0, 4.2, 'Budget AM4 motherboard');

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
(2, 'ASUS Dual RTX 4060', 'ASUS', 'Dual RTX 4060', 309.99, 45, 115, 4.3, 'Budget RTX 4060');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
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
(4, 'G.Skill Trident Z5 RGB DDR5-6000 64GB (2x32GB)', 'G.Skill', 'Trident Z5 RGB 6000 64GB', 329.99, 20, 5, 4.8, '64GB high-speed DDR5');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
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
(6, 'Lian Li Lancool II Mesh', 'Lian Li', 'Lancool II Mesh', 119.99, 50, 0, 4.6, 'Popular mesh case');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(6, 'NZXT H5 Flow', 'NZXT', 'H5 Flow', 94.99, 50, 0, 4.5, 'Compact high-airflow case'),
(6, 'Corsair 4000D Airflow Micro-ATX', 'Corsair', '4000D mATX Airflow', 89.99, 45, 0, 4.4, 'Compact version of 4000D'),
(6, 'Fractal Design Meshify C Mini', 'Fractal Design', 'Meshify C Mini', 99.99, 40, 0, 4.5, 'Compact mesh case'),
(6, 'Cooler Master NR400', 'Cooler Master', 'NR400', 69.99, 55, 0, 4.4, 'Budget mATX case'),
(6, 'Thermaltake S100', 'Thermaltake', 'S100', 59.99, 60, 0, 4.3, 'Entry-level mATX case'),
(6, 'DeepCool CC560', 'DeepCool', 'CC560', 69.99, 50, 0, 4.4, 'Affordable airflow case');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(6, 'NZXT H1 V2', 'NZXT', 'H1 V2', 399.99, 15, 0, 4.6, 'Premium ITX with built-in PSU/AIO'),
(6, 'Lian Li A4-H2O', 'Lian Li', 'A4-H2O', 159.99, 25, 0, 4.5, 'Compact ITX with AIO support'),
(6, 'Cooler Master NR200P', 'Cooler Master', 'NR200P', 119.99, 35, 0, 4.7, 'Popular ITX case'),
(6, 'SSUPD Meshroom S', 'SSUPD', 'Meshroom S', 139.99, 20, 0, 4.5, 'Mesh ITX case');

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
(5, 'ASUS ROG Strix 850W', 'ASUS', 'ROG Strix 850W', 169.99, 30, 0, 4.6, '850W 80+ Gold ROG PSU');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(5, 'Corsair CV650', 'Corsair', 'CV650', 59.99, 70, 0, 4.3, '650W 80+ Bronze budget PSU'),
(5, 'Corsair CV550', 'Corsair', 'CV550', 49.99, 80, 0, 4.2, '550W 80+ Bronze budget PSU'),
(5, 'EVGA 600 BR', 'EVGA', '600 BR', 54.99, 65, 0, 4.3, '600W 80+ Bronze reliable PSU'),
(5, 'Thermaltake Smart 600W', 'Thermaltake', 'Smart 600W', 49.99, 75, 0, 4.2, '600W 80+ budget option'),
(5, 'Cooler Master MWE Gold 650', 'Cooler Master', 'MWE Gold 650', 79.99, 50, 0, 4.4, '650W 80+ Gold value PSU');

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
(7, 'Kingston NV2 1TB', 'Kingston', 'NV2 1TB', 49.99, 80, 4, 4.4, 'Budget NVMe SSD');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(7, 'Samsung 870 EVO 2TB', 'Samsung', '870 EVO 2TB', 169.99, 40, 4, 4.8, 'Best SATA SSD'),
(7, 'Samsung 870 EVO 1TB', 'Samsung', '870 EVO 1TB', 89.99, 60, 4, 4.8, 'Reliable SATA SSD'),
(7, 'Samsung 870 EVO 500GB', 'Samsung', '870 EVO 500GB', 49.99, 80, 4, 4.7, 'Popular SATA SSD'),
(7, 'Crucial MX500 2TB', 'Crucial', 'MX500 2TB', 139.99, 45, 3, 4.7, 'Reliable SATA SSD'),
(7, 'Crucial MX500 1TB', 'Crucial', 'MX500 1TB', 69.99, 65, 3, 4.7, 'Value SATA SSD'),
(7, 'WD Blue 3D NAND 2TB', 'Western Digital', 'Blue 3D 2TB', 149.99, 40, 3, 4.6, 'Dependable SATA SSD'),
(7, 'WD Blue 3D NAND 1TB', 'Western Digital', 'Blue 3D 1TB', 79.99, 55, 3, 4.6, 'Budget SATA SSD');

INSERT INTO Product (category_id, name, brand, model, price, stock_qty, power_watts, rating, description) VALUES
(7, 'Seagate Barracuda 8TB', 'Seagate', 'Barracuda 8TB', 139.99, 30, 9, 4.5, 'High-capacity storage'),
(7, 'Seagate Barracuda 4TB', 'Seagate', 'Barracuda 4TB', 79.99, 50, 7, 4.5, 'Popular storage drive'),
(7, 'Seagate Barracuda 2TB', 'Seagate', 'Barracuda 2TB', 54.99, 70, 6, 4.4, 'Budget mass storage'),
(7, 'WD Blue 4TB', 'Western Digital', 'Blue 4TB', 84.99, 45, 7, 4.5, 'Reliable storage HDD'),
(7, 'WD Blue 2TB', 'Western Digital', 'Blue 2TB', 54.99, 65, 6, 4.4, 'Entry-level HDD'),
(7, 'Toshiba X300 8TB', 'Toshiba', 'X300 8TB', 159.99, 25, 9, 4.4, 'Performance HDD'),
(7, 'Toshiba P300 4TB', 'Toshiba', 'P300 4TB', 74.99, 40, 7, 4.3, 'Budget performance HDD');

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

-- Sample orders (optional tables, but populated for meaningful query outputs)
-- Insert orders and their line items using CTEs so we don't rely on hard-coded order_id values.

WITH items(product_id, quantity, unit_price) AS (
  VALUES
    (14, 1, 399.99),  -- AMD Ryzen 7 7800X3D
    (39, 1, 299.99),  -- MSI MAG X670E Tomahawk WiFi
    (54, 1, 999.99),  -- NVIDIA GeForce RTX 4080 Super
    (79, 1, 169.99),  -- G.Skill Trident Z5 RGB DDR5-6000 32GB
    (124, 1, 139.99), -- Corsair RM850x
    (100, 1, 169.99), -- Lian Li O11 Dynamic EVO
    (151, 1, 179.99)  -- Samsung 990 Pro 2TB
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

WITH items(product_id, quantity, unit_price) AS (
  VALUES
    (23, 1, 129.99), -- AMD Ryzen 5 5600X
    (47, 1, 149.99), -- ASUS TUF Gaming B550-Plus
    (76, 1, 269.99), -- AMD Radeon RX 7600
    (98, 1, 49.99),  -- G.Skill Ripjaws V DDR4-3600 16GB
    (146, 1, 59.99), -- Corsair CV650
    (115, 1, 99.99), -- Fractal Design Meshify C Mini
    (154, 1, 89.99)  -- Samsung 980 Pro 1TB
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

WITH items(product_id, quantity, unit_price) AS (
  VALUES
    (12, 1, 649.99),  -- AMD Ryzen 9 7950X3D
    (35, 1, 699.99),  -- ASUS ROG Crosshair X670E Hero
    (51, 1, 1599.99), -- NVIDIA GeForce RTX 4090 Founders Edition
    (87, 1, 329.99),  -- G.Skill Trident Z5 RGB DDR5-6000 64GB
    (137, 1, 399.99), -- Corsair HX1500i
    (106, 1, 189.99), -- Fractal Design Torrent
    (159, 1, 299.99)  -- Crucial T700 2TB
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
