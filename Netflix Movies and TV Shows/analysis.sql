-- Which countries produce the most content for Netflix?
SELECT
	country,
	COUNT(*) AS titles_added
FROM netflix_data_clean
WHERE NOT country = 'Unknown'
GROUP BY country
ORDER BY titles_added DESC; 

-- Which countries produce the most content for Netflix? (single countries not multiple)
SELECT
	country,
	COUNT(*) AS titles_added
FROM netflix_data_clean
WHERE NOT country = 'Unknown'
	AND country NOT LIKE '%,%'
GROUP BY country
ORDER BY titles_added DESC

-- How many titles has Netflix added each year
SELECT 
	EXTRACT(YEAR FROM date_added) AS year_added,
	COUNT(*) AS new_titles
FROM netflix_data_clean
GROUP BY EXTRACT(YEAR FROM date_added) 
ORDER BY EXTRACT(YEAR FROM date_added) 

-- Distribution of movies and tv shows by release year
SELECT
	EXTRACT(YEAR FROM date_added) AS year_added,
	"type",
	COUNT(*) AS titles_added
FROM netflix_data_clean
WHERE EXTRACT(YEAR FROM date_added) >= (
	/* Find max year and subtract by 5 to obtain 5 year range*/
	SELECT MAX(EXTRACT(YEAR FROM date_added)) - 5 FROM netflix_data_clean
)
GROUP BY EXTRACT(YEAR FROM date_added), "type"
ORDER BY EXTRACT(YEAR FROM date_added), "type"

-- Distribution between Movies vs. TV shows
SELECT
	"type",
	COUNT(*) AS amt
FROM netflix_data_clean
GROUP BY "type"

-- Distribution of content ratings
SELECT 
	rating,
	COUNT(*) AS amt
FROM netflix_data_clean
GROUP BY rating
ORDER BY amt DESC

-- Show amount of movies/show ratings per country
SELECT
	country,
	rating,
	COUNT(*) title_rating_count
FROM netflix_data_clean
WHERE NOT country = 'Unknown'
	AND country NOT LIKE '%,%'
GROUP BY country, rating
ORDER BY country, title_rating_count DESC

-- Show amount of movie/show ratings per country in a pivot table
WITH rating_per_country AS (
	SELECT
		country,
		rating,
		COUNT(*) title_rating_count
	FROM netflix_data_clean
	WHERE NOT country = 'Unknown'
		AND country NOT LIKE '%,%'
	GROUP BY country, rating
	ORDER BY title_rating_count DESC
)

SELECT 
	country,
	MAX(CASE WHEN rating = 'G' THEN title_rating_count END) AS G,
	MAX(CASE WHEN rating = 'NC-17' THEN title_rating_count END) AS NC_17,
	MAX(CASE WHEN rating = 'NR' THEN title_rating_count END) AS NR,
	MAX(CASE WHEN rating = 'PG' THEN title_rating_count END) AS PG,
	MAX(CASE WHEN rating = 'PG-13' THEN title_rating_count END) AS PG_13,
	MAX(CASE WHEN rating = 'R' THEN title_rating_count END) AS R,
	MAX(CASE WHEN rating = 'TV-14' THEN title_rating_count END) AS TV_14,
	MAX(CASE WHEN rating = 'TV-G' THEN title_rating_count END) AS TV_G,
	MAX(CASE WHEN rating = 'TV-MA' THEN title_rating_count END) AS TV_MA,
	MAX(CASE WHEN rating = 'TV-PG' THEN title_rating_count END) AS TV_PG,
	MAX(CASE WHEN rating = 'TV-Y' THEN title_rating_count END) AS TV_Y,
	MAX(CASE WHEN rating = 'TV-Y7' THEN title_rating_count END) AS TV_Y7,
	MAX(CASE WHEN rating = 'TV-Y7-FV' THEN title_rating_count END) AS TV_Y7_FV,
	MAX(CASE WHEN rating = 'UR' THEN title_rating_count END) AS UR
FROM rating_per_country
GROUP BY country

-- Which countries contribute the most Movies vs. TV shows?
SELECT
	country,
	"type"
FROM netflix_data_clean
WHERE NOT country = 'Unknown'

-- Which directors have directed the most movies on Netflix?
SELECT
	director,
	COUNT(*) AS movies_directed
FROM netflix_data_clean
	WHERE type = 'Movie'
	AND NOT director = 'Unknown'
	AND NOT director = 'Multiple Directors'
GROUP BY director
ORDER BY movies_directed DESC

	
-- How new are the titles being added to Netflix over the last 5 years
SELECT
	EXTRACT(YEAR FROM date_added) AS year_added,
	release_year,
	COUNT(*) AS amt
FROM netflix_data_clean
WHERE EXTRACT(YEAR FROM date_added) > (
	SELECT MAX(EXTRACT(YEAR FROM date_added)) - 5
	FROM netflix_data_clean
)
GROUP BY EXTRACT(YEAR FROM date_added), release_year
ORDER BY year_added, amt DESC



