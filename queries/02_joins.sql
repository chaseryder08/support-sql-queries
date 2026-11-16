-- Show Brightline Home Services' jobs
SELECT jobs.id, accounts.name, jobs.status
FROM jobs
INNER JOIN accounts
ON jobs.account_id = accounts.id
WHERE accounts.name = 'Brightline Home Services';

-- Job count for every account, including zero
SELECT accounts.name, COUNT(jobs.id) AS total_jobs
FROM accounts
LEFT JOIN jobs
  ON accounts.id = jobs.account_id
GROUP BY accounts.id, accounts.name
ORDER BY total_jobs;