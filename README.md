# Support SQL Queries

SQL queries that answer realistic technical support tickets, run against a small fictional database for a field service management platform.

Each query starts from a question a support team might get, like "Which completed jobs were never billed?" or "Why does our sync say Duplicate external_id?", and answers it with SQL.

Built with **SQLite**. All names, IDs, and amounts are made up.

## What I learned

- Writing SQL to answer common tickets in a technical support role, starting from the customer's question and working out which tables hold the answer.
- Working with a database modeled on the kind of data a field service management platform stores: accounts, jobs, organizations, billing documents, sync jobs, and sync errors.
- Joining tables with `INNER JOIN` and `LEFT JOIN`, including three-table joins, and knowing when an INNER JOIN silently drops the rows I'm looking for.
- Finding records that are *missing* something, such as completed jobs with no invoice, using `LEFT JOIN` with `IS NULL`.
- Summarizing data with `COUNT`, `GROUP BY`, and `HAVING` to spot duplicate external IDs and the most common sync errors, and using `ORDER BY` to put the most important results first.
- Handling real-world data problems: NULL values, soft-deleted records (`deleted_at`), dates stored as text, and external IDs that almost match (typos, upper vs. lower case).

## The database

Seven tables, defined in [`database/schema.sql`](database/schema.sql) with sample data in [`database/seed.sql`](database/seed.sql).

| Table | What it holds | Connects to |
|---|---|---|
| `accounts` | Customer companies using the platform | (none) |
| `users` | People who log in; each belongs to one account | `account_id → accounts.id` |
| `organizations` | Contractors and in-house teams that do the work | (none) |
| `jobs` | Work orders | `account_id → accounts.id`, `organization_id → organizations.id` (NULL if unassigned) |
| `billing_documents` | Estimates and invoices for a job | `job_id → jobs.id` |
| `sync_jobs` | Attempts to send a job to an external system | `account_id → accounts.id`, `job_id → jobs.id` (NULL if no job matched) |
| `sync_errors` | Errors logged during a sync attempt | `sync_job_id → sync_jobs.id` |

The sample data treats **2026-03-31 as "today"**, so date-based queries always return the same results.

## The queries

| File | Topics | Example question |
|---|---|---|
| [`01_basics.sql`](queries/01_basics.sql) | SELECT, WHERE, ORDER BY, LIMIT, COUNT, GROUP BY | How many jobs are in each status? |
| [`02_joins.sql`](queries/02_joins.sql) | INNER JOIN, LEFT JOIN | How many jobs does every account have, including accounts with none? |
| [`03_multi_table.sql`](queries/03_multi_table.sql) | Joining three tables, one-to-many | Which contractor is assigned to each of Brightline's jobs? |
| [`04_investigations.sql`](queries/04_investigations.sql) | Missing records, dates, duplicates (HAVING) | Which completed jobs were never billed? Which open jobs are stale? |
| [`05_sync_failures.sql`](queries/05_sync_failures.sql) | sync_jobs, sync_errors | Which unresolved sync errors keep happening? Which external IDs matched no job? |

### A few things the queries uncovered

- **2 completed jobs were never billed** (NS-601 and SH-2009).
- **5 open jobs hadn't been updated in over a week**. A sixth looked stuck but had been soft-deleted.
- **External ID SH-2003 was on two jobs**, which is why Summit HVAC's sync kept failing with "Duplicate external_id."
- **Expired or invalid credentials (AUTH_FAILED)** were the most common unresolved sync error.
- **Two "not found" external IDs were near-misses**: `BL-1007` was meant to be `BL-10007`, and `ml-4007` was meant to be `ML-4007`.

## How to run it

You need [SQLite](https://sqlite.org/download.html) installed (`sqlite3 --version` to check).

Build the database (the `.db` file isn't stored in Git, so this is the first step):

```bash
sqlite3 database/support.db < database/schema.sql
sqlite3 database/support.db < database/seed.sql
```

Run a query file:

```bash
sqlite3 -header -column database/support.db < queries/04_investigations.sql
```
