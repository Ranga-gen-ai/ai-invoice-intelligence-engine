-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =========================
-- INVOICES TABLE
-- =========================
CREATE TABLE invoices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_number TEXT UNIQUE NOT NULL,
    seller_name TEXT,
    seller_gstin TEXT,
    seller_address TEXT,
    invoice_date DATE,
    customer_name TEXT,
    customer_gstin TEXT,
    customer_address TEXT,
    subtotal NUMERIC,
    gst_percentage NUMERIC,
    gst_amount NUMERIC,
    total_amount NUMERIC,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =========================
-- LINE ITEMS TABLE
-- =========================
CREATE TABLE line_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID REFERENCES invoices(id) ON DELETE CASCADE,
    description TEXT,
    quantity NUMERIC,
    unit_price NUMERIC,
    line_total NUMERIC,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =========================
-- PROCESSING LOGS TABLE
-- =========================
CREATE TABLE processing_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_number TEXT,
    status TEXT,
    error_message TEXT,
    latency_ms INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

