-- -- What consoles/devices are used?
-- SELECT
-- 	console
-- FROM vg_sales_cleaned
-- GROUP BY console
-- ORDER BY console;

-- -- Who are the various publishers?
-- SELECT 
-- 	publisher
-- FROM vg_sales_cleaned
-- GROUP BY publisher
-- ORDER BY publisher;

-- -- Who are the various developers?
-- SELECT 
-- 	developer
-- FROM vg_sales_cleaned
-- GROUP BY developer
-- ORDER BY developer;

-- -- How many consoles are each game available on?
-- SELECT 
-- 	title,
-- 	COUNT(console) AS console_availability 
-- FROM vg_sales_cleaned
-- GROUP BY title
-- ORDER BY console_availability DESC;

-- -- Show the consoles each game is available on
-- SELECT
-- 	title,
-- 	console
-- FROM vg_sales_cleaned
-- GROUP BY title, console
-- ORDER BY title;

-- -- OVERALL SALES PERFORMANCE 

-- -- What are the total sales of video games per year?
-- SELECT
-- 	EXTRACT(YEAR FROM release_date) AS year,
-- 	SUM(total_sales) AS yearly_total_sales
-- FROM vg_sales_cleaned
-- WHERE release_date IS NOT NULL
-- GROUP BY EXTRACT(YEAR FROM release_date)
-- ORDER BY year;

-- -- What is the best selling title for each release year? (Does not add up sales between consoles ie. PS3/X360/PS4/XOne)
-- WITH best_selling_title AS (
-- 	SELECT
-- 		title,
-- 		total_sales,
-- 		EXTRACT(YEAR FROM release_date) AS release_year,
-- 		publisher,
-- 		developer,
-- 		console,
-- 		ROW_NUMBER() OVER(PARTITION BY EXTRACT(YEAR FROM release_date) ORDER BY total_sales DESC) AS rn
-- 	FROM vg_sales_cleaned
-- 	WHERE release_date IS NOT NULL
-- )

-- SELECT 
-- 	release_year,
-- 	title,
-- 	publisher,
-- 	developer,
-- 	console,
-- 	total_sales
-- FROM best_selling_title
-- WHERE rn = 1

-- -- What is the best selling title for each release year? (Adding up sales on all consoles ie. PS3/X360/PS4/XOne)
-- WITH bestseller_per_year AS (
-- 	SELECT
-- 		EXTRACT(YEAR FROM release_date) AS release_year,
-- 		title,
-- 		publisher,
-- 		developer,
-- 		SUM(total_sales) AS all_time_sales,
-- 		ROW_NUMBER() OVER(PARTITION BY EXTRACT(YEAR FROM release_date) ORDER BY SUM(total_sales) DESC) AS rn
-- 	FROM vg_sales_cleaned
-- 	WHERE EXTRACT(YEAR FROM release_date) IS NOT NULL
-- 	GROUP BY EXTRACT(YEAR FROM release_date), title, publisher, developer
-- )

-- SELECT
-- 	release_year,
-- 	title,
-- 	publisher,
-- 	developer,
-- 	all_time_sales
-- FROM bestseller_per_year
-- WHERE rn =1;

-- -- What are the top 10 best-selling titles sold worldwide? (Total sales of games between consoles) Has the industry grown over time?
-- SELECT
-- 	title,
-- 	MIN(EXTRACT(YEAR FROM release_date)) AS release_year,
-- 	publisher,
-- 	SUM(total_sales) AS sales_ww
-- FROM vg_sales_cleaned
-- GROUP BY title, publisher
-- ORDER BY sales_ww DESC
-- LIMIT 10;

-- -- SALES BY PUBLISHER 

-- -- Which publisher has the highest total sales?
-- SELECT
-- 	publisher,
-- 	SUM(total_sales) AS ptotal_sales
-- FROM vg_sales_cleaned
-- GROUP BY publisher
-- ORDER BY ptotal_sales DESC;

-- -- What are the top-selling games for each publisher
-- WITH top_selling_game AS (	
-- 	SELECT
-- 		publisher,
-- 		title,
-- 		SUM(total_sales) AS total_game_sales,
-- 		ROW_NUMBER() OVER(PARTITION BY publisher ORDER BY SUM(total_sales) DESC) AS rn
-- 	FROM vg_sales_cleaned
-- 	GROUP BY publisher, title
-- )

-- SELECT 
-- 	publisher,
-- 	title,
-- 	total_game_sales
-- FROM top_selling_game
-- WHERE rn = 1
-- ORDER BY total_game_sales DESC;

-- -- Show the total sales of the Call of Duty franchise
-- SELECT
-- 	title,
-- 	developer,
-- 	release_date,
-- 	console,
-- 	total_sales
-- FROM vg_sales_cleaned
-- WHERE title LIKE 'Call of Duty%' 
-- ORDER BY release_date, title, total_sales DESC;

-- -- SALES BY REGION

-- -- How are the sales distributed across different regions?
-- SELECT 
-- 	title,
-- 	console,
-- 	publisher,
-- 	ROUND(na_sales/total_sales, 2) AS na_sales_ratio,
-- 	ROUND(jp_sales/total_sales, 2) AS jp_sales_ratio,
-- 	ROUND(pal_sales/total_sales, 2) AS euro_afr_sales_ratio,
-- 	ROUND(other_sales/total_sales, 2) AS restofworld_sales_ratio
-- FROM vg_sales_cleaned
-- ORDER BY publisher, title;

-- -- For each game display the region with the highest sales
-- WITH sales_per_region AS (
-- 	SELECT
-- 		title,
-- 		publisher,
-- 		SUM(na_sales) AS total_na_sales,
-- 		SUM(jp_sales) AS total_jp_sales,
-- 		SUM(pal_sales) AS total_pal_sales,
-- 		SUM(other_sales) AS total_other_sales
-- 	FROM vg_sales_cleaned
-- 	GROUP BY title, publisher
-- )

-- SELECT 
-- 	title,
-- 	publisher,
-- 	CASE 
-- 		WHEN total_na_sales >= total_jp_sales AND total_na_sales >= total_pal_sales AND total_na_sales >= total_other_sales THEN 'North America'
-- 		WHEN total_jp_sales >= total_na_sales AND total_jp_sales >= total_pal_sales AND total_jp_sales >= total_other_sales THEN 'Japan'
-- 		WHEN total_pal_sales >= total_na_sales AND total_pal_sales >= total_jp_sales AND total_pal_sales >= total_other_sales THEN 'Europe and Africa'
-- 		WHEN total_other_sales >= total_na_sales AND total_other_sales >= total_jp_sales AND total_other_sales >= total_pal_sales THEN 'Rest of World'
-- 		ELSE 'Cannot be determined'
-- 	END AS highest_sale_region
-- FROM sales_per_region

-- -- SALES BY PLATFORM

-- -- What are the total sales by platform?
-- SELECT
-- 	console,
-- 	SUM(total_sales) AS total_platform_sales
-- FROM vg_sales_cleaned
-- GROUP BY console
-- ORDER BY total_platform_sales DESC;

-- -- What is the best selling game per platform?
-- WITH bestseller_platform AS (
-- 	SELECT
-- 		console,
-- 		title,
-- 		publisher,
-- 		total_sales,
-- 		ROW_NUMBER() OVER(PARTITION BY console ORDER BY total_sales DESC) AS rn
-- 	FROM vg_sales_cleaned
-- )

-- SELECT 
-- 	console,
-- 	title,
-- 	publisher,
-- 	total_sales
-- FROM bestseller_platform
-- WHERE rn = 1;

-- -- How have sales on each platform changed over time?
-- SELECT
-- 	EXTRACT(YEAR FROM release_date) AS release_year,
-- 	console,
-- 	SUM(total_sales) AS total_platform_sales
-- FROM vg_sales_cleaned
-- WHERE EXTRACT(YEAR FROM release_date) IS NOT NULL
-- GROUP BY EXTRACT(YEAR FROM release_date), console
-- ORDER BY console, release_year;

-- -- Show the platforms as a percentage of the total sales
-- SELECT
-- 	console,
-- 	ROUND(SUM(total_sales) / (SELECT SUM(total_sales) FROM vg_sales_copy) * 100, 1) AS platform_sales_pct 
-- FROM vg_sales_copy
-- GROUP BY console
-- HAVING ROUND(SUM(total_sales) / (SELECT SUM(total_sales) FROM vg_sales_copy) * 100, 1) IS NOT NULL
-- ORDER BY platform_sales_pct DESC;

-- What platform is popular for each region
SELECT
	console,
	SUM(na_sales) AS total_na_sales,
	SUM(jp_sales) AS total_jp_sales,
	SUM(pal_sales) AS total_pal_sales,
	SUM(other_sales) AS total_other_sales
FROM vg_sales_copy
GROUP BY console
HAVING SUM(na_sales) IS NOT NULL
	AND SUM(jp_sales) IS NOT NULL
	AND SUM(pal_sales) IS NOT NULL
	AND SUM(other_sales) IS NOT NULL
ORDER BY 2 DESC, 3 DESC, 4 DESC, 5 DESC;

-- -- SALES BY GENRE

-- -- What are the total sales by genre?
-- SELECT
-- 	genre,
-- 	SUM(total_sales) AS total_genre_sales
-- FROM vg_sales_cleaned
-- GROUP BY genre;

-- -- How have sales for each genre changed over time?
-- SELECT
-- 	EXTRACT(YEAR FROM release_date) AS release_year,
-- 	genre,
-- 	SUM(total_sales) AS total_genre_sales
-- FROM vg_sales_cleaned
-- WHERE EXTRACT(YEAR FROM release_date) IS NOT NULL
-- GROUP BY EXTRACT(YEAR FROM release_date), genre
-- ORDER BY genre, release_year;

-- -- SALES BY RATINGS

-- -- How do game ratings correlate with sales figures
-- SELECT
-- 	title,
-- 	critic_score,
-- 	SUM(total_sales) AS total_rating_sales
-- FROM vg_sales_cleaned
-- WHERE critic_score IS NOT NULL
-- GROUP BY title, critic_score
-- ORDER BY total_rating_sales DESC;





