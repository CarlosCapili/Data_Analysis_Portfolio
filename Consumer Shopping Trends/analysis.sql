-- General Statistics 

What are the total number of purchases?
SELECT 
	COUNT(*) AS total_purchases
FROM consumer_clean

-- What is the average purchase amount?
SELECT 
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean

-- What are the min and max purchase amounts?
SELECT
	MIN(purchase_amt_usd) AS min_purchase,
	MAX(purchase_amt_usd) AS max_purchase
FROM consumer_clean

-- Customer Demographics

-- What is the age distribution of customers?
SELECT 
	age_group, 
	COUNT(*) AS age_group_count
FROM consumer_clean
GROUP BY age_group
ORDER BY age_group

--  What is the gender breakdown of customers?
SELECT 
	gender,
	COUNT(*) AS gender_count
FROM consumer_clean
GROUP BY gender

-- Which location has the highest number of purchases?
SELECT
	location,
	COUNT(*) AS location_purchases
FROM consumer_clean
GROUP BY location
ORDER BY location_purchases DESC

-- Customer Segmentation 

-- Average purchase amount by gender
SELECT
	gender,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
GROUP BY gender

-- Average spending per age group 
SELECT
	age_group,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
GROUP BY age_group
ORDER BY age_group

-- What is the average purchase amount by age group and gender
SELECT 
	age_group,
	gender,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
GROUP BY age_group, gender
ORDER BY age_group, gender

-- Which age group spends the most on average in each category
SELECT
	category,
	age_group,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
GROUP BY category, age_group
ORDER BY category, avg_purchase_amt DESC

-- Purchase Behaviour

-- Which categories or items are most popular?
SELECT 
	category,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt,
	ROUND(SUM(purchase_amt_usd), 2) AS total_purchase_amt
FROM consumer_clean
GROUP BY category
ORDER BY total_purchase_amt DESC

-- What are the top 10 items consumers spend their money on?
SELECT 
	category,
	item_purchased,
	ROUND(SUM(purchase_amt_usd), 2) AS total_purchase_amt,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
GROUP BY category, item_purchased
ORDER BY total_purchase_amt DESC
LIMIT 10

-- What are the age group and gender spending breakdown for Blouses, Dresses, and Jewelry?
SELECT 
	age_group,
	gender,
	item_purchased,
	ROUND(SUM(purchase_amt_usd), 2) AS total_purchase_amt,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
WHERE 
	item_purchased IN ('Blouse', 'Dress', 'Jewelry')
GROUP BY age_group, gender, item_purchased
ORDER BY age_group, item_purchased, gender

-- What is the total spending for each item per category
SELECT
	category,
	item_purchased,
	ROUND(SUM(purchase_amt_usd), 2) AS total_purchase_amt
FROM consumer_clean
GROUP BY category, item_purchased
ORDER BY category, total_purchase_amt DESC

-- What items are consumers spending there money on per age group? 
SELECT
	category,
	age_group,
	item_purchased,
	ROUND(SUM(purchase_amt_usd), 2) AS total_purchase_amt,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
GROUP BY category, age_group, item_purchased
ORDER BY category, age_group, total_purchase_amt DESC

-- Seasonal Trends

-- What is the average and total purchase amount by season?
SELECT 
	season,
	SUM(purchase_amt_usd) AS total_purchase_amt,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
GROUP BY season
ORDER BY total_purchase_amt DESC

-- What items are commonly purchased in each season? (Top 5 ranked purchased items)
WITH common_item_season AS
(
	SELECT 
		season,
		item_purchased,
		COUNT(*) AS item_purchased_count,
		SUM(purchase_amt_usd) AS total_purchase_amt,
		DENSE_RANK() OVER(PARTITION BY season ORDER BY COUNT(*) DESC) AS dr 
	FROM consumer_clean
	GROUP BY season, item_purchased
)

SELECT 
	season,
	item_purchased,
	item_purchased_count,
	total_purchase_amt,
	dr
FROM common_item_season
WHERE dr <= 5

Which shipping type is most popular during each season?
SELECT
	season,
	shipping_type,
	COUNT(*) AS shipping_type_count
FROM consumer_clean
GROUP BY season, shipping_type
ORDER BY season, shipping_type_count DESC

-- Discounts and Promo Code Usage

-- How many purchases used a promo code?
WITH code_used AS 
(
	SELECT
		promo_code_used,
		COUNT(*) AS num_purchases
	FROM consumer_clean
	GROUP BY promo_code_used
)

SELECT
	promo_code_used,
	num_purchases,
	ROUND(num_purchases * 100.0 / (SELECT COUNT(*) FROM consumer_clean), 2) AS pct
FROM code_used

-- What categories use the most promo codes during purchase?
SELECT
	category,
	COUNT(*) AS promo_code_used_count
FROM consumer_clean
WHERE promo_code_used = 'Yes'
GROUP BY category
ORDER BY promo_code_used_count DESC

-- What items in each cateogry use the most promo codes during purchase?
SELECT
	category,
	item_purchased,
	COUNT(*) AS promo_code_used_count
FROM consumer_clean
WHERE promo_code_used = 'Yes'
GROUP BY category, item_purchased
ORDER BY category, promo_code_used_count DESC

-- What is the average discount purchase by season?
SELECT
	season,
	discount_applied,
	ROUND(AVG(purchase_amt_usd), 2) AS avg_purchase_amt
FROM consumer_clean
GROUP BY season, discount_applied
ORDER BY season, discount_applied

-- Payment and Preferences

-- What is the preferred payment method per age group?
SELECT 
	age_group,
	pref_payment_method,
	COUNT(*) AS payment_method_count
FROM consumer_clean
GROUP BY age_group, pref_payment_method
ORDER BY age_group, payment_method_count DESC
