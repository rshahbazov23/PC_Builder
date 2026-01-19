-- Migration: Add product images for ALL product categories
-- This updates the image_url for all products that have generated images
-- Total: 307 product images

-- =====================
-- GPU Images (27 total)
-- =====================

-- NVIDIA GPUs
UPDATE Product SET image_url = '/images/components/GPU-NVIDIA-RTX4090-FE.png' WHERE name = 'NVIDIA GeForce RTX 4090 Founders Edition';
UPDATE Product SET image_url = '/images/components/GPU-ASUS-ROG-STRIX-RTX4090-OC.png' WHERE name = 'ASUS ROG Strix RTX 4090 OC';
UPDATE Product SET image_url = '/images/components/GPU-MSI-RTX4090-SUPRIM-X.png' WHERE name = 'MSI GeForce RTX 4090 Suprim X';
UPDATE Product SET image_url = '/images/components/GPU-NVIDIA-RTX4080-SUPER.png' WHERE name = 'NVIDIA GeForce RTX 4080 Super';
UPDATE Product SET image_url = '/images/components/GPU-ASUS-TUF-RTX4080-SUPER.png' WHERE name = 'ASUS TUF Gaming RTX 4080 Super';
UPDATE Product SET image_url = '/images/components/GPU-GIGABYTE-RTX4080-SUPER-GAMING.png' WHERE name = 'Gigabyte RTX 4080 Super Gaming OC';
UPDATE Product SET image_url = '/images/components/GPU-NVIDIA-RTX4070TI-SUPER.png' WHERE name = 'NVIDIA GeForce RTX 4070 Ti Super';
UPDATE Product SET image_url = '/images/components/GPU-MSI-RTX4070TI-SUPER-VENTUS.png' WHERE name = 'MSI GeForce RTX 4070 Ti Super Ventus 3X';
UPDATE Product SET image_url = '/images/components/GPU-NVIDIA-RTX4070-SUPER.png' WHERE name = 'NVIDIA GeForce RTX 4070 Super';
UPDATE Product SET image_url = '/images/components/GPU-ASUS-DUAL-RTX4070-SUPER.png' WHERE name = 'ASUS Dual RTX 4070 Super';
UPDATE Product SET image_url = '/images/components/GPU-NVIDIA-RTX4070.png' WHERE name = 'NVIDIA GeForce RTX 4070';
UPDATE Product SET image_url = '/images/components/GPU-GIGABYTE-RTX4070-WINDFORCE.png' WHERE name = 'Gigabyte RTX 4070 Windforce OC';
UPDATE Product SET image_url = '/images/components/GPU-NVIDIA-RTX4060TI-16GB.png' WHERE name = 'NVIDIA GeForce RTX 4060 Ti 16GB';
UPDATE Product SET image_url = '/images/components/GPU-NVIDIA-RTX4060TI-8GB.png' WHERE name = 'NVIDIA GeForce RTX 4060 Ti 8GB';
UPDATE Product SET image_url = '/images/components/GPU-MSI-RTX4060TI-GAMING-X.png' WHERE name = 'MSI GeForce RTX 4060 Ti Gaming X';
UPDATE Product SET image_url = '/images/components/GPU-NVIDIA-RTX4060.png' WHERE name = 'NVIDIA GeForce RTX 4060';
UPDATE Product SET image_url = '/images/components/GPU-ASUS-DUAL-RTX4060.png' WHERE name = 'ASUS Dual RTX 4060';

-- AMD GPUs
UPDATE Product SET image_url = '/images/components/GPU-AMD-RX7900XTX.png' WHERE name = 'AMD Radeon RX 7900 XTX';
UPDATE Product SET image_url = '/images/components/GPU-SAPPHIRE-NITRO-RX7900XTX.png' WHERE name = 'Sapphire Nitro+ RX 7900 XTX';
UPDATE Product SET image_url = '/images/components/GPU-AMD-RX7900XT.png' WHERE name = 'AMD Radeon RX 7900 XT';
UPDATE Product SET image_url = '/images/components/GPU-POWERCOLOR-RED-DEVIL-RX7900XT.png' WHERE name = 'PowerColor Red Devil RX 7900 XT';
UPDATE Product SET image_url = '/images/components/GPU-AMD-RX7800XT.png' WHERE name = 'AMD Radeon RX 7800 XT';
UPDATE Product SET image_url = '/images/components/GPU-SAPPHIRE-PULSE-RX7800XT.png' WHERE name = 'Sapphire Pulse RX 7800 XT';
UPDATE Product SET image_url = '/images/components/GPU-AMD-RX7700XT.png' WHERE name = 'AMD Radeon RX 7700 XT';
UPDATE Product SET image_url = '/images/components/GPU-XFX-SWFT319-RX7700XT.png' WHERE name = 'XFX Speedster SWFT 319 RX 7700 XT';
UPDATE Product SET image_url = '/images/components/GPU-AMD-RX7600.png' WHERE name = 'AMD Radeon RX 7600';
UPDATE Product SET image_url = '/images/components/GPU-SAPPHIRE-PULSE-RX7600.png' WHERE name = 'Sapphire Pulse RX 7600';

-- =====================
-- CPU Images (25 total)
-- =====================

-- Intel 14th Gen
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I9-14900K.png' WHERE name = 'Intel Core i9-14900K';
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I9-14900KF.png' WHERE name = 'Intel Core i9-14900KF';
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I7-14700K.png' WHERE name = 'Intel Core i7-14700K';
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I7-14700KF.png' WHERE name = 'Intel Core i7-14700KF';
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I5-14600K.png' WHERE name = 'Intel Core i5-14600K';
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I5-14600KF.png' WHERE name = 'Intel Core i5-14600KF';
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I5-14400F.png' WHERE name = 'Intel Core i5-14400F';
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I3-14100F.png' WHERE name = 'Intel Core i3-14100F';

-- Intel 12th Gen
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I5-12400F.png' WHERE name = 'Intel Core i5-12400F';
UPDATE Product SET image_url = '/images/components/CPU-INTEL-I7-12700K.png' WHERE name = 'Intel Core i7-12700K';

-- AMD Ryzen 7000 Series
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN9-7950X.png' WHERE name = 'AMD Ryzen 9 7950X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN9-7950X3D.png' WHERE name = 'AMD Ryzen 9 7950X3D';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN9-7900X.png' WHERE name = 'AMD Ryzen 9 7900X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN7-7800X3D.png' WHERE name = 'AMD Ryzen 7 7800X3D';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN7-7700X.png' WHERE name = 'AMD Ryzen 7 7700X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN5-7600X.png' WHERE name = 'AMD Ryzen 5 7600X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN5-7600.png' WHERE name = 'AMD Ryzen 5 7600';

-- AMD Ryzen 5000 Series
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN9-5950X.png' WHERE name = 'AMD Ryzen 9 5950X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN9-5900X.png' WHERE name = 'AMD Ryzen 9 5900X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN7-5800X3D.png' WHERE name = 'AMD Ryzen 7 5800X3D';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN7-5800X.png' WHERE name = 'AMD Ryzen 7 5800X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN7-5700X.png' WHERE name = 'AMD Ryzen 7 5700X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN5-5600X.png' WHERE name = 'AMD Ryzen 5 5600X';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN5-5600.png' WHERE name = 'AMD Ryzen 5 5600';
UPDATE Product SET image_url = '/images/components/CPU-AMD-RYZEN5-5500.png' WHERE name = 'AMD Ryzen 5 5500';

-- =====================
-- Case Images (22 total)
-- =====================

-- ATX Cases
UPDATE Product SET image_url = '/images/components/CASE-LIANLI-O11-DYNAMIC-EVO.png' WHERE name = 'Lian Li O11 Dynamic EVO';
UPDATE Product SET image_url = '/images/components/CASE-LIANLI-O11-DYNAMIC.png' WHERE name = 'Lian Li O11 Dynamic';
UPDATE Product SET image_url = '/images/components/CASE-NZXT-H7-FLOW.png' WHERE name = 'NZXT H7 Flow';
UPDATE Product SET image_url = '/images/components/CASE-NZXT-H7.png' WHERE name = 'NZXT H7';
UPDATE Product SET image_url = '/images/components/CASE-CORSAIR-4000D-AIRFLOW.png' WHERE name = 'Corsair 4000D Airflow';
UPDATE Product SET image_url = '/images/components/CASE-CORSAIR-5000D-AIRFLOW.png' WHERE name = 'Corsair 5000D Airflow';
UPDATE Product SET image_url = '/images/components/CASE-FRACTAL-TORRENT.png' WHERE name = 'Fractal Design Torrent';
UPDATE Product SET image_url = '/images/components/CASE-FRACTAL-NORTH.png' WHERE name = 'Fractal Design North';
UPDATE Product SET image_url = '/images/components/CASE-PHANTEKS-G360A.png' WHERE name = 'Phanteks Eclipse G360A';
UPDATE Product SET image_url = '/images/components/CASE-BEQUIET-PUREBASE-500DX.png' WHERE name = 'be quiet! Pure Base 500DX';
UPDATE Product SET image_url = '/images/components/CASE-COOLERMASTER-TD500-MESH.png' WHERE name = 'Cooler Master MasterBox TD500 Mesh';
UPDATE Product SET image_url = '/images/components/CASE-HYTE-Y60.png' WHERE name = 'HYTE Y60';
UPDATE Product SET image_url = '/images/components/CASE-LIANLI-LANCOOL-II-MESH.png' WHERE name = 'Lian Li Lancool II Mesh';

-- Micro-ATX Cases
UPDATE Product SET image_url = '/images/components/CASE-NZXT-H5-FLOW.png' WHERE name = 'NZXT H5 Flow';
UPDATE Product SET image_url = '/images/components/CASE-CORSAIR-4000D-MATX.png' WHERE name = 'Corsair 4000D Airflow Micro-ATX';
UPDATE Product SET image_url = '/images/components/CASE-FRACTAL-MESHIFY-C-MINI.png' WHERE name = 'Fractal Design Meshify C Mini';
UPDATE Product SET image_url = '/images/components/CASE-COOLERMASTER-NR400.png' WHERE name = 'Cooler Master NR400';
UPDATE Product SET image_url = '/images/components/CASE-THERMALTAKE-S100.png' WHERE name = 'Thermaltake S100';
UPDATE Product SET image_url = '/images/components/CASE-DEEPCOOL-CC560.png' WHERE name = 'DeepCool CC560';

-- Mini-ITX Cases
UPDATE Product SET image_url = '/images/components/CASE-NZXT-H1-V2.png' WHERE name = 'NZXT H1 V2';
UPDATE Product SET image_url = '/images/components/CASE-LIANLI-A4-H2O.png' WHERE name = 'Lian Li A4-H2O';
UPDATE Product SET image_url = '/images/components/CASE-COOLERMASTER-NR200P.png' WHERE name = 'Cooler Master NR200P';
UPDATE Product SET image_url = '/images/components/CASE-SSUPD-MESHROOM-S.png' WHERE name = 'SSUPD Meshroom S';

-- ==============================
-- CPU Cooler Images (25 total)
-- ==============================

-- Air Coolers
UPDATE Product SET image_url = '/images/components/COOLER-NOCTUA-NHD15-CHROMAX.png' WHERE name = 'Noctua NH-D15 chromax.black';
UPDATE Product SET image_url = '/images/components/COOLER-NOCTUA-NHU12A.png' WHERE name = 'Noctua NH-U12A';
UPDATE Product SET image_url = '/images/components/COOLER-NOCTUA-NHU12S-REDUX.png' WHERE name = 'Noctua NH-U12S redux';
UPDATE Product SET image_url = '/images/components/COOLER-BEQUIET-DARKROCK-PRO4.png' WHERE name = 'be quiet! Dark Rock Pro 4';
UPDATE Product SET image_url = '/images/components/COOLER-BEQUIET-DARKROCK-4.png' WHERE name = 'be quiet! Dark Rock 4';
UPDATE Product SET image_url = '/images/components/COOLER-COOLERMASTER-HYPER212-BLACK.png' WHERE name = 'Cooler Master Hyper 212 Black Edition';
UPDATE Product SET image_url = '/images/components/COOLER-DEEPCOOL-AK620.png' WHERE name = 'DeepCool AK620';
UPDATE Product SET image_url = '/images/components/COOLER-DEEPCOOL-AK400.png' WHERE name = 'DeepCool AK400';
UPDATE Product SET image_url = '/images/components/COOLER-THERMALRIGHT-PA120SE.png' WHERE name = 'Thermalright Peerless Assassin 120 SE';
UPDATE Product SET image_url = '/images/components/COOLER-SCYTHE-FUMA2-REVB.png' WHERE name = 'Scythe Fuma 2 Rev.B';
UPDATE Product SET image_url = '/images/components/COOLER-NOCTUA-NHL9I-CHROMAX.png' WHERE name = 'Noctua NH-L9i-17xx chromax.black';
UPDATE Product SET image_url = '/images/components/COOLER-BEQUIET-PUREROCK2.png' WHERE name = 'be quiet! Pure Rock 2';

-- AIO Liquid Coolers
UPDATE Product SET image_url = '/images/components/COOLER-ARCTIC-LF2-240.png' WHERE name = 'ARCTIC Liquid Freezer II 240';
UPDATE Product SET image_url = '/images/components/COOLER-ARCTIC-LF2-360.png' WHERE name = 'ARCTIC Liquid Freezer II 360';
UPDATE Product SET image_url = '/images/components/COOLER-CORSAIR-H100I-RGB-ELITE.png' WHERE name = 'Corsair iCUE H100i RGB ELITE';
UPDATE Product SET image_url = '/images/components/COOLER-CORSAIR-H150I-CAPELLIX-XT.png' WHERE name = 'Corsair iCUE H150i ELITE CAPELLIX XT';
UPDATE Product SET image_url = '/images/components/COOLER-CORSAIR-H170I-CAPELLIX-XT.png' WHERE name = 'Corsair iCUE H170i ELITE CAPELLIX XT';
UPDATE Product SET image_url = '/images/components/COOLER-NZXT-KRAKEN-240.png' WHERE name = 'NZXT Kraken 240';
UPDATE Product SET image_url = '/images/components/COOLER-NZXT-KRAKEN-360.png' WHERE name = 'NZXT Kraken 360';
UPDATE Product SET image_url = '/images/components/COOLER-NZXT-KRAKEN-Z73.png' WHERE name = 'NZXT Kraken Z73';
UPDATE Product SET image_url = '/images/components/COOLER-LIANLI-GALAHAD2-TRINITY-240.png' WHERE name = 'Lian Li Galahad II Trinity 240';
UPDATE Product SET image_url = '/images/components/COOLER-ASUS-ROG-RYUJIN3-360.png' WHERE name = 'ASUS ROG Ryujin III 360';
UPDATE Product SET image_url = '/images/components/COOLER-EK-NUCLEUS-CR360.png' WHERE name = 'EK-Nucleus AIO CR360 Lux D-RGB';
UPDATE Product SET image_url = '/images/components/COOLER-COOLERMASTER-ML240L-V2.png' WHERE name = 'Cooler Master MasterLiquid ML240L V2 RGB';
UPDATE Product SET image_url = '/images/components/COOLER-DEEPCOOL-LS720.png' WHERE name = 'DeepCool LS720';

-- ==============================
-- Motherboard Images (20 total)
-- ==============================

-- Intel Z790
UPDATE Product SET image_url = '/images/components/MOBO-ASUS-ROG-MAXIMUS-Z790-HERO.png' WHERE name = 'ASUS ROG Maximus Z790 Hero';
UPDATE Product SET image_url = '/images/components/MOBO-ASUS-ROG-STRIX-Z790E.png' WHERE name = 'ASUS ROG Strix Z790-E Gaming';
UPDATE Product SET image_url = '/images/components/MOBO-MSI-MPG-Z790-EDGE-WIFI.png' WHERE name = 'MSI MPG Z790 Edge WiFi';
UPDATE Product SET image_url = '/images/components/MOBO-MSI-MAG-Z790-TOMAHAWK-WIFI.png' WHERE name = 'MSI MAG Z790 Tomahawk WiFi';
UPDATE Product SET image_url = '/images/components/MOBO-GIGABYTE-Z790-AORUS-ELITE.png' WHERE name = 'Gigabyte Z790 Aorus Elite AX';
UPDATE Product SET image_url = '/images/components/MOBO-ASROCK-Z790-PRO-RS.png' WHERE name = 'ASRock Z790 Pro RS';

-- Intel B760
UPDATE Product SET image_url = '/images/components/MOBO-ASUS-PRIME-B760-PLUS.png' WHERE name = 'ASUS Prime B760-Plus';
UPDATE Product SET image_url = '/images/components/MOBO-MSI-PRO-B760M-A-WIFI.png' WHERE name = 'MSI PRO B760M-A WiFi';
UPDATE Product SET image_url = '/images/components/MOBO-GIGABYTE-B760M-DS3H.png' WHERE name = 'Gigabyte B760M DS3H';

-- AMD X670E
UPDATE Product SET image_url = '/images/components/MOBO-ASUS-ROG-CROSSHAIR-X670E-HERO.png' WHERE name = 'ASUS ROG Crosshair X670E Hero';
UPDATE Product SET image_url = '/images/components/MOBO-ASUS-ROG-STRIX-X670E-E.png' WHERE name = 'ASUS ROG Strix X670E-E Gaming';
UPDATE Product SET image_url = '/images/components/MOBO-MSI-MPG-X670E-CARBON-WIFI.png' WHERE name = 'MSI MPG X670E Carbon WiFi';
UPDATE Product SET image_url = '/images/components/MOBO-GIGABYTE-X670E-AORUS-MASTER.png' WHERE name = 'Gigabyte X670E Aorus Master';
UPDATE Product SET image_url = '/images/components/MOBO-MSI-MAG-X670E-TOMAHAWK-WIFI.png' WHERE name = 'MSI MAG X670E Tomahawk WiFi';

-- AMD B650
UPDATE Product SET image_url = '/images/components/MOBO-ASUS-TUF-GAMING-B650-PLUS.png' WHERE name = 'ASUS TUF Gaming B650-Plus';
UPDATE Product SET image_url = '/images/components/MOBO-MSI-PRO-B650-P-WIFI.png' WHERE name = 'MSI PRO B650-P WiFi';
UPDATE Product SET image_url = '/images/components/MOBO-GIGABYTE-B650M-DS3H.png' WHERE name = 'Gigabyte B650M DS3H';
UPDATE Product SET image_url = '/images/components/MOBO-ASROCK-B650M-HDV.png' WHERE name = 'ASRock B650M-HDV/M.2';

-- AMD X570/B550/A520 (AM4)
UPDATE Product SET image_url = '/images/components/MOBO-ASUS-ROG-CROSSHAIR-VIII-HERO.png' WHERE name = 'ASUS ROG Crosshair VIII Hero';
UPDATE Product SET image_url = '/images/components/MOBO-MSI-MAG-X570S-TOMAHAWK-WIFI.png' WHERE name = 'MSI MAG X570S Tomahawk WiFi';
UPDATE Product SET image_url = '/images/components/MOBO-GIGABYTE-B550-AORUS-PRO.png' WHERE name = 'Gigabyte B550 Aorus Pro';
UPDATE Product SET image_url = '/images/components/MOBO-ASUS-TUF-GAMING-B550-PLUS.png' WHERE name = 'ASUS TUF Gaming B550-Plus';
UPDATE Product SET image_url = '/images/components/MOBO-MSI-B550-A-PRO.png' WHERE name = 'MSI B550-A PRO';
UPDATE Product SET image_url = '/images/components/MOBO-ASROCK-B550M-PRO4.png' WHERE name = 'ASRock B550M Pro4';
UPDATE Product SET image_url = '/images/components/MOBO-GIGABYTE-A520M-DS3H.png' WHERE name = 'Gigabyte A520M DS3H';

-- ==============================
-- RAM Images (22 total)
-- ==============================

-- DDR5
UPDATE Product SET image_url = '/images/components/RAM-GSKILL-TRIDENTZ5-RGB-DDR5-6400.png' WHERE name = 'G.Skill Trident Z5 RGB DDR5-6400 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-GSKILL-TRIDENTZ5-RGB-DDR5-6000.png' WHERE name = 'G.Skill Trident Z5 RGB DDR5-6000 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-DOMINATOR-PLATINUM-DDR5-6400.png' WHERE name = 'Corsair Dominator Platinum RGB DDR5-6400 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-DOMINATOR-PLATINUM-DDR5-6000.png' WHERE name = 'Corsair Dominator Platinum RGB DDR5-6000 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-VENGEANCE-DDR5-6000.png' WHERE name = 'Corsair Vengeance DDR5-6000 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-VENGEANCE-DDR5-5600.png' WHERE name = 'Corsair Vengeance DDR5-5600 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-KINGSTON-FURY-BEAST-DDR5-6000.png' WHERE name = 'Kingston Fury Beast DDR5-6000 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-KINGSTON-FURY-BEAST-DDR5-5600.png' WHERE name = 'Kingston Fury Beast DDR5-5600 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CRUCIAL-DDR5-4800.png' WHERE name = 'Crucial DDR5-4800 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-GSKILL-TRIDENTZ5-RGB-DDR5-6000-64GB.png' WHERE name = 'G.Skill Trident Z5 RGB DDR5-6000 64GB (2x32GB)';

-- DDR4
UPDATE Product SET image_url = '/images/components/RAM-GSKILL-TRIDENTZ-RGB-DDR4-3600.png' WHERE name = 'G.Skill Trident Z RGB DDR4-3600 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-GSKILL-TRIDENTZ-RGB-DDR4-3200.png' WHERE name = 'G.Skill Trident Z RGB DDR4-3200 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-VENGEANCE-RGB-PRO-DDR4-3600.png' WHERE name = 'Corsair Vengeance RGB Pro DDR4-3600 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-VENGEANCE-RGB-PRO-DDR4-3200.png' WHERE name = 'Corsair Vengeance RGB Pro DDR4-3200 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-VENGEANCE-LPX-DDR4-3600.png' WHERE name = 'Corsair Vengeance LPX DDR4-3600 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-VENGEANCE-LPX-DDR4-3200.png' WHERE name = 'Corsair Vengeance LPX DDR4-3200 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-KINGSTON-FURY-BEAST-DDR4-3600.png' WHERE name = 'Kingston Fury Beast DDR4-3600 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-KINGSTON-FURY-BEAST-DDR4-3200.png' WHERE name = 'Kingston Fury Beast DDR4-3200 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-CRUCIAL-BALLISTIX-DDR4-3200.png' WHERE name = 'Crucial Ballistix DDR4-3200 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-TEAMGROUP-TFORCE-DELTA-RGB-DDR4-3200.png' WHERE name = 'TeamGroup T-Force Delta RGB DDR4-3200 32GB (2x16GB)';
UPDATE Product SET image_url = '/images/components/RAM-GSKILL-RIPJAWS-V-DDR4-3600-16GB.png' WHERE name = 'G.Skill Ripjaws V DDR4-3600 16GB (2x8GB)';
UPDATE Product SET image_url = '/images/components/RAM-CORSAIR-VENGEANCE-LPX-DDR4-3200-16GB.png' WHERE name = 'Corsair Vengeance LPX DDR4-3200 16GB (2x8GB)';

-- ==============================
-- PSU Images (23 total)
-- ==============================

-- Premium PSUs
UPDATE Product SET image_url = '/images/components/PSU-CORSAIR-RM1000X.png' WHERE name = 'Corsair RM1000x';
UPDATE Product SET image_url = '/images/components/PSU-CORSAIR-RM850X.png' WHERE name = 'Corsair RM850x';
UPDATE Product SET image_url = '/images/components/PSU-CORSAIR-RM750X.png' WHERE name = 'Corsair RM750x';
UPDATE Product SET image_url = '/images/components/PSU-CORSAIR-RM650X.png' WHERE name = 'Corsair RM650x';
UPDATE Product SET image_url = '/images/components/PSU-SEASONIC-FOCUS-GX-1000.png' WHERE name = 'Seasonic Focus GX-1000';
UPDATE Product SET image_url = '/images/components/PSU-SEASONIC-FOCUS-GX-850.png' WHERE name = 'Seasonic Focus GX-850';
UPDATE Product SET image_url = '/images/components/PSU-SEASONIC-FOCUS-GX-750.png' WHERE name = 'Seasonic Focus GX-750';
UPDATE Product SET image_url = '/images/components/PSU-SEASONIC-FOCUS-GX-650.png' WHERE name = 'Seasonic Focus GX-650';
UPDATE Product SET image_url = '/images/components/PSU-EVGA-SUPERNOVA-1000-G6.png' WHERE name = 'EVGA SuperNOVA 1000 G6';
UPDATE Product SET image_url = '/images/components/PSU-EVGA-SUPERNOVA-850-G6.png' WHERE name = 'EVGA SuperNOVA 850 G6';
UPDATE Product SET image_url = '/images/components/PSU-EVGA-SUPERNOVA-750-G6.png' WHERE name = 'EVGA SuperNOVA 750 G6';
UPDATE Product SET image_url = '/images/components/PSU-BEQUIET-STRAIGHTPOWER12-1000W.png' WHERE name = 'be quiet! Straight Power 12 1000W';
UPDATE Product SET image_url = '/images/components/PSU-BEQUIET-STRAIGHTPOWER12-850W.png' WHERE name = 'be quiet! Straight Power 12 850W';
UPDATE Product SET image_url = '/images/components/PSU-BEQUIET-PUREPOWER12M-750W.png' WHERE name = 'be quiet! Pure Power 12 M 750W';
UPDATE Product SET image_url = '/images/components/PSU-CORSAIR-HX1500I.png' WHERE name = 'Corsair HX1500i';
UPDATE Product SET image_url = '/images/components/PSU-CORSAIR-HX1200.png' WHERE name = 'Corsair HX1200';
UPDATE Product SET image_url = '/images/components/PSU-MSI-MPG-A1000G.png' WHERE name = 'MSI MPG A1000G';
UPDATE Product SET image_url = '/images/components/PSU-MSI-MPG-A850GF.png' WHERE name = 'MSI MPG A850GF';
UPDATE Product SET image_url = '/images/components/PSU-MSI-MPG-A750GF.png' WHERE name = 'MSI MPG A750GF';
UPDATE Product SET image_url = '/images/components/PSU-THERMALTAKE-TOUGHPOWER-GF3-1000W.png' WHERE name = 'Thermaltake Toughpower GF3 1000W';
UPDATE Product SET image_url = '/images/components/PSU-THERMALTAKE-TOUGHPOWER-GF3-850W.png' WHERE name = 'Thermaltake Toughpower GF3 850W';
UPDATE Product SET image_url = '/images/components/PSU-ASUS-ROG-STRIX-1000W.png' WHERE name = 'ASUS ROG Strix 1000W';
UPDATE Product SET image_url = '/images/components/PSU-ASUS-ROG-STRIX-850W.png' WHERE name = 'ASUS ROG Strix 850W';

-- Budget PSUs
UPDATE Product SET image_url = '/images/components/PSU-CORSAIR-CV650.png' WHERE name = 'Corsair CV650';
UPDATE Product SET image_url = '/images/components/PSU-CORSAIR-CV550.png' WHERE name = 'Corsair CV550';
UPDATE Product SET image_url = '/images/components/PSU-EVGA-600BR.png' WHERE name = 'EVGA 600 BR';
UPDATE Product SET image_url = '/images/components/PSU-THERMALTAKE-SMART-600W.png' WHERE name = 'Thermaltake Smart 600W';
UPDATE Product SET image_url = '/images/components/PSU-COOLERMASTER-MWE-GOLD-650.png' WHERE name = 'Cooler Master MWE Gold 650';

-- ==============================
-- Storage Images (27 total)
-- ==============================

-- NVMe SSDs (Gen4/Gen5)
UPDATE Product SET image_url = '/images/components/STORAGE-SAMSUNG-990PRO-2TB.png' WHERE name = 'Samsung 990 Pro 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SAMSUNG-990PRO-1TB.png' WHERE name = 'Samsung 990 Pro 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SAMSUNG-980PRO-2TB.png' WHERE name = 'Samsung 980 Pro 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SAMSUNG-980PRO-1TB.png' WHERE name = 'Samsung 980 Pro 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-WD-BLACK-SN850X-2TB.png' WHERE name = 'WD Black SN850X 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-WD-BLACK-SN850X-1TB.png' WHERE name = 'WD Black SN850X 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SEAGATE-FIRECUDA530-2TB.png' WHERE name = 'Seagate FireCuda 530 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SEAGATE-FIRECUDA530-1TB.png' WHERE name = 'Seagate FireCuda 530 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-CRUCIAL-T700-2TB.png' WHERE name = 'Crucial T700 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-CRUCIAL-T700-1TB.png' WHERE name = 'Crucial T700 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SKHYNIX-P41-2TB.png' WHERE name = 'SK Hynix Platinum P41 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SKHYNIX-P41-1TB.png' WHERE name = 'SK Hynix Platinum P41 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-CRUCIAL-P5PLUS-2TB.png' WHERE name = 'Crucial P5 Plus 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-CRUCIAL-P5PLUS-1TB.png' WHERE name = 'Crucial P5 Plus 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-WD-BLUE-SN580-2TB.png' WHERE name = 'WD Blue SN580 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-WD-BLUE-SN580-1TB.png' WHERE name = 'WD Blue SN580 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-KINGSTON-NV2-2TB.png' WHERE name = 'Kingston NV2 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-KINGSTON-NV2-1TB.png' WHERE name = 'Kingston NV2 1TB';

-- SATA SSDs
UPDATE Product SET image_url = '/images/components/STORAGE-SAMSUNG-870EVO-2TB.png' WHERE name = 'Samsung 870 EVO 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SAMSUNG-870EVO-1TB.png' WHERE name = 'Samsung 870 EVO 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SAMSUNG-870EVO-500GB.png' WHERE name = 'Samsung 870 EVO 500GB';
UPDATE Product SET image_url = '/images/components/STORAGE-CRUCIAL-MX500-2TB.png' WHERE name = 'Crucial MX500 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-CRUCIAL-MX500-1TB.png' WHERE name = 'Crucial MX500 1TB';
UPDATE Product SET image_url = '/images/components/STORAGE-WD-BLUE-3D-2TB.png' WHERE name = 'WD Blue 3D NAND 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-WD-BLUE-3D-1TB.png' WHERE name = 'WD Blue 3D NAND 1TB';

-- HDDs
UPDATE Product SET image_url = '/images/components/STORAGE-SEAGATE-BARRACUDA-8TB.png' WHERE name = 'Seagate Barracuda 8TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SEAGATE-BARRACUDA-4TB.png' WHERE name = 'Seagate Barracuda 4TB';
UPDATE Product SET image_url = '/images/components/STORAGE-SEAGATE-BARRACUDA-2TB.png' WHERE name = 'Seagate Barracuda 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-WD-BLUE-HDD-4TB.png' WHERE name = 'WD Blue 4TB';
UPDATE Product SET image_url = '/images/components/STORAGE-WD-BLUE-HDD-2TB.png' WHERE name = 'WD Blue 2TB';
UPDATE Product SET image_url = '/images/components/STORAGE-TOSHIBA-X300-8TB.png' WHERE name = 'Toshiba X300 8TB';
UPDATE Product SET image_url = '/images/components/STORAGE-TOSHIBA-P300-4TB.png' WHERE name = 'Toshiba P300 4TB';

-- ==============================
-- Monitor Images (21 total)
-- ==============================

UPDATE Product SET image_url = '/images/components/MONITOR-DELL-U2723QE.png' WHERE name = 'Dell UltraSharp U2723QE';
UPDATE Product SET image_url = '/images/components/MONITOR-DELL-S2721DGF.png' WHERE name = 'Dell S2721DGF';
UPDATE Product SET image_url = '/images/components/MONITOR-LG-27GP850B.png' WHERE name = 'LG 27GP850-B';
UPDATE Product SET image_url = '/images/components/MONITOR-LG-27GL850B.png' WHERE name = 'LG 27GL850-B';
UPDATE Product SET image_url = '/images/components/MONITOR-LG-32GQ950B.png' WHERE name = 'LG 32GQ950-B';
UPDATE Product SET image_url = '/images/components/MONITOR-SAMSUNG-ODYSSEY-G7-32.png' WHERE name = 'Samsung Odyssey G7 32-inch';
UPDATE Product SET image_url = '/images/components/MONITOR-SAMSUNG-ODYSSEY-G9.png' WHERE name = 'Samsung Odyssey G9';
UPDATE Product SET image_url = '/images/components/MONITOR-ASUS-TUF-VG27AQ.png' WHERE name = 'ASUS TUF Gaming VG27AQ';
UPDATE Product SET image_url = '/images/components/MONITOR-ASUS-ROG-PG279QM.png' WHERE name = 'ASUS ROG Swift PG279QM';
UPDATE Product SET image_url = '/images/components/MONITOR-ASUS-ROG-PG27AQDM.png' WHERE name = 'ASUS ROG Swift OLED PG27AQDM';
UPDATE Product SET image_url = '/images/components/MONITOR-GIGABYTE-M27Q.png' WHERE name = 'Gigabyte M27Q';
UPDATE Product SET image_url = '/images/components/MONITOR-GIGABYTE-M32U.png' WHERE name = 'Gigabyte M32U';
UPDATE Product SET image_url = '/images/components/MONITOR-ACER-NITRO-XV272U.png' WHERE name = 'Acer Nitro XV272U';
UPDATE Product SET image_url = '/images/components/MONITOR-ACER-PREDATOR-XB273U.png' WHERE name = 'Acer Predator XB273U GX';
UPDATE Product SET image_url = '/images/components/MONITOR-BENQ-MOBIUZ-EX2710Q.png' WHERE name = 'BenQ MOBIUZ EX2710Q';
UPDATE Product SET image_url = '/images/components/MONITOR-BENQ-PD2705U.png' WHERE name = 'BenQ PD2705U';
UPDATE Product SET image_url = '/images/components/MONITOR-MSI-MAG274QRF-QD.png' WHERE name = 'MSI Optix MAG274QRF-QD';
UPDATE Product SET image_url = '/images/components/MONITOR-VIEWSONIC-XG270QG.png' WHERE name = 'ViewSonic Elite XG270QG';
UPDATE Product SET image_url = '/images/components/MONITOR-HP-OMEN-27QS.png' WHERE name = 'HP OMEN 27qs';
UPDATE Product SET image_url = '/images/components/MONITOR-AOC-CQ27G2.png' WHERE name = 'AOC CQ27G2';
UPDATE Product SET image_url = '/images/components/MONITOR-ALIENWARE-AW3423DWF.png' WHERE name = 'Alienware AW3423DWF';
UPDATE Product SET image_url = '/images/components/MONITOR-BENQ-ZOWIE-XL2546K.png' WHERE name = 'BenQ ZOWIE XL2546K';
UPDATE Product SET image_url = '/images/components/MONITOR-ASUS-PROART-PA278CV.png' WHERE name = 'ASUS ProArt PA278CV';
UPDATE Product SET image_url = '/images/components/MONITOR-SAMSUNG-SMART-M8.png' WHERE name = 'Samsung Smart Monitor M8';
UPDATE Product SET image_url = '/images/components/MONITOR-LG-OLED-C2-42.png' WHERE name = 'LG OLED evo C2 42-inch';

-- ==============================
-- Keyboard Images (25 total)
-- ==============================

UPDATE Product SET image_url = '/images/components/KEYBOARD-KEYCHRON-Q1.png' WHERE name = 'Keychron Q1';
UPDATE Product SET image_url = '/images/components/KEYBOARD-KEYCHRON-K2.png' WHERE name = 'Keychron K2';
UPDATE Product SET image_url = '/images/components/KEYBOARD-KEYCHRON-K8PRO.png' WHERE name = 'Keychron K8 Pro';
UPDATE Product SET image_url = '/images/components/KEYBOARD-LOGITECH-PROX-TKL.png' WHERE name = 'Logitech G PRO X TKL';
UPDATE Product SET image_url = '/images/components/KEYBOARD-LOGITECH-G915-TKL.png' WHERE name = 'Logitech G915 TKL';
UPDATE Product SET image_url = '/images/components/KEYBOARD-CORSAIR-K70-RGB-PRO.png' WHERE name = 'Corsair K70 RGB PRO';
UPDATE Product SET image_url = '/images/components/KEYBOARD-CORSAIR-K65-RGB-MINI.png' WHERE name = 'Corsair K65 RGB MINI';
UPDATE Product SET image_url = '/images/components/KEYBOARD-RAZER-HUNTSMAN-V2.png' WHERE name = 'Razer Huntsman V2';
UPDATE Product SET image_url = '/images/components/KEYBOARD-RAZER-BLACKWIDOW-V4.png' WHERE name = 'Razer BlackWidow V4';
UPDATE Product SET image_url = '/images/components/KEYBOARD-STEELSERIES-APEX-PRO-TKL.png' WHERE name = 'SteelSeries Apex Pro TKL';
UPDATE Product SET image_url = '/images/components/KEYBOARD-STEELSERIES-APEX3.png' WHERE name = 'SteelSeries Apex 3';
UPDATE Product SET image_url = '/images/components/KEYBOARD-DUCKY-ONE3-MINI.png' WHERE name = 'Ducky One 3 Mini';
UPDATE Product SET image_url = '/images/components/KEYBOARD-DUCKY-ONE3-TKL.png' WHERE name = 'Ducky One 3 TKL';
UPDATE Product SET image_url = '/images/components/KEYBOARD-GLORIOUS-GMMK-PRO.png' WHERE name = 'Glorious GMMK Pro';
UPDATE Product SET image_url = '/images/components/KEYBOARD-GLORIOUS-GMMK2.png' WHERE name = 'Glorious GMMK 2';
UPDATE Product SET image_url = '/images/components/KEYBOARD-ASUS-ROG-STRIX-SCOPE2-96.png' WHERE name = 'ASUS ROG Strix Scope II 96';
UPDATE Product SET image_url = '/images/components/KEYBOARD-ASUS-ROG-CLAYMORE2.png' WHERE name = 'ASUS ROG Claymore II';
UPDATE Product SET image_url = '/images/components/KEYBOARD-HYPERX-ALLOY-ORIGINS.png' WHERE name = 'HyperX Alloy Origins';
UPDATE Product SET image_url = '/images/components/KEYBOARD-HYPERX-ALLOY-FPS-PRO.png' WHERE name = 'HyperX Alloy FPS Pro';
UPDATE Product SET image_url = '/images/components/KEYBOARD-WOOTING-60HE.png' WHERE name = 'Wooting 60HE';
UPDATE Product SET image_url = '/images/components/KEYBOARD-CORSAIR-K100-RGB.png' WHERE name = 'Corsair K100 RGB';
UPDATE Product SET image_url = '/images/components/KEYBOARD-RAZER-HUNTSMAN-MINI.png' WHERE name = 'Razer Huntsman Mini';
UPDATE Product SET image_url = '/images/components/KEYBOARD-STEELSERIES-APEX7.png' WHERE name = 'SteelSeries Apex 7';
UPDATE Product SET image_url = '/images/components/KEYBOARD-LOGITECH-MX-KEYS.png' WHERE name = 'Logitech MX Keys';
UPDATE Product SET image_url = '/images/components/KEYBOARD-LOGITECH-G413-SE.png' WHERE name = 'Logitech G413 SE';

-- ==============================
-- Mouse Images (25 total)
-- ==============================

UPDATE Product SET image_url = '/images/components/MOUSE-LOGITECH-PROX-SUPERLIGHT2.png' WHERE name = 'Logitech G PRO X SUPERLIGHT 2';
UPDATE Product SET image_url = '/images/components/MOUSE-LOGITECH-G502X.png' WHERE name = 'Logitech G502 X';
UPDATE Product SET image_url = '/images/components/MOUSE-LOGITECH-G305.png' WHERE name = 'Logitech G305 LIGHTSPEED';
UPDATE Product SET image_url = '/images/components/MOUSE-LOGITECH-G703.png' WHERE name = 'Logitech G703 LIGHTSPEED';
UPDATE Product SET image_url = '/images/components/MOUSE-LOGITECH-G903.png' WHERE name = 'Logitech G903 LIGHTSPEED';
UPDATE Product SET image_url = '/images/components/MOUSE-RAZER-DEATHADDER-V3-PRO.png' WHERE name = 'Razer DeathAdder V3 Pro';
UPDATE Product SET image_url = '/images/components/MOUSE-RAZER-VIPER-V2-PRO.png' WHERE name = 'Razer Viper V2 Pro';
UPDATE Product SET image_url = '/images/components/MOUSE-RAZER-BASILISK-V3.png' WHERE name = 'Razer Basilisk V3';
UPDATE Product SET image_url = '/images/components/MOUSE-RAZER-NAGA-V2-PRO.png' WHERE name = 'Razer Naga V2 Pro';
UPDATE Product SET image_url = '/images/components/MOUSE-STEELSERIES-RIVAL600.png' WHERE name = 'SteelSeries Rival 600';
UPDATE Product SET image_url = '/images/components/MOUSE-STEELSERIES-AEROX3-WIRELESS.png' WHERE name = 'SteelSeries Aerox 3 Wireless';
UPDATE Product SET image_url = '/images/components/MOUSE-STEELSERIES-PRIME-WIRELESS.png' WHERE name = 'SteelSeries Prime Wireless';
UPDATE Product SET image_url = '/images/components/MOUSE-CORSAIR-M65-RGB-ULTRA.png' WHERE name = 'Corsair M65 RGB ULTRA';
UPDATE Product SET image_url = '/images/components/MOUSE-CORSAIR-HARPOON-RGB-WIRELESS.png' WHERE name = 'Corsair HARPOON RGB WIRELESS';
UPDATE Product SET image_url = '/images/components/MOUSE-CORSAIR-DARKCORE-RGB-PRO-SE.png' WHERE name = 'Corsair DARK CORE RGB PRO SE';
UPDATE Product SET image_url = '/images/components/MOUSE-GLORIOUS-MODEL-O-WIRELESS.png' WHERE name = 'Glorious Model O Wireless';
UPDATE Product SET image_url = '/images/components/MOUSE-GLORIOUS-MODEL-D.png' WHERE name = 'Glorious Model D';
UPDATE Product SET image_url = '/images/components/MOUSE-ZOWIE-EC2C.png' WHERE name = 'Zowie EC2-C';
UPDATE Product SET image_url = '/images/components/MOUSE-ZOWIE-FK2C.png' WHERE name = 'Zowie FK2-C';
UPDATE Product SET image_url = '/images/components/MOUSE-HYPERX-PULSEFIRE-HASTE2-WIRELESS.png' WHERE name = 'HyperX Pulsefire Haste 2 Wireless';
UPDATE Product SET image_url = '/images/components/MOUSE-LOGITECH-MX-MASTER-3S.png' WHERE name = 'Logitech MX Master 3S';
UPDATE Product SET image_url = '/images/components/MOUSE-LOGITECH-MX-ANYWHERE3.png' WHERE name = 'Logitech MX Anywhere 3';
UPDATE Product SET image_url = '/images/components/MOUSE-RAZER-OROCHI-V2.png' WHERE name = 'Razer Orochi V2';
UPDATE Product SET image_url = '/images/components/MOUSE-RAZER-VIPER-MINI.png' WHERE name = 'Razer Viper Mini';
UPDATE Product SET image_url = '/images/components/MOUSE-STEELSERIES-RIVAL3.png' WHERE name = 'SteelSeries Rival 3';

-- ==============================
-- Headset Images (25 total)
-- ==============================

UPDATE Product SET image_url = '/images/components/HEADSET-STEELSERIES-ARCTIS-NOVA-PRO-WIRELESS.png' WHERE name = 'SteelSeries Arctis Nova Pro Wireless';
UPDATE Product SET image_url = '/images/components/HEADSET-STEELSERIES-ARCTIS-NOVA7.png' WHERE name = 'SteelSeries Arctis Nova 7';
UPDATE Product SET image_url = '/images/components/HEADSET-STEELSERIES-ARCTIS-NOVA1.png' WHERE name = 'SteelSeries Arctis Nova 1';
UPDATE Product SET image_url = '/images/components/HEADSET-HYPERX-CLOUD2.png' WHERE name = 'HyperX Cloud II';
UPDATE Product SET image_url = '/images/components/HEADSET-HYPERX-CLOUD-ALPHA-WIRELESS.png' WHERE name = 'HyperX Cloud Alpha Wireless';
UPDATE Product SET image_url = '/images/components/HEADSET-LOGITECH-PROX2-LIGHTSPEED.png' WHERE name = 'Logitech G PRO X 2 LIGHTSPEED';
UPDATE Product SET image_url = '/images/components/HEADSET-LOGITECH-G733.png' WHERE name = 'Logitech G733 LIGHTSPEED';
UPDATE Product SET image_url = '/images/components/HEADSET-RAZER-BLACKSHARK-V2-PRO.png' WHERE name = 'Razer BlackShark V2 Pro';
UPDATE Product SET image_url = '/images/components/HEADSET-RAZER-KRAKEN-V3-HYPERSENSE.png' WHERE name = 'Razer Kraken V3 HyperSense';
UPDATE Product SET image_url = '/images/components/HEADSET-RAZER-BARRACUDA-X.png' WHERE name = 'Razer Barracuda X';
UPDATE Product SET image_url = '/images/components/HEADSET-CORSAIR-HS80-RGB-WIRELESS.png' WHERE name = 'Corsair HS80 RGB Wireless';
UPDATE Product SET image_url = '/images/components/HEADSET-CORSAIR-VIRTUOSO-RGB-WIRELESS-XT.png' WHERE name = 'Corsair Virtuoso RGB Wireless XT';
UPDATE Product SET image_url = '/images/components/HEADSET-SONY-INZONE-H9.png' WHERE name = 'Sony INZONE H9';
UPDATE Product SET image_url = '/images/components/HEADSET-SONY-INZONE-H7.png' WHERE name = 'Sony INZONE H7';
UPDATE Product SET image_url = '/images/components/HEADSET-EPOS-H6PRO-CLOSED.png' WHERE name = 'EPOS H6PRO Closed';
UPDATE Product SET image_url = '/images/components/HEADSET-SENNHEISER-PC38X.png' WHERE name = 'Sennheiser PC38X';
UPDATE Product SET image_url = '/images/components/HEADSET-ASTRO-A50-WIRELESS.png' WHERE name = 'Astro A50 Wireless + Base Station';
UPDATE Product SET image_url = '/images/components/HEADSET-TURTLEBEACH-STEALTH700-GEN2-MAX.png' WHERE name = 'Turtle Beach Stealth 700 Gen 2 MAX';
UPDATE Product SET image_url = '/images/components/HEADSET-BEYERDYNAMIC-MMX300-GEN2.png' WHERE name = 'Beyerdynamic MMX 300 (2nd Generation)';
UPDATE Product SET image_url = '/images/components/HEADSET-JBL-QUANTUM910-WIRELESS.png' WHERE name = 'JBL Quantum 910 Wireless';
UPDATE Product SET image_url = '/images/components/HEADSET-LOGITECH-A40TR-MIXAMP.png' WHERE name = 'Logitech G Astro A40 TR + MixAmp Pro TR';
UPDATE Product SET image_url = '/images/components/HEADSET-SENNHEISER-GAME-ONE.png' WHERE name = 'Sennheiser GAME ONE';
UPDATE Product SET image_url = '/images/components/HEADSET-BOSE-QC35II-GAMING.png' WHERE name = 'Bose QuietComfort 35 II Gaming Headset';
UPDATE Product SET image_url = '/images/components/HEADSET-RAZER-KRAKEN-KITTY-V2.png' WHERE name = 'Razer Kraken Kitty V2';
UPDATE Product SET image_url = '/images/components/HEADSET-AUDIOTECHNICA-ATH-M50XSTS.png' WHERE name = 'Audio-Technica ATH-M50xSTS';
