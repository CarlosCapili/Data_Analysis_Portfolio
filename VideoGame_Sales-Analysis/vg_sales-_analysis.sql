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
-- 	title,
-- 	total_sales,
-- 	EXTRACT(YEAR FROM release_date) AS release_year,
-- 	publisher,
-- 	developer,
-- 	console
-- FROM best_selling_title
-- WHERE rn = 1

-- Which titles sold the most worldwide? (Total sales of games between consoles) Has the industry grown over time?
SELECT
	title,
	MIN(EXTRACT(YEAR FROM release_date)) AS release_year,
	publisher,
	developer,
	SUM(total_sales) AS sales_ww
FROM vg_sales
WHERE total_sales IS NOT NULL
GROUP BY title, publisher, developer
ORDER BY sales_ww DESC;

-- Which franchise is the most sold worldwide?

-- Which year had the highest sales?

-- What titles are popular in one region but flop in another

-- Top Rockstar Games games based on sales

-- What is Call of Duty has the highest sales from Activision and who is the developer?


-- SELECT *
-- FROM vg_sales
