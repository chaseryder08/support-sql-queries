-- =============================================================
-- 05: Sync failures
-- sync_jobs, sync_errors, and unmatched external IDs
-- =============================================================

-- Unresolved sync errors per integration and error code
SELECT sync_jobs.integration_name, sync_errors.error_code, COUNT(*) AS unresolved_errors
FROM sync_errors
INNER JOIN sync_jobs
ON sync_jobs.id = sync_errors.sync_job_id
WHERE sync_errors.resolved_at IS NULL
GROUP BY sync_jobs.integration_name, sync_errors.error_code
ORDER BY unresolved_errors DESC;

-- Sync attempts whose external_id matched no job
SELECT accounts.name AS account, sync_jobs.external_id, sync_jobs.integration_name, sync_jobs.started_at
FROM sync_jobs
INNER JOIN accounts
ON accounts.id = sync_jobs.account_id
WHERE sync_jobs.job_id IS NULL
ORDER BY sync_jobs.started_at ASC;
