-- Create a copy of the table to be cleaned
CREATE TABLE netflix_data_clean AS
TABLE netflix_data

-- Check how many rows there are: 8807 rows
SELECT COUNT(*) FROM netflix_data_clean

-- Drop description column since it is irrelevant to analysis
ALTER TABLE netflix_data_clean
DROP COLUMN description

-- Check for duplicates
SELECT
	show_id,
	"type",
	title,
	director,
	"cast",
	country,
	date_added,
	release_year,
	rating,
	duration,
	listed_in,
	COUNT(*) AS duplicates
FROM netflix_data_clean
GROUP BY 
	show_id,
	"type",
	title,
	director,
	"cast",
	country,
	date_added,
	release_year,
	rating,
	duration,
	listed_in
HAVING COUNT(*) > 1

-- Check for NULL values in all columns and handle them accordingly
SELECT * FROM netflix_data_clean WHERE show_id IS NULL;
SELECT * FROM netflix_data_clean WHERE "type" IS NULL;
SELECT * FROM netflix_data_clean WHERE title IS NULL;

/* 
director column has multiple NULL values. TV shows with null values will be replaced with multiple directors since
TV tend to have different directors. Movies with null values will be replaced with unknown.
There are 188 Movies with NULL directors and 2446 TV Show with NULL directors.
*/
SELECT * FROM netflix_data_clean WHERE director IS NULL;

SELECT type, COUNT(*) FROM netflix_data_clean WHERE director IS NULL GROUP BY type

UPDATE netflix_data_clean
SET director = 'Unknown'
WHERE type = 'Movie' AND director IS NULL

UPDATE netflix_data_clean
SET director = 'Multiple Directors'
WHERE type = 'TV Show' AND director IS NULL

-- cast column has 825 rows of NULL values and will be replaced with Unknown
SELECT * FROM netflix_data_clean WHERE "cast" IS NULL;

UPDATE netflix_data_clean
SET "cast" = 'Unknown'
WHERE "cast" IS NULL

-- country column has 831 rows of NULL values and will be replaced with unknown
SELECT * FROM netflix_data_clean WHERE country IS NULL;

UPDATE netflix_data_clean
SET country = 'Unknown'
WHERE country IS NULL

-- date_added column has 10 NULL values and the rows will be removed from dataset
SELECT * FROM netflix_data_clean WHERE date_added IS NULL;
DELETE FROM netflix_data_clean WHERE date_added IS NULL

SELECT * FROM netflix_data_clean WHERE release_year IS NULL;

-- rating column has 4 NULL values and the rows will be removed from dataset
SELECT * FROM netflix_data_clean WHERE rating IS NULL;
DELETE FROM netflix_data_clean WHERE rating IS NULL

-- duration column has 3 NULL values and the rows will be removed from dataset
SELECT * FROM netflix_data_clean WHERE duration IS NULL;
DELETE FROM netflix_data_clean WHERE duration IS NULL

SELECT * FROM netflix_data_clean WHERE listed_in IS NULL;

-- Convert date_added column into date type column
ALTER TABLE netflix_data_clean
ALTER COLUMN date_added TYPE DATE
USING TO_DATE(date_added, 'Month DD, YYYY')
