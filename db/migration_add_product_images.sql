-- Migration: Add product images for all GPUs
-- This updates the image_url for products that have generated images

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
