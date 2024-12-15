-- Create copy of table
CREATE TABLE consumer_clean AS
SELECT * FROM consumer_data

-- Rename columns
ALTER TABLE consumer_clean
	RENAME COLUMN "Customer ID" TO customer_id

ALTER TABLE consumer_clean
	RENAME COLUMN "Item Purchased" TO item_purchased

ALTER TABLE consumer_clean
	RENAME COLUMN "Purchase Amount (USD)" TO purchase_amt_usd

ALTER TABLE consumer_clean
	RENAME COLUMN "Review Rating" TO review_rating

ALTER TABLE consumer_clean
	RENAME COLUMN "Subscription Status" TO subscription_status

ALTER TABLE consumer_clean
	RENAME COLUMN "Payment Method" TO payment_method

ALTER TABLE consumer_clean
	RENAME COLUMN "Shipping Type" TO shipping_type

ALTER TABLE consumer_clean
	RENAME COLUMN "Discount Applied" TO discount_applied

ALTER TABLE consumer_clean
	RENAME COLUMN "Promo Code Used" TO promo_code_used

ALTER TABLE consumer_clean
	RENAME COLUMN "Previous Purchases" TO prev_purchases

ALTER TABLE consumer_clean
	RENAME COLUMN "Preferred Payment Method" TO pref_payment_method

ALTER TABLE consumer_clean
	RENAME COLUMN "Frequency of Purchases" TO freq_of_purchases
	
-- Remove duplicates
WITH duplicates AS (
	SELECT
		customer_id,
		ROW_NUMBER() OVER(PARTITION BY 
						  age, gender, item_purchased, category, purchase_amt_usd, location, size,
						  color, season, review_rating, subscription_status, payment_method, discount_applied,
						  promo_code_used, prev_purchases, pref_payment_method, freq_of_purchases
						  ORDER BY customer_id
						 ) AS row_num
	FROM consumer_clean
)

DELETE FROM consumer_clean
WHERE customer_id IN (
	SELECT customer_id
	FROM duplicates
	WHERE row_num > 1
)

-- Check and handle missing values if necessary
SELECT * FROM consumer_clean WHERE age IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE gender IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE item_purchased IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE category IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE purchase_amt_usd IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE location IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE size IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE color IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE season IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE review_rating IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE subscription_status IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE payment_method IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE shipping_type IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE discount_applied IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE promo_code_used IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE prev_purchases IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE pref_payment_method IS NULL LIMIT 5
SELECT * FROM consumer_clean WHERE freq_of_purchases IS NULL LIMIT 5

-- Check and standardize text columns if necessary
SELECT DISTINCT gender FROM consumer_clean 
SELECT DISTINCT item_purchased FROM consumer_clean 
SELECT DISTINCT category FROM consumer_clean
SELECT DISTINCT location FROM consumer_clean
SELECT DISTINCT size FROM consumer_clean
SELECT DISTINCT color FROM consumer_clean
SELECT DISTINCT season FROM consumer_clean
SELECT DISTINCT payment_method FROM consumer_clean
SELECT DISTINCT shipping_type FROM consumer_clean
SELECT DISTINCT pref_payment_method FROM consumer_clean
SELECT DISTINCT freq_of_purchases FROM consumer_clean

-- Validate Ranges
SELECT MIN(age), MAX(age) FROM consumer_clean
SELECT MIN(purchase_amt_usd), MAX(purchase_amt_usd) FROM consumer_clean
SELECT MIN(review_rating), MAX(review_rating) FROM consumer_clean
SELECT MIN(prev_purchases), MAX(prev_purchases) FROM consumer_clean

-- Add age_group column
ALTER TABLE consumer_clean
	ADD COLUMN age_group text
UPDATE consumer_clean
	SET age_group  = (
		CASE 
			WHEN age < 25 THEN '18-24'
			WHEN age BETWEEN 25 AND 34 THEN '25-34'
			WHEN age BETWEEN 35 AND 44 THEN '35-44'
			WHEN age BETWEEN 45 AND 54 THEN '45-54'
			WHEN age BETWEEN 55 AND 64 THEN '55-64'
			WHEN age >= 65 THEN '65+'
		END
	)
		