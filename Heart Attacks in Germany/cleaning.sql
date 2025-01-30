-- Create copy of table
CREATE TABLE ht_data AS
SELECT * FROM heart_attack_ger

-- Add primary key
ALTER TABLE ht_data
	ADD COLUMN id SERIAL PRIMARY KEY

-- Remove duplicate values
CREATE TEMP TABLE temp_table AS 
SELECT DISTINCT *
FROM ht_data

TRUNCATE ht_data

INSERT INTO ht_data
SELECT *
FROM temp_table

DROP TABLE temp_table

-- Check for missing values and handle accordingly
SELECT
	COUNT(*) FILTER(WHERE "state" IS NULL) AS "state",
	COUNT(*) FILTER(WHERE age_group IS NULL) AS age_group,
	COUNT(*) FILTER(WHERE heart_attack_incidence IS NULL) AS heart_attack_incidence,
	COUNT(*) FILTER(WHERE "year" IS NULL) AS "year",
	COUNT(*) FILTER(WHERE gender IS NULL) AS gender,
	COUNT(*) FILTER(WHERE bmi IS NULL) AS bmi,
	COUNT(*) FILTER(WHERE smoking_status IS NULL) AS smoking_status,
	COUNT(*) FILTER(WHERE alchol_consumption IS NULL) AS alchol_consumption,
	COUNT(*) FILTER(WHERE physical_activity_level IS NULL) AS physical_activity_level,
	COUNT(*) FILTER(WHERE diet_quality IS NULL) AS diet_quality,
	COUNT(*) FILTER(WHERE family_history IS NULL) AS family_history,
	COUNT(*) FILTER(WHERE hypertension IS NULL) AS hypertension,
	COUNT(*) FILTER(WHERE cholesterol_level IS NULL) AS cholesterol_level,
	COUNT(*) FILTER(WHERE diabetes IS NULL) AS diabetes,
	COUNT(*) FILTER(WHERE urban_rural IS NULL) AS urban_rural,
	COUNT(*) FILTER(WHERE socioeconomic_status IS NULL) AS socioeconomic_status,
	COUNT(*) FILTER(WHERE air_pollution_index IS NULL) AS air_pollution_index,
	COUNT(*) FILTER(WHERE stress_level IS NULL) AS stress_level,
	COUNT(*) FILTER(WHERE healthcare_access IS NULL) AS healthcare_access,
	COUNT(*) FILTER(WHERE education_level IS NULL) AS education_level,
	COUNT(*) FILTER(WHERE employment_status IS NULL) AS employment_status,
	COUNT(*) FILTER(WHERE region_heart_attack_rate IS NULL) AS region_heart_attack_rate
FROM ht_data

-- Check for and fix inconsistent formats
SELECT DISTINCT state FROM ht_data 
SELECT DISTINCT age_group FROM ht_data
SELECT DISTINCT gender FROM ht_data
SELECT DISTINCT smoking_status FROM ht_data
SELECT DISTINCT physical_activity_level FROM ht_data
SELECT DISTINCT diet_quality FROM ht_data
SELECT DISTINCT urban_rural FROM ht_data
SELECT DISTINCT socioeconomic_status FROM ht_data
SELECT DISTINCT stress_level FROM ht_data
SELECT DISTINCT healthcare_access FROM ht_data
SELECT DISTINCT education_level FROM ht_data
SELECT DISTINCT employment_status FROM ht_data

-- Validate ranges

-- heart_attack_incidence
SELECT DISTINCT heart_attack_incidence FROM ht_data

-- year
SELECT DISTINCT year FROM ht_data

-- bmi
SELECT MIN(bmi), MAX(bmi) FROM ht_data
SELECT * FROM ht_data WHERE bmi < 18 ORDER BY bmi LIMIT 5

-- alchol_consumption
SELECT * FROM ht_data WHERE alchol_consumption < 0 LIMIT 5

-- family_history
SELECT DISTINCT family_history FROM ht_data

-- hypertension
SELECT DISTINCT hypertension FROM ht_data

--cholesterol_level
SELECT * FROM ht_data WHERE cholesterol_level <= 0 LIMIT 5
DELETE FROM ht_data
WHERE cholesterol_level < 0

-- diabetes
SELECT DISTINCT diabetes FROM ht_data

-- air_pollution_index
SELECT MIN(air_pollution_index), MAX(air_pollution_index) FROM ht_data

-- region_heart_attack_rate
SELECT MIN(region_heart_attack_rate), MAX(region_heart_attack_rate) FROM ht_data 

SELECT * FROM ht_data