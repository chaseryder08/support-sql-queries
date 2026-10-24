-- =============================================================
-- 01: Single-table basics
-- SELECT, WHERE, ORDER BY, LIMIT, COUNT, GROUP BY
-- =============================================================

-- Support question: How many jobs are in each status?
SELECT status, COUNT(*) AS total
FROM jobs
GROUP BY status
ORDER BY total DESC;

-- Support question: What are the 3 most recent Emergency jobs?
SELECT id, status, created_at
FROM jobs
WHERE priority_description = 'Emergency'
ORDER BY created_at DESC
LIMIT 3;
