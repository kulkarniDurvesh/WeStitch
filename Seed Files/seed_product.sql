-- =============================
-- Product Service Tables (MySQL)
-- =============================

-- Categories
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent_id INT DEFAULT NULL,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Brands
CREATE TABLE brands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Products
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    brand_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id)
);

-- Product Images
CREATE TABLE product_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url TEXT NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Product Variants (e.g., size/color)
CREATE TABLE product_variants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    variant_name VARCHAR(100),
    variant_value VARCHAR(100),
    price_modifier DECIMAL(10,2) DEFAULT 0.00,
    stock INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Product Tags
CREATE TABLE product_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Product Tag Map (Many-to-Many)
CREATE TABLE product_tag_map (
    product_id INT,
    tag_id INT,
    PRIMARY KEY (product_id, tag_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES product_tags(id) ON DELETE CASCADE
);

-- Inventory Table
CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    total_stock INT DEFAULT 0,
    reserved_stock INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Inventory Reservations (Temporary holds during checkout)
CREATE TABLE inventory_reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    reserved_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    expires_at DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Inventory Adjustments (Audit trail)
CREATE TABLE inventory_adjustments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity_change INT,
    reason VARCHAR(255),
    adjusted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Product Audit Logs
CREATE TABLE product_audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    action VARCHAR(50),
    changed_by INT,
    change_summary TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Bundle Products (product bundles)
CREATE TABLE bundle_products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bundle_name VARCHAR(150),
    description TEXT,
    price DECIMAL(10,2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Mapping table for bundle items
CREATE TABLE bundle_items (
    bundle_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    PRIMARY KEY (bundle_id, product_id),
    FOREIGN KEY (bundle_id) REFERENCES bundle_products(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Product Availability (for multi-location, future use)
CREATE TABLE product_availability (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    location VARCHAR(100),
    stock INT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);


