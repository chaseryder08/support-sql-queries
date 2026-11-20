-- =============================================================
-- 03: Multi-table queries
-- Joining jobs, accounts, organizations, and billing_documents
-- =============================================================

-- New jobs and their assigned organization
SELECT jobs.id, jobs.status, organizations.name
FROM jobs
LEFT JOIN organizations
ON organizations.id = jobs.organization_id
WHERE jobs.status = 'new';

-- Billing documents for job CP-306
SELECT jobs.external_id, billing_documents.doc_number, billing_documents.doc_type, billing_documents.status, billing_documents.deleted_at
FROM billing_documents
LEFT JOIN jobs
ON jobs.id = billing_documents.job_id
WHERE jobs.external_id = 'CP-306';

-- Brightline's jobs with their assigned contractor
SELECT accounts.name AS account, jobs.id, jobs.status,
      organizations.name AS organization
FROM jobs
INNER JOIN accounts
  ON accounts.id = jobs.account_id
LEFT JOIN organizations
  ON organizations.id = jobs.organization_id
WHERE accounts.name = 'Brightline Home Services';
