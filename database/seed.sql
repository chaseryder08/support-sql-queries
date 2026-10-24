-- =============================================================
-- Support SQL Queries: sample data
-- Every name, email, ID, and amount below is fictional.
--
-- Reference date: treat 2026-03-31 as "today" for exercises such as
-- "not updated in the last 7 days". Using a fixed date (instead of
-- the real current date) keeps query results the same every time.
--
-- Run schema.sql first, then this file.
-- =============================================================

PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

-- -------------------------------------------------------------
-- accounts
-- -------------------------------------------------------------
INSERT INTO accounts (id, name, account_type, status, created_at) VALUES
    (1, 'Brightline Home Services',   'enterprise',     'active',    '2025-10-28 09:00:00'),
    (2, 'Summit HVAC Group',          'enterprise',     'active',    '2025-10-10 09:00:00'),
    (3, 'Coastal Plumbing Co',        'small_business', 'active',    '2025-11-25 09:00:00'),
    (4, 'Maple Leaf Property Mgmt',   'enterprise',     'active',    '2025-09-05 09:00:00'),
    (5, 'Redwood Appliance Repair',   'small_business', 'suspended', '2025-07-28 09:00:00'),
    (6, 'Northstar Facilities',       'mid_market',     'active',    '2025-07-10 09:00:00'),
    (7, 'Pinecrest Builders',         'small_business', 'trial',     '2026-03-01 09:00:00');

-- -------------------------------------------------------------
-- users
-- -------------------------------------------------------------
INSERT INTO users (id, account_id, name, email, role, status, created_at) VALUES
    (1,  1, 'Maria Delgado',   'maria.delgado@brightline.example',   'admin',      'active',   '2025-11-01 10:00:00'),
    (2,  1, 'Kevin Osei',      'kevin.osei@brightline.example',      'dispatcher', 'active',   '2025-11-03 10:00:00'),
    (3,  1, 'Priya Raman',     'priya.raman@brightline.example',     'billing',    'active',   '2025-11-10 10:00:00'),
    (4,  1, 'Tom Becker',      'tom.becker@brightline.example',      'dispatcher', 'disabled', '2025-11-15 10:00:00'),
    (5,  2, 'Laura Chen',      'laura.chen@summithvac.example',      'admin',      'active',   '2025-10-15 10:00:00'),
    (6,  2, 'Diego Fuentes',   'diego.fuentes@summithvac.example',   'dispatcher', 'active',   '2025-10-20 10:00:00'),
    (7,  2, 'Sam Whitaker',    'sam.whitaker@summithvac.example',    'billing',    'invited',  '2026-03-25 10:00:00'),
    (8,  3, 'Angela Brooks',   'angela.brooks@coastalplumb.example', 'admin',      'active',   '2025-12-01 10:00:00'),
    (9,  3, 'Marcus Hill',     'marcus.hill@coastalplumb.example',   'dispatcher', 'active',   '2025-12-02 10:00:00'),
    (10, 4, 'Sophie Tremblay', 'sophie.tremblay@mapleleaf.example',  'admin',      'active',   '2025-09-10 10:00:00'),
    (11, 4, 'Liam MacDonald',  'liam.macdonald@mapleleaf.example',   'dispatcher', 'active',   '2025-09-12 10:00:00'),
    (12, 4, 'Chloe Gagnon',    'chloe.gagnon@mapleleaf.example',     'billing',    'active',   '2025-09-12 11:00:00'),
    (13, 5, 'Ray Castillo',    'ray.castillo@redwoodrepair.example', 'admin',      'disabled', '2025-08-01 10:00:00'),
    (14, 6, 'Nina Patel',      'nina.patel@northstar.example',       'admin',      'active',   '2025-07-15 10:00:00'),
    (15, 6, 'Owen Price',      'owen.price@northstar.example',       'dispatcher', 'invited',  '2026-03-28 10:00:00'),
    (16, 7, 'Grace Lin',       'grace.lin@pinecrest.example',        'admin',      'invited',  '2026-03-01 10:00:00');

-- -------------------------------------------------------------
-- organizations (service providers)
-- -------------------------------------------------------------
INSERT INTO organizations (id, name, organization_type, status, created_at) VALUES
    (1, 'Apex Mechanical',            'contractor',    'active',   '2025-06-01 09:00:00'),
    (2, 'BlueWave Plumbing Partners', 'contractor',    'active',   '2025-06-15 09:00:00'),
    (3, 'Ironclad Electric',          'contractor',    'active',   '2025-07-01 09:00:00'),
    (4, 'Northern Comfort HVAC',      'contractor',    'active',   '2025-08-20 09:00:00'),
    (5, 'Rapid Response Appliance',   'contractor',    'inactive', '2025-07-20 09:00:00'),
    (6, 'Summit In-House Techs',      'internal_team', 'active',   '2025-10-10 09:00:00'),
    (7, 'TrueNorth Roofing',          'contractor',    'active',   '2025-09-01 09:00:00'),
    (8, 'Evergreen Services LLC',     'contractor',    'pending',  '2026-03-15 09:00:00');

-- -------------------------------------------------------------
-- jobs
-- -------------------------------------------------------------
INSERT INTO jobs (id, account_id, organization_id, external_id, status, state_province, priority_description, service_type, created_at, updated_at, completed_at, deleted_at) VALUES
    -- Brightline Home Services (account 1)
    (1,  1, 1,    'BL-10001', 'completed',   'TX', 'Normal',    'HVAC',             '2026-01-05 09:00:00', '2026-01-08 16:30:00', '2026-01-08 16:30:00', NULL),
    (2,  1, 1,    'BL-10002', 'completed',   'TX', 'High',      'HVAC',             '2026-01-12 08:15:00', '2026-01-14 11:00:00', '2026-01-14 11:00:00', NULL),
    (3,  1, 3,    'BL-10003', 'in_progress', 'TX', 'Emergency', 'Electrical',       '2026-03-20 07:45:00', '2026-03-28 10:00:00', NULL,                  NULL),
    (4,  1, 2,    'BL-10004', 'scheduled',   'OK', 'Normal',    'Plumbing',         '2026-03-22 13:00:00', '2026-03-30 09:20:00', NULL,                  NULL),
    (5,  1, 2,    NULL,       'new',         'TX', 'Low',       'Plumbing',         '2026-03-29 15:10:00', '2026-03-29 15:10:00', NULL,                  NULL),
    (6,  1, 1,    'BL-10006', 'canceled',    'OK', 'Normal',    'HVAC',             '2026-02-02 10:00:00', '2026-02-03 12:00:00', NULL,                  NULL),
    (7,  1, 3,    'BL-10007', 'completed',   'TX', 'Normal',    'Electrical',       '2026-02-10 09:30:00', '2026-02-12 17:45:00', '2026-02-12 17:45:00', NULL),
    (8,  1, 1,    'BL-10008', 'completed',   'TX', 'High',      'HVAC',             '2026-02-18 08:00:00', '2026-03-01 10:00:00', '2026-02-20 15:00:00', '2026-03-01 10:00:00'),
    (9,  1, NULL, 'BL-10009', 'new',         'OK', 'Normal',    'Appliance Repair', '2026-03-30 11:00:00', '2026-03-30 11:00:00', NULL,                  NULL),
    (10, 1, 3,    'BL-10010', 'scheduled',   'TX', 'High',      'Electrical',       '2026-03-10 14:00:00', '2026-03-15 09:00:00', NULL,                  NULL),
    -- Summit HVAC Group (account 2)
    (11, 2, 6,    'SH-2001',  'completed',   'CO', 'Normal',    'HVAC',             '2026-01-07 08:00:00', '2026-01-09 12:00:00', '2026-01-09 12:00:00', NULL),
    (12, 2, 6,    'SH-2002',  'completed',   'CO', 'Emergency', 'HVAC',             '2026-01-20 22:30:00', '2026-01-21 04:15:00', '2026-01-21 04:15:00', NULL),
    (13, 2, 1,    'SH-2003',  'in_progress', 'UT', 'High',      'HVAC',             '2026-03-18 09:00:00', '2026-03-27 13:30:00', NULL,                  NULL),
    (14, 2, 6,    'SH-2004',  'scheduled',   'CO', 'Normal',    'HVAC',             '2026-03-25 10:00:00', '2026-03-31 08:00:00', NULL,                  NULL),
    (15, 2, 1,    'SH-2005',  'completed',   'UT', 'Low',       'HVAC',             '2026-02-05 09:00:00', '2026-02-06 16:00:00', '2026-02-06 16:00:00', NULL),
    (16, 2, 6,    'SH-2006',  'canceled',    'CO', 'Normal',    'HVAC',             '2026-02-14 11:00:00', '2026-02-15 09:00:00', NULL,                  '2026-02-15 09:00:00'),
    (17, 2, 6,    'SH-2007',  'in_progress', 'CO', 'High',      'Electrical',       '2026-03-05 08:30:00', '2026-03-12 10:00:00', NULL,                  NULL),
    (18, 2, 1,    'SH-2003',  'scheduled',   'UT', 'Normal',    'HVAC',             '2026-03-26 12:00:00', '2026-03-26 12:00:00', NULL,                  NULL),
    -- Coastal Plumbing Co (account 3)
    (19, 3, 2,    'CP-301',   'completed',   'FL', 'Normal',    'Plumbing',         '2026-01-15 09:00:00', '2026-01-16 14:00:00', '2026-01-16 14:00:00', NULL),
    (20, 3, 2,    'CP-302',   'completed',   'FL', 'Emergency', 'Plumbing',         '2026-02-01 06:00:00', '2026-02-01 11:30:00', '2026-02-01 11:30:00', NULL),
    (21, 3, 2,    'CP-303',   'in_progress', 'GA', 'High',      'Plumbing',         '2026-03-24 10:00:00', '2026-03-29 16:00:00', NULL,                  NULL),
    (22, 3, 3,    'CP-304',   'scheduled',   'FL', 'Normal',    'Electrical',       '2026-03-27 08:00:00', '2026-03-27 08:00:00', NULL,                  NULL),
    (23, 3, 2,    NULL,       'new',         'GA', 'Low',       'Plumbing',         '2026-03-31 07:30:00', '2026-03-31 07:30:00', NULL,                  NULL),
    (24, 3, 2,    'CP-306',   'completed',   'FL', 'Normal',    'Plumbing',         '2026-03-02 13:00:00', '2026-03-04 10:00:00', '2026-03-04 10:00:00', NULL),
    (25, 3, 7,    'CP-307',   'completed',   'GA', 'High',      'Roofing',          '2026-02-22 09:00:00', '2026-02-25 17:00:00', '2026-02-25 17:00:00', NULL),
    -- Maple Leaf Property Mgmt (account 4, Canadian provinces)
    (26, 4, 4,    'ML-4001',  'completed',   'ON', 'Normal',    'HVAC',             '2026-01-10 10:00:00', '2026-01-12 15:00:00', '2026-01-12 15:00:00', NULL),
    (27, 4, 4,    'ML-4002',  'completed',   'ON', 'High',      'HVAC',             '2026-02-03 08:00:00', '2026-02-05 12:00:00', '2026-02-05 12:00:00', NULL),
    (28, 4, 7,    'ML-4003',  'in_progress', 'BC', 'Normal',    'Roofing',          '2026-03-16 09:00:00', '2026-03-23 11:00:00', NULL,                  NULL),
    (29, 4, 4,    'ML-4004',  'scheduled',   'QC', 'Normal',    'HVAC',             '2026-03-28 14:00:00', '2026-03-30 10:00:00', NULL,                  NULL),
    (30, 4, 4,    'ML-4005',  'completed',   'ON', 'Emergency', 'HVAC',             '2026-03-08 03:00:00', '2026-03-08 09:30:00', '2026-03-08 09:30:00', NULL),
    (31, 4, 7,    'ML-4006',  'canceled',    'BC', 'Low',       'Roofing',          '2026-02-20 10:00:00', '2026-02-21 10:00:00', NULL,                  NULL),
    (32, 4, 4,    'ML-4007',  'new',         'QC', 'Normal',    'HVAC',             '2026-03-30 16:00:00', '2026-03-30 16:00:00', NULL,                  NULL),
    -- Redwood Appliance Repair (account 5, suspended)
    (33, 5, 5,    'RW-501',   'completed',   'CA', 'Normal',    'Appliance Repair', '2026-01-08 10:00:00', '2026-01-09 13:00:00', '2026-01-09 13:00:00', NULL),
    (34, 5, 5,    'RW-502',   'completed',   'CA', 'High',      'Appliance Repair', '2026-01-22 09:00:00', '2026-01-23 15:00:00', '2026-01-23 15:00:00', NULL),
    (35, 5, 5,    'RW-503',   'scheduled',   'CA', 'Normal',    'Appliance Repair', '2026-02-10 11:00:00', '2026-02-12 09:00:00', NULL,                  NULL),
    (36, 5, 5,    'RW-504',   'new',         'CA', 'Low',       'Appliance Repair', '2026-02-15 10:00:00', '2026-02-28 12:00:00', NULL,                  '2026-02-28 12:00:00'),
    -- Northstar Facilities (account 6)
    (37, 6, 3,    'NS-601',   'completed',   'IL', 'Normal',    'Electrical',       '2026-01-06 08:00:00', '2026-01-07 12:00:00', '2026-01-07 12:00:00', NULL),
    (38, 6, 1,    'NS-602',   'completed',   'IL', 'Normal',    'HVAC',             '2026-01-19 09:00:00', '2026-01-21 14:00:00', '2026-01-21 14:00:00', NULL),
    (39, 6, 3,    'NS-603',   'in_progress', 'IL', 'High',      'Electrical',       '2026-02-25 10:00:00', '2026-03-02 15:00:00', NULL,                  NULL),
    (40, 6, 1,    'NS-604',   'scheduled',   'IL', 'Normal',    'HVAC',             '2026-03-26 09:00:00', '2026-03-29 11:00:00', NULL,                  NULL),
    -- Summit HVAC Group again (added later in the month)
    (41, 2, 1,    'SH-2009',  'completed',   'UT', 'Normal',    'HVAC',             '2026-03-11 09:00:00', '2026-03-13 14:00:00', NULL,                  NULL);

-- -------------------------------------------------------------
-- billing_documents
-- -------------------------------------------------------------
INSERT INTO billing_documents (id, job_id, doc_number, doc_type, status, amount, created_at, updated_at, submitted_at, deleted_at) VALUES
    (1,  1,  'EST-1001', 'AccountEstimate', 'approved',  450.00,   '2026-01-05 10:00:00', '2026-01-06 09:00:00', '2026-01-05 10:30:00', NULL),
    (2,  1,  'INV-5001', 'Invoice',         'paid',      450.00,   '2026-01-08 17:00:00', '2026-01-20 12:00:00', '2026-01-08 17:15:00', NULL),
    (3,  2,  'EST-1002', 'AccountEstimate', 'approved',  1200.00,  '2026-01-12 09:00:00', '2026-01-12 15:00:00', '2026-01-12 09:30:00', NULL),
    (4,  2,  'INV-5002', 'Invoice',         'paid',      1250.00,  '2026-01-14 11:30:00', '2026-01-28 10:00:00', '2026-01-14 12:00:00', NULL),
    (5,  3,  'EST-1003', 'AccountEstimate', 'submitted', 2300.00,  '2026-03-21 09:00:00', '2026-03-21 09:45:00', '2026-03-21 09:45:00', NULL),
    (6,  4,  'EST-1004', 'AccountEstimate', 'draft',     NULL,     '2026-03-23 10:00:00', '2026-03-23 10:00:00', NULL,                  NULL),
    (7,  7,  'EST-1005', 'AccountEstimate', 'approved',  640.00,   '2026-02-10 11:00:00', '2026-02-11 08:00:00', '2026-02-10 11:20:00', NULL),
    (8,  7,  'INV-5003', 'Invoice',         'submitted', 640.00,   '2026-02-12 18:00:00', '2026-02-12 18:05:00', '2026-02-12 18:05:00', NULL),
    (9,  8,  'EST-1006', 'AccountEstimate', 'approved',  900.00,   '2026-02-18 09:00:00', '2026-02-18 14:00:00', '2026-02-18 09:30:00', NULL),
    (10, 8,  'INV-5004', 'Invoice',         'paid',      900.00,   '2026-02-20 15:30:00', '2026-02-27 11:00:00', '2026-02-20 15:45:00', NULL),
    (11, 10, 'EST-1007', 'AccountEstimate', 'rejected',  1750.00,  '2026-03-10 15:00:00', '2026-03-12 10:00:00', '2026-03-10 15:30:00', NULL),
    (12, 10, 'EST-1008', 'AccountEstimate', 'submitted', 1500.00,  '2026-03-13 09:00:00', '2026-03-13 09:30:00', '2026-03-13 09:30:00', NULL),
    (13, 11, 'EST-1009', 'AccountEstimate', 'approved',  3100.00,  '2026-01-07 09:00:00', '2026-01-07 16:00:00', '2026-01-07 09:30:00', NULL),
    (14, 11, 'INV-5005', 'Invoice',         'paid',      3100.00,  '2026-01-09 12:30:00', '2026-01-25 09:00:00', '2026-01-09 13:00:00', NULL),
    (15, 12, 'INV-5006', 'Invoice',         'paid',      850.00,   '2026-01-21 05:00:00', '2026-02-03 10:00:00', '2026-01-21 05:30:00', NULL),
    (16, 13, 'EST-1010', 'AccountEstimate', 'rejected',  5200.00,  '2026-03-18 10:00:00', '2026-03-20 11:00:00', '2026-03-18 10:30:00', NULL),
    (17, 13, 'EST-1011', 'AccountEstimate', 'submitted', 4800.00,  '2026-03-21 08:00:00', '2026-03-21 08:30:00', '2026-03-21 08:30:00', NULL),
    (18, 15, 'EST-1012', 'AccountEstimate', 'approved',  300.00,   '2026-02-05 10:00:00', '2026-02-05 13:00:00', '2026-02-05 10:15:00', NULL),
    (19, 15, 'INV-5007', 'Invoice',         'approved',  300.00,   '2026-02-06 16:30:00', '2026-02-09 09:00:00', '2026-02-06 16:45:00', NULL),
    (20, 16, 'EST-1013', 'AccountEstimate', 'draft',     600.00,   '2026-02-14 11:10:00', '2026-02-15 09:00:00', NULL,                  '2026-02-15 09:00:00'),
    (21, 17, 'EST-1014', 'AccountEstimate', 'submitted', 950.00,   '2026-03-05 09:00:00', '2026-03-05 09:30:00', '2026-03-05 09:30:00', NULL),
    (22, 18, 'EST-1015', 'AccountEstimate', 'draft',     4800.00,  '2026-03-26 12:30:00', '2026-03-26 12:30:00', NULL,                  NULL),
    (23, 19, 'EST-1016', 'AccountEstimate', 'approved',  275.00,   '2026-01-15 10:00:00', '2026-01-15 12:00:00', '2026-01-15 10:10:00', NULL),
    (24, 19, 'INV-5008', 'Invoice',         'paid',      275.00,   '2026-01-16 14:30:00', '2026-01-30 10:00:00', '2026-01-16 14:45:00', NULL),
    (25, 20, 'INV-5009', 'Invoice',         'paid',      1400.00,  '2026-02-01 12:00:00', '2026-02-10 09:00:00', '2026-02-01 12:15:00', NULL),
    (26, 21, 'EST-1017', 'AccountEstimate', 'submitted', 2100.00,  '2026-03-24 11:00:00', '2026-03-24 11:30:00', '2026-03-24 11:30:00', NULL),
    (27, 21, 'EST-1018', 'AccountEstimate', 'draft',     2150.00,  '2026-03-24 10:45:00', '2026-03-24 11:00:00', NULL,                  '2026-03-24 11:00:00'),
    (28, 24, 'EST-1019', 'AccountEstimate', 'approved',  520.00,   '2026-03-02 14:00:00', '2026-03-02 17:00:00', '2026-03-02 14:20:00', NULL),
    (29, 24, 'INV-5010', 'Invoice',         'submitted', 520.00,   '2026-03-04 10:30:00', '2026-03-04 10:45:00', '2026-03-04 10:45:00', NULL),
    (30, 24, 'INV-5011', 'Invoice',         'draft',     520.00,   '2026-03-04 10:35:00', '2026-03-04 11:00:00', NULL,                  '2026-03-04 11:00:00'),
    (31, 25, 'EST-1020', 'AccountEstimate', 'approved',  7800.00,  '2026-02-22 10:00:00', '2026-02-23 09:00:00', '2026-02-22 10:30:00', NULL),
    (32, 25, 'INV-5012', 'Invoice',         'approved',  7800.00,  '2026-02-25 17:30:00', '2026-03-02 14:00:00', '2026-02-25 17:45:00', NULL),
    (33, 26, 'EST-1021', 'AccountEstimate', 'approved',  1100.00,  '2026-01-10 11:00:00', '2026-01-10 15:00:00', '2026-01-10 11:15:00', NULL),
    (34, 26, 'INV-5013', 'Invoice',         'paid',      1100.00,  '2026-01-12 15:30:00', '2026-01-26 10:00:00', '2026-01-12 15:45:00', NULL),
    (35, 27, 'EST-1022', 'AccountEstimate', 'approved',  2400.00,  '2026-02-03 09:00:00', '2026-02-03 14:00:00', '2026-02-03 09:20:00', NULL),
    (36, 27, 'INV-5014', 'Invoice',         'rejected',  2600.00,  '2026-02-05 12:30:00', '2026-02-06 10:00:00', '2026-02-05 12:45:00', NULL),
    (37, 27, 'INV-5015', 'Invoice',         'submitted', 2400.00,  '2026-02-06 11:00:00', '2026-02-06 11:15:00', '2026-02-06 11:15:00', NULL),
    (38, 28, 'EST-1023', 'AccountEstimate', 'submitted', 12500.00, '2026-03-16 10:00:00', '2026-03-16 10:30:00', '2026-03-16 10:30:00', NULL),
    (39, 30, 'INV-5016', 'Invoice',         'submitted', 1950.00,  '2026-03-08 10:00:00', '2026-03-08 10:15:00', '2026-03-08 10:15:00', NULL),
    (40, 33, 'EST-1024', 'AccountEstimate', 'approved',  180.00,   '2026-01-08 11:00:00', '2026-01-08 12:00:00', '2026-01-08 11:10:00', NULL),
    (41, 33, 'INV-5017', 'Invoice',         'paid',      180.00,   '2026-01-09 13:30:00', '2026-01-19 09:00:00', '2026-01-09 13:45:00', NULL),
    (42, 34, 'EST-1025', 'AccountEstimate', 'approved',  420.00,   '2026-01-22 10:00:00', '2026-01-22 13:00:00', '2026-01-22 10:15:00', NULL),
    (43, 34, 'INV-5018', 'Invoice',         'submitted', 420.00,   '2026-01-23 15:30:00', '2026-01-23 15:45:00', '2026-01-23 15:45:00', NULL),
    (44, 35, 'EST-1026', 'AccountEstimate', 'submitted', 260.00,   '2026-02-10 12:00:00', '2026-02-10 12:30:00', '2026-02-10 12:30:00', NULL),
    (45, 38, 'EST-1027', 'AccountEstimate', 'approved',  1600.00,  '2026-01-19 10:00:00', '2026-01-19 15:00:00', '2026-01-19 10:20:00', NULL),
    (46, 38, 'INV-5019', 'Invoice',         'paid',      1600.00,  '2026-01-21 14:30:00', '2026-02-04 09:00:00', '2026-01-21 14:45:00', NULL),
    (47, 39, 'EST-1028', 'AccountEstimate', 'rejected',  3900.00,  '2026-02-25 11:00:00', '2026-02-27 09:00:00', '2026-02-25 11:30:00', NULL),
    (48, 39, 'EST-1029', 'AccountEstimate', 'submitted', 3400.00,  '2026-02-28 10:00:00', '2026-02-28 10:30:00', '2026-02-28 10:30:00', NULL);

-- -------------------------------------------------------------
-- sync_jobs (attempts to sync with fictional external systems)
-- -------------------------------------------------------------
INSERT INTO sync_jobs (id, account_id, job_id, external_id, integration_name, status, attempt_number, started_at, completed_at, error_message) VALUES
    -- Brightline Home Services (account 1)
    (1,  1, 1,    'BL-10001', 'FieldLink',  'success', 1, '2026-01-08 16:35:00', '2026-01-08 16:35:20', NULL),
    (2,  1, 2,    'BL-10002', 'FieldLink',  'success', 1, '2026-01-14 11:05:00', '2026-01-14 11:05:18', NULL),
    (3,  1, 3,    'BL-10003', 'FieldLink',  'failed',  1, '2026-03-28 10:05:00', '2026-03-28 10:05:30', 'Request timed out'),
    (4,  1, 3,    'BL-10003', 'FieldLink',  'failed',  2, '2026-03-28 10:35:00', '2026-03-28 10:35:30', 'Request timed out'),
    (5,  1, 3,    'BL-10003', 'FieldLink',  'success', 3, '2026-03-28 11:05:00', '2026-03-28 11:05:40', NULL),
    (6,  1, NULL, 'BL-99999', 'FieldLink',  'failed',  1, '2026-03-29 08:00:00', '2026-03-29 08:00:05', 'No job found matching external_id'),
    (7,  1, 5,    NULL,       'FieldLink',  'failed',  1, '2026-03-29 15:15:00', '2026-03-29 15:15:02', 'Missing external_id'),
    (8,  1, 4,    'BL-10004', 'FieldLink',  'pending', 1, '2026-03-31 09:00:00', NULL,                  NULL),
    (9,  1, 10,   'BL-10010', 'FieldLink',  'failed',  1, '2026-03-15 09:05:00', '2026-03-15 09:05:03', 'Authentication failed'),
    (10, 1, 10,   'BL-10010', 'FieldLink',  'failed',  2, '2026-03-15 10:05:00', '2026-03-15 10:05:03', 'Authentication failed'),
    (11, 1, 10,   'BL-10010', 'FieldLink',  'failed',  3, '2026-03-15 11:05:00', '2026-03-15 11:05:04', 'Authentication failed'),
    (12, 1, 7,    'BL-10007', 'LedgerSync', 'success', 1, '2026-02-12 18:00:00', '2026-02-12 18:00:12', NULL),
    (13, 1, NULL, 'BL-1007',  'LedgerSync', 'failed',  1, '2026-02-12 18:01:00', '2026-02-12 18:01:03', 'No job found matching external_id'),
    -- Summit HVAC Group (account 2)
    (14, 2, 11,   'SH-2001',  'FieldLink',  'success', 1, '2026-01-09 12:05:00', '2026-01-09 12:05:15', NULL),
    (15, 2, 12,   'SH-2002',  'FieldLink',  'success', 1, '2026-01-21 04:20:00', '2026-01-21 04:20:14', NULL),
    (16, 2, 13,   'SH-2003',  'FieldLink',  'failed',  1, '2026-03-27 13:35:00', '2026-03-27 13:35:04', 'Duplicate external_id'),
    (17, 2, 13,   'SH-2003',  'FieldLink',  'failed',  2, '2026-03-27 14:35:00', '2026-03-27 14:35:04', 'Duplicate external_id'),
    (18, 2, 18,   'SH-2003',  'FieldLink',  'failed',  1, '2026-03-26 12:05:00', '2026-03-26 12:05:04', 'Duplicate external_id'),
    (19, 2, 17,   'SH-2007',  'FieldLink',  'failed',  1, '2026-03-12 10:05:00', '2026-03-12 10:05:02', 'Invalid payload'),
    (20, 2, 17,   'SH-2007',  'FieldLink',  'success', 2, '2026-03-12 10:45:00', '2026-03-12 10:45:10', NULL),
    (21, 2, 14,   'SH-2004',  'FieldLink',  'pending', 1, '2026-03-31 08:05:00', NULL,                  NULL),
    (22, 2, NULL, 'SH-2099',  'FieldLink',  'failed',  1, '2026-03-20 09:00:00', '2026-03-20 09:00:04', 'No job found matching external_id'),
    (23, 2, 15,   'SH-2005',  'FieldLink',  'success', 1, '2026-02-06 16:05:00', '2026-02-06 16:06:20', NULL),
    -- Coastal Plumbing Co (account 3)
    (24, 3, 19,   'CP-301',   'LedgerSync', 'success', 1, '2026-01-16 14:10:00', '2026-01-16 14:10:09', NULL),
    (25, 3, 20,   'CP-302',   'LedgerSync', 'success', 1, '2026-02-01 11:40:00', '2026-02-01 11:40:11', NULL),
    (26, 3, 21,   'CP-303',   'LedgerSync', 'failed',  1, '2026-03-29 16:05:00', '2026-03-29 16:05:05', 'Request rejected by remote system'),
    (27, 3, 21,   'CP-303',   'LedgerSync', 'pending', 2, '2026-03-30 08:00:00', NULL,                  NULL),
    (28, 3, 24,   'CP-306',   'LedgerSync', 'success', 1, '2026-03-04 10:10:00', '2026-03-04 10:10:08', NULL),
    (29, 3, 23,   NULL,       'LedgerSync', 'failed',  1, '2026-03-31 07:35:00', '2026-03-31 07:35:02', 'Missing external_id'),
    (30, 3, 25,   'CP-307',   'LedgerSync', 'failed',  1, '2026-02-25 17:10:00', '2026-02-25 17:10:30', 'Request timed out'),
    (31, 3, 25,   'CP-307',   'LedgerSync', 'success', 2, '2026-02-25 17:40:00', '2026-02-25 17:40:20', NULL),
    -- Maple Leaf Property Mgmt (account 4)
    (32, 4, 26,   'ML-4001',  'FieldLink',  'success', 1, '2026-01-12 15:05:00', '2026-01-12 15:05:16', NULL),
    (33, 4, 27,   'ML-4002',  'FieldLink',  'success', 1, '2026-02-05 12:05:00', '2026-02-05 12:05:13', NULL),
    (34, 4, 28,   'ML-4003',  'FieldLink',  'failed',  1, '2026-03-23 11:05:00', '2026-03-23 11:05:02', 'Authentication failed'),
    (35, 4, 28,   'ML-4003',  'FieldLink',  'failed',  2, '2026-03-24 11:05:00', '2026-03-24 11:05:35', 'Authentication failed'),
    (36, 4, 30,   'ML-4005',  'FieldLink',  'success', 1, '2026-03-08 09:35:00', '2026-03-08 09:35:12', NULL),
    (37, 4, 29,   'ML-4004',  'FieldLink',  'success', 1, '2026-03-30 10:05:00', '2026-03-30 10:05:14', NULL),
    (38, 4, NULL, 'ml-4007',  'FieldLink',  'failed',  1, '2026-03-30 16:05:00', '2026-03-30 16:05:03', 'No job found matching external_id'),
    -- Redwood Appliance Repair (account 5)
    (39, 5, 33,   'RW-501',   'LedgerSync', 'success', 1, '2026-01-09 13:05:00', '2026-01-09 13:05:10', NULL),
    (40, 5, 34,   'RW-502',   'LedgerSync', 'failed',  1, '2026-01-23 15:05:00', '2026-01-23 15:05:04', 'Request rejected by remote system'),
    (41, 5, 35,   'RW-503',   'LedgerSync', 'failed',  1, '2026-02-12 09:05:00', '2026-02-12 09:05:03', 'Authentication failed'),
    -- Northstar Facilities (account 6)
    (42, 6, 37,   'NS-601',   'FieldLink',  'success', 1, '2026-01-07 12:05:00', '2026-01-07 12:05:11', NULL),
    (43, 6, 38,   'NS-602',   'FieldLink',  'success', 1, '2026-01-21 14:05:00', '2026-01-21 14:05:12', NULL);

-- -------------------------------------------------------------
-- sync_errors
-- -------------------------------------------------------------
INSERT INTO sync_errors (id, sync_job_id, error_code, error_message, created_at, resolved_at) VALUES
    (1,  3,  'TIMEOUT',               'Request timed out after 30 seconds',                              '2026-03-28 10:05:30', '2026-03-28 11:05:40'),
    (2,  4,  'TIMEOUT',               'Request timed out after 30 seconds',                              '2026-03-28 10:35:30', '2026-03-28 11:05:40'),
    (3,  6,  'EXTERNAL_ID_NOT_FOUND', 'No job found with external_id BL-99999',                          '2026-03-29 08:00:05', NULL),
    (4,  7,  'MISSING_EXTERNAL_ID',   'Job 5 has no external_id; cannot sync',                           '2026-03-29 15:15:02', NULL),
    (5,  9,  'AUTH_FAILED',           'Authentication failed: access token expired',                     '2026-03-15 09:05:03', NULL),
    (6,  10, 'AUTH_FAILED',           'Authentication failed: access token expired',                     '2026-03-15 10:05:03', NULL),
    (7,  11, 'AUTH_FAILED',           'Authentication failed: access token expired',                     '2026-03-15 11:05:03', NULL),
    (8,  11, 'RATE_LIMITED',          'Too many requests; retry after 60 seconds',                       '2026-03-15 11:05:04', NULL),
    (9,  13, 'EXTERNAL_ID_NOT_FOUND', 'No job found with external_id BL-1007',                           '2026-02-12 18:01:03', '2026-02-13 09:00:00'),
    (10, 16, 'DUPLICATE_EXTERNAL_ID', 'external_id SH-2003 matches more than one job',                   '2026-03-27 13:35:04', NULL),
    (11, 17, 'DUPLICATE_EXTERNAL_ID', 'external_id SH-2003 matches more than one job',                   '2026-03-27 14:35:04', NULL),
    (12, 18, 'DUPLICATE_EXTERNAL_ID', 'external_id SH-2003 matches more than one job',                   '2026-03-26 12:05:04', NULL),
    (13, 19, 'INVALID_PAYLOAD',       'Field priority_description has an unrecognized value',            '2026-03-12 10:05:02', '2026-03-12 10:45:10'),
    (14, 19, 'INVALID_PAYLOAD',       'Field service_type exceeds maximum length',                       '2026-03-12 10:05:02', '2026-03-12 10:45:10'),
    (15, 22, 'EXTERNAL_ID_NOT_FOUND', 'No job found with external_id SH-2099',                           '2026-03-20 09:00:04', NULL),
    (16, 23, 'RATE_LIMITED',          'Too many requests; retry after 60 seconds',                       '2026-02-06 16:05:10', '2026-02-06 16:06:10'),
    (17, 26, 'REQUEST_REJECTED',      'Remote system returned 422: invoice total does not match lines',  '2026-03-29 16:05:05', NULL),
    (18, 29, 'MISSING_EXTERNAL_ID',   'Job 23 has no external_id; cannot sync',                          '2026-03-31 07:35:02', NULL),
    (19, 30, 'TIMEOUT',               'Request timed out after 30 seconds',                              '2026-02-25 17:10:30', '2026-02-25 17:40:20'),
    (20, 34, 'AUTH_FAILED',           'Authentication failed: invalid API key',                          '2026-03-23 11:05:02', NULL),
    (21, 35, 'AUTH_FAILED',           'Authentication failed: invalid API key',                          '2026-03-24 11:05:02', NULL),
    (22, 35, 'TIMEOUT',               'Request timed out after 30 seconds',                              '2026-03-24 11:05:35', NULL),
    (23, 38, 'EXTERNAL_ID_NOT_FOUND', 'No job found with external_id ml-4007',                           '2026-03-30 16:05:03', NULL),
    (24, 40, 'REQUEST_REJECTED',      'Remote system returned 403: account not authorized',              '2026-01-23 15:05:04', '2026-01-24 10:00:00');

COMMIT;
