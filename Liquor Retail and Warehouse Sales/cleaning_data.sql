-- Create working copy of data
CREATE TABLE liquor_sd_clean AS
SELECT * FROM liquor_sales_data

-- Update column names to convert to lowercase and remove of spaces in between words
ALTER TABLE liquor_sd_clean
	RENAME COLUMN "ITEM CODE" TO item_code

ALTER TABLE liquor_sd_clean
	RENAME COLUMN "ITEM DESCRIPTION" TO item_desc

ALTER TABLE liquor_sd_clean
	RENAME COLUMN "ITEM TYPE" TO item_type

ALTER TABLE liquor_sd_clean
	RENAME COLUMN "RETAIL SALES" TO retail_sales

ALTER TABLE liquor_sd_clean
	RENAME COLUMN "RETAIL TRANSFERS" TO retail_trans

ALTER TABLE liquor_sd_clean
	RENAME COLUMN "WAREHOUSE SALES" TO warehouse_sales

--- Add a primary key 
ALTER TABLE liquor_sd_clean
	ADD COLUMN id SERIAL PRIMARY KEY 

-- Remove duplicates
WITH duplicates AS (
	SELECT
		id,
		ROW_NUMBER() OVER(PARTITION BY "year", "month", supplier, item_code, item_desc, item_type ORDER BY item_code) AS row_num
	FROM liquor_sd_clean
)

DELETE FROM liquor_sd_clean
WHERE id IN (
	SELECT id
	FROM duplicates
	WHERE row_num > 1
)

-- Check for NULL values in each column and handle appropriately 
SELECT id, "year" FROM liquor_sd_clean WHERE "year" IS NULL
SELECT id, "month" FROM liquor_sd_clean WHERE "month" IS NULL

SELECT id, supplier FROM liquor_sd_clean WHERE supplier IS NULL
DELETE FROM liquor_sd_clean WHERE supplier IS NULL

SELECT id, item_code FROM liquor_sd_clean WHERE item_code IS NULL
SELECT id, item_desc FROM liquor_sd_clean WHERE item_desc IS NULL

SELECT id, item_type FROM liquor_sd_clean WHERE item_type IS NULL
UPDATE liquor_sd_clean
	SET item_type = 'WINE'
	WHERE id = 96086

SELECT id, retail_sales FROM liquor_sd_clean WHERE retail_sales IS NULL
SELECT id, retail_trans FROM liquor_sd_clean WHERE retail_trans IS NULL
SELECT id, warehouse_sales FROM liquor_sd_clean WHERE warehouse_sales IS NULL

-- Add column to convert the month number column into month names (e.g. 1 for January, 2 for February)
ALTER TABLE liquor_sd_clean
	ADD COLUMN month_name text
UPDATE liquor_sd_clean
	SET month_name = TO_CHAR((DATE '2000-01-01' + (month - 1) * INTERVAL '1 month'), 'Month')

-- Add column for total sales (retail + warehouse sales)
ALTER TABLE liquor_sd_clean
	ADD COLUMN total_sales numeric
UPDATE liquor_sd_clean
	SET total_sales = retail_sales + warehouse_sales

SELECT * FROM liquor_sd_clean 

	
