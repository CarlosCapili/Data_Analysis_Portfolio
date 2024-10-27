-- SALES PIPELINE TABLE CLEANING --------------------
SELECT * FROM sales_pipeline

-- Check for missing values
SELECT * FROM sales_pipeline WHERE opportunity_id IS NULL
SELECT * FROM sales_pipeline WHERE sales_agent IS NULL
SELECT * FROM sales_pipeline WHERE product IS NULL

-- Replace NULL values in account column with 'Searching' string
SELECT * FROM sales_pipeline WHERE account IS NULL
UPDATE sales_pipeline SET account = 'Searching' WHERE account IS NULL 

SELECT * FROM sales_pipeline WHERE deal_stage IS NULL

-- Do not replace the NULL values in date columns and in close_value column indicating values have not been established/finalized
SELECT * FROM sales_pipeline WHERE engage_date IS NULL
SELECT * FROM sales_pipeline WHERE close_date IS NULL
SELECT * FROM sales_pipeline WHERE close_value IS NULL

-- ACCOUNTS TABLE CLEANING
SELECT * FROM accounts

-- Correct spelling mistakes in sector column
SELECT DISTINCT sector FROM accounts
UPDATE accounts
SET sector = 'technology'
WHERE sector = 'technolgy'

-- PRODUCTS TABLE CLEANING
SELECT * FROM products

-- SALES TEAM CLEANING
SELECT * FROM sales_team