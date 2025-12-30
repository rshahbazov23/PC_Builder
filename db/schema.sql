DROP DATABASE IF EXISTS pc_builder;
CREATE DATABASE pc_builder;
\c pc_builder;

DROP TABLE IF EXISTS BuildItem CASCADE;
DROP TABLE IF EXISTS OrderItem CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Build CASCADE;
DROP TABLE IF EXISTS RAM_Spec CASCADE;
DROP TABLE IF EXISTS PSU_Spec CASCADE;
DROP TABLE IF EXISTS CASE_Spec CASCADE;
DROP TABLE IF EXISTS GPU_Spec CASCADE;
DROP TABLE IF EXISTS MOBO_Spec CASCADE;
DROP TABLE IF EXISTS CPU_Spec CASCADE;
DROP TABLE IF EXISTS Storage_Spec CASCADE;
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Category CASCADE;
DROP TABLE IF EXISTS "User" CASCADE;

DROP TYPE IF EXISTS slot_type_enum CASCADE;
DROP TYPE IF EXISTS order_status_enum CASCADE;

CREATE TYPE slot_type_enum AS ENUM ('CPU', 'GPU', 'RAM', 'MOBO', 'PSU', 'CASE', 'STORAGE');
CREATE TYPE order_status_enum AS ENUM ('pending', 'processing', 'shipped', 'delivered', 'cancelled');

CREATE TABLE Category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    slug VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    icon VARCHAR(50) DEFAULT 'cpu'
);

CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_qty INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    power_watts INT DEFAULT 0 CHECK (power_watts >= 0),
    rating DECIMAL(2, 1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    image_url VARCHAR(500),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE
);

CREATE INDEX idx_product_category ON Product(category_id);
CREATE INDEX idx_product_brand ON Product(brand);
CREATE INDEX idx_product_price ON Product(price);

CREATE TABLE CPU_Spec (
    product_id INT PRIMARY KEY,
    socket VARCHAR(20) NOT NULL,
    core_count INT NOT NULL CHECK (core_count > 0),
    thread_count INT NOT NULL CHECK (thread_count > 0),
    base_clock_ghz DECIMAL(3, 2),
    boost_clock_ghz DECIMAL(3, 2),
    tdp_watts INT CHECK (tdp_watts > 0),
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE MOBO_Spec (
    product_id INT PRIMARY KEY,
    socket VARCHAR(20) NOT NULL,
    form_factor VARCHAR(10) NOT NULL,
    ram_type VARCHAR(10) NOT NULL,
    ram_slots INT NOT NULL DEFAULT 4,
    max_ram_gb INT NOT NULL,
    pcie_version VARCHAR(10),
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE GPU_Spec (
    product_id INT PRIMARY KEY,
    length_mm INT NOT NULL CHECK (length_mm > 0),
    vram_gb INT NOT NULL,
    min_psu_watts INT,
    pcie_version VARCHAR(10),
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE CASE_Spec (
    product_id INT PRIMARY KEY,
    max_gpu_length_mm INT NOT NULL CHECK (max_gpu_length_mm > 0),
    supported_form_factor VARCHAR(10) NOT NULL,
    max_psu_length_mm INT,
    drive_bays_25 INT DEFAULT 0,
    drive_bays_35 INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE PSU_Spec (
    product_id INT PRIMARY KEY,
    wattage INT NOT NULL CHECK (wattage > 0),
    efficiency_rating VARCHAR(20) NOT NULL,
    modular VARCHAR(15) NOT NULL,
    psu_length_mm INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE RAM_Spec (
    product_id INT PRIMARY KEY,
    ram_type VARCHAR(10) NOT NULL,
    speed_mhz INT NOT NULL CHECK (speed_mhz > 0),
    size_gb INT NOT NULL CHECK (size_gb > 0),
    modules INT NOT NULL DEFAULT 1,
    latency VARCHAR(20),
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE Storage_Spec (
    product_id INT PRIMARY KEY,
    storage_type VARCHAR(10) NOT NULL,
    capacity_gb INT NOT NULL CHECK (capacity_gb > 0),
    form_factor VARCHAR(20) NOT NULL,
    read_speed_mbps INT,
    write_speed_mbps INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE Build (
    build_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION update_build_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER build_updated_at_trigger
    BEFORE UPDATE ON Build
    FOR EACH ROW
    EXECUTE FUNCTION update_build_timestamp();

CREATE TABLE BuildItem (
    build_item_id SERIAL PRIMARY KEY,
    build_id INT NOT NULL,
    product_id INT NOT NULL,
    slot_type slot_type_enum NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (build_id) REFERENCES Build(build_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE,
    UNIQUE (build_id, slot_type)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(12, 2) NOT NULL,
    status order_status_enum DEFAULT 'pending',
    shipping_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE
);

CREATE TABLE OrderItem (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE OR REPLACE VIEW ProductView AS
SELECT 
    p.*,
    c.name AS category_name,
    c.slug AS category_slug
FROM Product p
JOIN Category c ON p.category_id = c.category_id;

CREATE OR REPLACE VIEW BuildSummary AS
SELECT 
    b.build_id,
    b.name AS build_name,
    b.user_id,
    COUNT(bi.product_id) AS part_count,
    COALESCE(SUM(p.price), 0) AS total_price,
    COALESCE(SUM(p.power_watts), 0) AS total_watts
FROM Build b
LEFT JOIN BuildItem bi ON b.build_id = bi.build_id
LEFT JOIN Product p ON bi.product_id = p.product_id
GROUP BY b.build_id, b.name, b.user_id;
