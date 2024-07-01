-- What consoles/devices are used?
-- SELECT
-- 	console
-- FROM vg_sales
-- GROUP BY console
-- ORDER BY console;

-- Who are the various publishers?
-- SELECT 
-- 	publisher
-- FROM vg_sales
-- GROUP BY publisher
-- ORDER BY publisher;

-- Who are the various developers?
-- SELECT 
-- 	developer
-- FROM vg_sales
-- GROUP BY developer
-- ORDER BY developer;

-- How many consoles are each game available on?
-- SELECT 
-- 	title,
-- 	COUNT(console) AS console_availability 
-- FROM vg_sales
-- GROUP BY title
-- ORDER BY console_availability DESC;

-- Show the consoles each game is available on
-- SELECT
-- 	title,
-- 	console
-- FROM vg_sales
-- GROUP BY title, console
-- ORDER BY title;

-- OVERALL SALES PERFORMANCE 

-- What are the total sales of video games per year?
-- SELECT
-- 	EXTRACT(YEAR FROM release_date) AS year,
-- 	SUM(total_sales) AS yearly_total_sales
-- FROM vg_sales
-- WHERE release_date IS NOT NULL
-- 	AND total_sales IS NOT NULL
-- GROUP BY EXTRACT(YEAR FROM release_date)
-- ORDER BY year;

-- What is the highest sold title for each release year? (Does not add up sales between consoles ie. PS3/X360/PS4/XOne)
-- WITH best_selling_title AS (
-- 	SELECT
-- 		title,
-- 		total_sales,
-- 		release_date,
-- 		publisher,
-- 		developer,
-- 		console,
-- 		ROW_NUMBER() OVER(PARTITION BY DATE_TRUNC('year', release_date) ORDER BY total_sales DESC) AS rn
-- 	FROM vg_sales
-- 	WHERE total_sales IS NOT NULL
-- 		AND release_date IS NOT NULL
-- )

-- SELECT 
-- 	EXTRACT(YEAR FROM release_date) AS release_year,
-- 	title,
-- 	publisher,
-- 	developer,
-- 	console,
-- 	total_sales
-- FROM best_selling_title
-- WHERE rn = 1

-- What are the top 10 best-selling titles sold worldwide? (Total sales of games between consoles) Has the industry grown over time?
-- SELECT
-- 	title,
-- 	MIN(EXTRACT(YEAR FROM release_date)) AS release_year,
-- 	publisher,
-- 	developer,
-- 	SUM(total_sales) AS sales_ww
-- FROM vg_sales
-- WHERE total_sales IS NOT NULL
-- GROUP BY title, publisher, developer
-- ORDER BY sales_ww DESC
-- LIMIT 10;

-- Which franchise is the most sold worldwide?

-- Which publisher has the highest total sales?
-- SELECT
-- 	publisher,
-- 	SUM(total_sales) AS ptotal_sales
-- FROM vg_sales
-- WHERE total_sales IS NOT NULL
-- GROUP BY publisher
-- ORDER BY ptotal_sales DESC;

-- What are the top-selling games for each publisher
WITH top_selling_game AS (	
	SELECT
		publisher,
		title,
		SUM(total_sales) AS total_game_sales,
		ROW_NUMBER() OVER(PARTITION BY publisher ORDER BY SUM(total_sales) DESC) AS rn
	FROM vg_sales
	WHERE total_sales IS NOT NULL
	GROUP BY publisher, title
)

SELECT 
	publisher,
	title,
	total_game_sales
FROM top_selling_game
WHERE rn = 1
ORDER BY total_game_sales DESC;

-- Show the total sales of the Call of Duty franchise
-- SELECT
-- 	title,
-- 	developer,
-- 	release_date,
-- 	console,
-- 	total_sales
-- FROM vg_sales
-- WHERE title LIKE 'Call of Duty%' 
-- 	AND total_sales IS NOT NULL
-- ORDER BY release_date, title, total_sales DESC;



-- Which year had the highest sales?

-- What titles are popular in one region but flop in another

-- Top Rockstar Games games based on sales

-- What is Call of Duty has the highest sales from Activision and who is the developer?


-- SELECT *
-- FROM vg_sales
