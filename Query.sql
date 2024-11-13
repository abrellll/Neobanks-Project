CREATE SCHEMA NEO;

CREATE TABLE NEO.transaction_detail (
    transaction_date DATE,
    user_id VARCHAR(100),
    transaction_id VARCHAR(100),
    transaction_amount FLOAT
);

CREATE TABLE NEO.user_info (
  user_id VARCHAR(100),
  user_name VARCHAR(100),
  user_type VARCHAR (100)
);

INSERT INTO NEO.transaction_detail (transaction_date, user_id, transaction_id, transaction_amount)
VALUES 	
	('2022-9-26', '630896', 'LRM-123', 8409952),
	('2021-9-2', '540885', 'PAG-269', 5789470),
	('2021-6-14', '838693', 'CMA-888', 8701781),
    ('2022-8-5', '860614', 'GYX-702', 4875473),
    ('2022-11-14', '861388', 'DXQ-163', 2555684),
    ('2022-4-1', '332208', 'BDB-345', 4781370),
    ('2021-8-1', '378317', 'WND-613', 9484204),
    ('2022-3-9', '840679', 'ZDC-322', 375903375),
    ('2021-7-6', '982223', 'ZNQ-598', 231420280),
    ('2022-3-10', '680168', 'POK-940', 179074805),
    ('2022-2-20', '487282', 'HPO-928', 5736544),
    ('2021-9-30', '289815', 'JSS-322', 6135228),
    ('2022-4-21', '628119', 'XPR-778', 5281025),
    ('2022-12-9', '372494', 'NCU-998', 2650512),
    ('2022-4-11', '729445', 'WZC-768', 9557900),
    ('2021-12-21', '277676', 'OEB-659', 4365803),
    ('2021-1-28', '926046', 'PME-630', 2878333),
    ('2021-3-16', '572214', 'NXC-494', 8595848),
    ('2021-7-4', '249040', 'ZHA-318', 6857503),
    ('2021-6-24', '757120', 'YNP-655', 65595),
    ('2022-4-1', '909264', 'TYF-616', 4486491)
;

INSERT INTO NEO.user_info (user_id, user_name, user_type)
VALUES 
    ('630896', 'Mas Samsu', 'Retail'),
    ('540885', 'Endy Alam Sutera', 'Retail'),
    ('838693', 'Mas Yono', 'Retail'),
    ('860614', 'Fina Drift', 'Retail'),
    ('861388', 'Pempek PNS', 'Merchant'),
    ('332208', 'Resto Biasa Saja', 'Merchant'),
    ('378317', 'Hadir Fried Chicken', 'Merchant'),
    ('840679', 'PT Berapa Berapa', 'Corporate'),
    ('982223', 'PT Jengkol Abadi Jaya', 'Corporate'),
    ('680168', 'Tama Moving Company', 'Corporate')   
;

SELECT * FROM NEO.transaction_detail;
SELECT * FROM NEO.user_info;

-- TEST A
SELECT
    DATE_FORMAT(t.transaction_date, '%Y-%m') AS transaction_month,
    u.user_type,
    COUNT(t.transaction_id) AS total_transaction,
    SUM(t.transaction_amount) AS total_transaction_amount
FROM
    NEO.transaction_detail t
JOIN
    NEO.user_info u
    ON t.user_id = u.user_id
WHERE
    u.user_type IN ('Retail', 'Corporate')
    AND t.transaction_date BETWEEN '2021-06-01' AND '2021-12-31'
GROUP BY
    DATE_FORMAT(t.transaction_date, '%Y-%m'),
    u.user_type
ORDER BY
    transaction_month,
    u.user_type;

-- TEST B
SELECT
    COUNT(DISTINCT t.user_id) AS num_users
FROM
    NEO.transaction_detail t
JOIN
    NEO.user_info u
    ON t.user_id = u.user_id
WHERE
    t.transaction_date BETWEEN '2022-12-01' AND '2022-12-31'
GROUP BY
    t.user_id
HAVING
    SUM(t.transaction_amount) > 100000000;
