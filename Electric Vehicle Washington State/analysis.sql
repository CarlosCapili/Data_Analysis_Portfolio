-- How many registered ev's are there in each county?
SELECT
	county,
	COUNT(*) AS ev_count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ev_pop_final), 2) AS ev_county_pct
FROM ev_pop_final
GROUP BY county
ORDER BY ev_count DESC;

-- How many registered ev's are there in each city?
SELECT
	city,
	COUNT(*) AS ev_count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ev_pop_final), 2) AS ev_city_pct
FROM ev_pop_final
GROUP BY city
ORDER BY ev_count DESC;

-- What brands are found in each county?
SELECT
	county,
	make,
	COUNT(*) AS make_count
FROM ev_pop_final
GROUP BY county, make
ORDER BY county, make_count DESC;

-- What brands are found in each city?
SELECT
	city,
	make,
	COUNT(*) AS make_count
FROM ev_pop_final
GROUP BY city, make
ORDER BY city, make_count DESC;

-- What car make is the most registered in each city?
WITH car_make_count AS (
	SELECT
		city,
		make,
		COUNT(*) AS make_count,
		DENSE_RANK() OVER(PARTITION BY city ORDER BY COUNT(*) DESC) AS rn
	FROM ev_pop_final
	GROUP BY city, make
)

SELECT
	city,
	make
FROM car_make_count
WHERE rn = 1

-- How many cities are the most used brands used in?
WITH car_make_count AS (
	SELECT
		city,
		make,
		COUNT(*) AS make_count,
		DENSE_RANK() OVER(PARTITION BY city ORDER BY COUNT(*) DESC) AS rn
	FROM ev_pop_final
	GROUP BY city, make
)

SELECT 
	make,
	COUNT(city) AS city_count,
	ROUND(COUNT(city) * 100.0 / (SELECT COUNT(DISTINCT city) FROM ev_pop_final), 2) AS city_pct
FROM car_make_count
WHERE rn = 1
GROUP BY make
ORDER BY city_count DESC;

-- What is the most popular make of ev in Washington State?
SELECT
	make,
	COUNT(*) AS make_count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ev_pop_final), 2) AS make_pct
FROM ev_pop_final
GROUP BY make
ORDER BY make_count DESC;

-- What are the top 10 common ev models that are registered in Washington State?
WITH ranked_ev_models AS (
	SELECT
		model,
		COUNT(*) AS model_count,
		ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ev_pop_final), 2) AS model_pct,
		DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS dr
	FROM ev_pop_final
	GROUP BY model
	ORDER BY model_count DESC
)

SELECT
	CASE WHEN dr <= 10 THEN model ELSE 'OTHER' END AS model,
	CASE WHEN dr <= 10 THEN model_count ELSE (SELECT SUM(model_count) FROM ranked_ev_models WHERE dr > 10) END AS model_count,
	CASE WHEN dr <= 10 THEN model_pct ELSE (SELECT SUM(model_pct) FROM ranked_ev_models WHERE dr > 10) END AS model_pct
FROM ranked_ev_models
LIMIT 11

-- What is the breakdown of ev_types?
SELECT
	ev_type,
	COUNT(*) AS ev_type_count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ev_pop_final), 2) AS ev_type_pct
FROM ev_pop_final
GROUP BY ev_type
ORDER BY ev_type_count DESC;

-- What are the top 10 car make for ev_type Battery Electric Vehicle (BEV)?
SELECT 
	model_year,
	make,
	model,
	COUNT(*) AS car_count
FROM ev_pop_final
WHERE ev_type = 'Battery Electric Vehicle (BEV)'
GROUP BY model_year, make, model
ORDER BY car_count DESC
LIMIT 10;

-- What are the top 10 car make for ev_type Plug-in Hybrid Electric Vehicle (PHEV)?
SELECT 
	model_year,
	make,
	model,
	COUNT(*) AS car_count
FROM ev_pop_final
WHERE ev_type = 'Plug-in Hybrid Electric Vehicle (PHEV)'
GROUP BY model_year, make, model
ORDER BY car_count DESC
LIMIT 10;

-- What are the top 10 vehicles with the best electric_range?
SELECT DISTINCT
	model_year,
	make,
	model,
	electric_range
FROM ev_pop_final
ORDER BY electric_range DESC
LIMIT 10;








