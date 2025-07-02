-- =============================
-- Shared/Event Tables (cross-service)
-- =============================

-- Event Logs
CREATE TABLE event_logs (
    id SERIAL PRIMARY KEY,
    service_name VARCHAR(100),
    event_type VARCHAR(100),
    payload JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Retry Queue (for failed asynchronous tasks)
CREATE TABLE retry_queue (
    id SERIAL PRIMARY KEY,
    service_name VARCHAR(100),
    operation VARCHAR(100),
    payload JSONB,
    retry_count INT DEFAULT 0,
    status ENUM('pending', 'in_progress', 'failed', 'completed') DEFAULT 'pending',
    next_retry_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Service Health (heartbeat/status monitor)
CREATE TABLE service_health (
    id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) UNIQUE,
    status ENUM('healthy', 'degraded', 'down') DEFAULT 'healthy',
    last_heartbeat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- API Usage Stats
CREATE TABLE api_usage_stats (
    id SERIAL PRIMARY KEY,
    service_name VARCHAR(100),
    endpoint VARCHAR(255),
    method VARCHAR(10),
    user_id INT,
    status_code INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dead Letter Queue (failed messages/tasks)
CREATE TABLE dead_letter_queue (
    id SERIAL PRIMARY KEY,
    service_name VARCHAR(100),
    failed_payload JSONB,
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
