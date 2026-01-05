-- Paste this into the Neon SQL Editor for your `neondb` database:
-- https://console.neon.tech/app/projects/spring-king-03823268/branches/br-proud-leaf-ah9or1ks/sql-editor?database=neondb
--
-- Safe to run multiple times: uses UPSERT on `Category.slug`.

INSERT INTO Category (name, slug, description, icon)
VALUES
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
  ('Headset', 'headset', 'Audio headsets for gaming and calls', 'headset')
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  icon = EXCLUDED.icon;

-- Verification (you should see the new rows here immediately)
SELECT current_database() AS db, COUNT(*)::int AS category_count FROM Category;
SELECT category_id, slug, name FROM Category ORDER BY category_id;


