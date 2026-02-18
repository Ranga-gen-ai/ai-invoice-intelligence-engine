# System Architecture – AI Invoice Intelligence Engine

## High-Level Flow

PDF Upload (Webhook)
→ Text Extraction
→ LLM-Based Structured Parsing
→ JSON Validation
→ Invoice Header Insert (PostgreSQL)
→ Line Item Relational Insert
→ Processing Log Entry

---

## Component Breakdown

### 1. Ingestion Layer
- Webhook endpoint receives invoice PDF.
- Binary data processed through extraction node.

### 2. Intelligence Layer
- Extracted text sent to Groq LLM.
- System prompt enforces strict JSON-only response.
- Temperature set to deterministic mode (0).
- Structured output parsed via JavaScript node.

### 3. Data Layer
- PostgreSQL (Supabase) used as relational datastore.
- UUID primary keys for distributed-safe identity.
- invoice_number unique constraint prevents duplication.
- line_items table linked through invoice_id foreign key.

### 4. Integrity & Logging
- Structured validation before DB insertion.
- Latency measurement between ingestion and completion.
- processing_logs table captures execution metadata.

---

## Design Principles

- Deterministic LLM usage for operational reliability.
- Normalized relational schema.
- Clear separation of header and line items.
- Idempotent insert logic.
- Modular workflow design.

---

## Scalability Considerations

- Can migrate to object storage for PDF retention.
- Can introduce queue-based processing for high volume.
- Can integrate RAG for vendor intelligence enrichment.
- Can expose REST retrieval APIs.

---

## Positioning

This system acts as an AI-powered financial document ingestion microservice suitable for:

- Accounts automation
- ERP pre-processing
- Financial operations teams
- MSME accounting workflows
