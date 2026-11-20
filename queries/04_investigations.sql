-- =============================================================
-- 04: Support investigations
-- Missing records, stale jobs (dates), duplicate external IDs
-- =============================================================

-- Completed jobs with no billing documents
SELECT jobs.id, jobs.external_id, jobs.status
FROM jobs
LEFT JOIN billing_documents
  ON billing_documents.job_id = jobs.id
WHERE jobs.status = 'completed' AND billing_documents.id IS NULL;

-- Open jobs not updated in the last 7 days
SELECT jobs.id, jobs.external_id, jobs.status, jobs.updated_at
FROM jobs
WHERE jobs.status IN ('new', 'scheduled', 'in_progress') AND jobs.updated_at < '2026-03-24' AND jobs.deleted_at IS NULL
ORDER BY jobs.updated_at ASC;

-- External IDs used by more than one job
SELECT jobs.external_id, COUNT(*) AS job_count
FROM jobs
WHERE jobs.external_id IS NOT NULL
GROUP BY jobs.external_id
HAVING COUNT(*) > 1;
