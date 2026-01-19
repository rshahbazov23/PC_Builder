-- Migration: Add product images for GPUs, CPUs, Cases, and CPU Coolers
-- This updates the image_url for products that have generated images

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
