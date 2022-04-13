-- From the dividend table, fetch the companies who gave dividend consecutively 3 or more times.

--Table Structure:
DROP TABLE IF EXISTS dividend;
CREATE TABLE dividend
(
    company character varying(12),
    fiscal_year bigint 
);

INSERT INTO dividend(company, fiscal_year)
VALUES('AHPC',20702071),
('AHPC',20712072),
('AHPC',20732074),
('AHPC',20762077),
('CZBIL',20692070),
('CZBIL',20702071),
('CZBIL',20712072),
('CZBIL',20732074),
('GBIME',20692070),
('GBIME',20702071),
('GBIME',20712072),
('GBIME',20732074);

SELECT * FROM dividend;
-- Solution
with t1 as 
	(
		select *,
		row_number() over() as rn,
		(fiscal_year % 100) - (row_number() over()) as difference
		from dividend
	),
	t2 as 
	(
		select *, count(*) over(partition by difference) as no_of_records
		from t1
	)
select distinct company as value_stocks from t2 where no_of_records>=3