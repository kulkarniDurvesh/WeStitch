-- =============================
-- Admin & User Management Tables (PostgreSQL)
-- =============================

-- Admins
CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    is_superadmin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Admin Roles
CREATE TABLE admin_roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- Admin Activity Logs
CREATE TABLE admin_activity_logs (
    id SERIAL PRIMARY KEY,
    admin_id INT REFERENCES admins(id) ON DELETE CASCADE,
    action TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Logs
CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY,
    actor_type VARCHAR(50),
    actor_id INT,
    action TEXT,
    target_table VARCHAR(100),
    target_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seller Profiles
CREATE TABLE seller_profiles (
    id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    shop_name VARCHAR(150),
    description TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Seller Documents
CREATE TABLE seller_documents (
    id SERIAL PRIMARY KEY,
    seller_id INT REFERENCES seller_profiles(id) ON DELETE CASCADE,
    doc_type VARCHAR(100),
    doc_url TEXT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Reports
CREATE TABLE user_reports (
    id SERIAL PRIMARY KEY,
    reporter_id INT,
    reported_user_id INT,
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'reviewed', 'dismissed') DEFAULT 'pending'
);

-- Dashboard Widgets (optional customization)
CREATE TABLE dashboard_widgets (
    id SERIAL PRIMARY KEY,
    admin_id INT,
    widget_name VARCHAR(100),
    is_enabled BOOLEAN DEFAULT TRUE,
    display_order INT,
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE
);
