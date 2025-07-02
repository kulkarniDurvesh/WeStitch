-- =============================
-- Payment Service Tables (PostgreSQL)
-- =============================

-- Payments
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    user_id INT,
    amount DECIMAL(10,2),
    status ENUM('pending', 'successful', 'failed') DEFAULT 'pending',
    payment_method_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payment Methods
CREATE TABLE payment_methods (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE
);

-- Payment Attempts
CREATE TABLE payment_attempts (
    id SERIAL PRIMARY KEY,
    payment_id INT REFERENCES payments(id) ON DELETE CASCADE,
    attempt_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    response_code VARCHAR(100),
    response_message TEXT,
    success BOOLEAN
);

-- Payment Logs
CREATE TABLE payment_logs (
    id SERIAL PRIMARY KEY,
    payment_id INT REFERENCES payments(id) ON DELETE CASCADE,
    log TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Refunds
CREATE TABLE refunds (
    id SERIAL PRIMARY KEY,
    payment_id INT REFERENCES payments(id) ON DELETE CASCADE,
    refund_amount DECIMAL(10,2),
    reason TEXT,
    refund_status ENUM('initiated', 'processed', 'failed') DEFAULT 'initiated',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tax Details
CREATE TABLE tax_details (
    id SERIAL PRIMARY KEY,
    payment_id INT REFERENCES payments(id) ON DELETE CASCADE,
    tax_percentage DECIMAL(5,2),
    tax_amount DECIMAL(10,2),
    jurisdiction VARCHAR(100)
);

-- Bank Accounts (for payouts)
CREATE TABLE bank_accounts (
    id SERIAL PRIMARY KEY,
    user_id INT,
    account_holder_name VARCHAR(100),
    bank_name VARCHAR(100),
    account_number VARCHAR(50),
    ifsc_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payouts
CREATE TABLE payouts (
    id SERIAL PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    payout_status ENUM('scheduled', 'processing', 'completed', 'failed') DEFAULT 'scheduled',
    scheduled_at TIMESTAMP,
    processed_at TIMESTAMP
);
