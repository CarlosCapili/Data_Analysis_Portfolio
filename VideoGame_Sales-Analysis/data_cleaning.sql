-- Process of data cleaning

-- Create a copy of the table for backup
CREATE TABLE vg_sales_copy AS
SELECT *
FROM vg_sales;

-- Create a copy of the backup table to manipulate and clean
CREATE TABLE vg_sales_cleaned AS
SELECT *
FROM vg_sales_copy

-- Drop unnecessary columns (ie. last_update column, has no relevance)
ALTER TABLE vg_sales_cleaned
DROP COLUMN last_update

-- Check for NULL values in any columns
SELECT
	COUNT(*) AS total_rows,
	COUNT(*) FILTER(WHERE title IS NULL) AS null_titles,
	COUNT(*) FILTER(WHERE console IS NULL) AS null_console,
	COUNT(*) FILTER(WHERE genre IS NULL) AS null_genre,
	COUNT(*) FILTER(WHERE publisher IS NULL) AS null_publisher,
	COUNT(*) FILTER(WHERE developer IS NULL) AS null_developer,
	COUNT(*) FILTER(WHERE critic_score IS NULL) AS null_critic_score,
	COUNT(*) FILTER(WHERE total_sales IS NULL) AS null_total_sales,
	COUNT(*) FILTER(WHERE na_sales IS NULL) AS null_na_sales,
	COUNT(*) FILTER(WHERE jp_sales IS NULL) AS null_jp_sales,
	COUNT(*) FILTER(WHERE pal_sales IS NULL) AS null_pal_sales,
	COUNT(*) FILTER(WHERE other_sales IS NULL) AS null_other_sales,
	COUNT(*) FILTER(WHERE release_date IS NULL) AS null_release_date
FROM vg_sales_cleaned

-- Delete rows with no total sales
DELETE FROM vg_sales_cleaned 
WHERE total_sales IS NULL
	OR total_sales = 0;

-- Update the NULL values with appropriate values 
-- NULL developer rows will be replaced with 'Unknown'
-- NULL critic_score will be left as NULL since the rating is not known and replacing with a score of 0 is not accurate
-- NULL sales will be replaced with 0 
-- NULL release_date will be left as NULL since the release_date is not known and replacing it is not accurate
UPDATE vg_sales_cleaned
SET developer = 'Unknown'
WHERE developer IS NULL

UPDATE vg_sales_cleaned
SET na_sales = 0
WHERE na_sales IS NULL

UPDATE vg_sales_cleaned
SET jp_sales = 0
WHERE jp_sales IS NULL

UPDATE vg_sales_cleaned
SET pal_sales = 0
WHERE pal_sales IS NULL

UPDATE vg_sales_cleaned
SET other_sales = 0
WHERE other_sales IS NULL

SELECT *
FROM vg_sales_cleaned










