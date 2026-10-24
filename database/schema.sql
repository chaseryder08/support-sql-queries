-- =============================================================
-- Support SQL Queries: schema
-- A fictional field-service / dispatch platform for SQL practice.
-- All names and data are made up.
--
-- Rebuild the database from scratch:
--   sqlite3 database/support.db < database/schema.sql
--   sqlite3 database/support.db < database/seed.sql
-- =============================================================

-- SQLite does not enforce foreign keys unless you turn them on.
-- This setting only lasts for the current connection.
PRAGMA foreign_keys = ON;

-- Drop child tables before parent tables so the script can be re-run.
DROP TABLE IF EXISTS sync_errors;
DROP TABLE IF EXISTS sync_jobs;
DROP TABLE IF EXISTS billing_documents;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS organizations;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS accounts;

-- Customer accounts that use the platform.
CREATE TABLE accounts (
    id            INTEGER PRIMARY KEY,
    name          TEXT NOT NULL,
    account_type  TEXT NOT NULL,          -- enterprise, mid_market, small_business
    status        TEXT NOT NULL,          -- active, trial, suspended
    created_at    TEXT NOT NULL           -- 'YYYY-MM-DD HH:MM:SS'
);

-- People who log in to the platform. Each user belongs to one account.
CREATE TABLE users (
    id          INTEGER PRIMARY KEY,
    account_id  INTEGER NOT NULL REFERENCES accounts (id),
    name        TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE,
    role        TEXT NOT NULL,            -- admin, dispatcher, billing
    status      TEXT NOT NULL,            -- active, invited, disabled
    created_at  TEXT NOT NULL
);

-- Service providers (contractors or in-house teams) that do the work.
CREATE TABLE organizations (
    id                 INTEGER PRIMARY KEY,
    name               TEXT NOT NULL,
    organization_type  TEXT NOT NULL,     -- contractor, internal_team
    status             TEXT NOT NULL,     -- active, inactive, pending
    created_at         TEXT NOT NULL
);

-- Work orders. A job belongs to one account and may be assigned
-- to one organization (organization_id is NULL when unassigned).
CREATE TABLE jobs (
    id                    INTEGER PRIMARY KEY,
    account_id            INTEGER NOT NULL REFERENCES accounts (id),
    organization_id       INTEGER REFERENCES organizations (id),
    external_id           TEXT,           -- ID from the customer's other system; may be missing
    status                TEXT NOT NULL,  -- new, scheduled, in_progress, completed, canceled
    state_province        TEXT NOT NULL,
    priority_description  TEXT NOT NULL,  -- Low, Normal, High, Emergency
    service_type          TEXT NOT NULL,
    created_at            TEXT NOT NULL,
    updated_at            TEXT NOT NULL,
    completed_at          TEXT,
    deleted_at            TEXT            -- NULL = not deleted (soft delete)
);

-- Estimates and invoices. Each document belongs to one job.
CREATE TABLE billing_documents (
    id            INTEGER PRIMARY KEY,
    job_id        INTEGER NOT NULL REFERENCES jobs (id),
    doc_number    TEXT NOT NULL UNIQUE,
    doc_type      TEXT NOT NULL,          -- AccountEstimate, Invoice
    status        TEXT NOT NULL,          -- draft, submitted, approved, rejected, paid
    amount        REAL,                   -- may be NULL on an unfinished draft
    created_at    TEXT NOT NULL,
    updated_at    TEXT NOT NULL,
    submitted_at  TEXT,                   -- NULL until the document is submitted
    deleted_at    TEXT                    -- NULL = not deleted (soft delete)
);

-- Attempts to send a job to an external system. job_id is NULL when
-- the external_id received could not be matched to any job.
CREATE TABLE sync_jobs (
    id                INTEGER PRIMARY KEY,
    account_id        INTEGER NOT NULL REFERENCES accounts (id),
    job_id            INTEGER REFERENCES jobs (id),
    external_id       TEXT,
    integration_name  TEXT NOT NULL,      -- FieldLink, LedgerSync
    status            TEXT NOT NULL,      -- success, failed, pending
    attempt_number    INTEGER NOT NULL DEFAULT 1,  -- 2 or more = a retry
    started_at        TEXT NOT NULL,
    completed_at      TEXT,               -- NULL while still pending
    error_message     TEXT                -- summary of the failure, if any
);

-- Individual errors logged during a sync attempt (zero, one, or many).
CREATE TABLE sync_errors (
    id             INTEGER PRIMARY KEY,
    sync_job_id    INTEGER NOT NULL REFERENCES sync_jobs (id),
    error_code     TEXT NOT NULL,
    error_message  TEXT NOT NULL,
    created_at     TEXT NOT NULL,
    resolved_at    TEXT                   -- NULL = still unresolved
);
