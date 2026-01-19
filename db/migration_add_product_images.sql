-- Migration: Add product images
-- This updates the image_url for products that have generated images

-- Update RTX 4090 Founders Edition image
UPDATE Product 
SET image_url = '/images/components/GPU-NVIDIA-RTX4090-FE.png'
WHERE name = 'NVIDIA GeForce RTX 4090 Founders Edition';
