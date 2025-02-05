-- State comparisons

-- Which state experiences more heart attacks?
SELECT
	"state",
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
GROUP BY "state"
ORDER BY heart_attack_pct DESC

-- Health conditions per state
SELECT
	"state",
	ROUND(AVG(alchol_consumption), 2) AS avg_alcohol_consumption,
	ROUND(AVG(cholesterol_level), 2) AS avg_cholesterol,
	ROUND(AVG(air_pollution_index), 2) AS avg_air_poll_index,
	ROUND(AVG(region_heart_attack_rate), 2) AS avg_reg_ht_rate,
	MAX(alchol_consumption) AS highest_alcohol_cons_lvl,
	MAX(cholesterol_level) AS highest_recorded_chol_lvl,
	MAX(air_pollution_index) AS highest_pollution_index_lvl,
	MAX(region_heart_attack_rate) AS highest_heart_attack_rate_lvl
FROM ht_data
GROUP BY "state"
ORDER BY "state"

-- Urban rural comparison
SELECT 
	urban_rural,
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
GROUP BY urban_rural
ORDER BY heart_attack_pct DESC 

-- What is the percentage of urban and rural areas that experienced heart attacks
SELECT
	urban_rural,
	COUNT(*) AS total_heart_attacks,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ht_data WHERE heart_attack_incidence = 1), 2) AS age_group_pct
FROM ht_data
WHERE heart_attack_incidence = 1
GROUP BY urban_rural

-- Gender trends

-- Which gender experiences more heart attacks?
SELECT
	gender,
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
WHERE gender IN ('Male', 'Female')
GROUP BY gender

-- What is the percentage of adults and youths that experienced heart attacks
SELECT
	gender,
	COUNT(*) AS total_heart_attacks,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ht_data WHERE heart_attack_incidence = 1 AND gender IN ('Male', 'Female')), 2) AS age_group_pct
FROM ht_data
WHERE heart_attack_incidence = 1
	AND gender IN ('Male', 'Female')
GROUP BY gender

-- Age group comparisons

-- Which age group experiences more heart attacks
SELECT 
	age_group,
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
GROUP BY age_group
ORDER BY heart_attack_pct DESC

-- What is the percentage of adults and youths that experienced heart attacks
SELECT
	age_group,
	COUNT(*) AS total_heart_attacks,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ht_data WHERE heart_attack_incidence = 1), 2) AS age_group_pct
FROM ht_data
WHERE heart_attack_incidence = 1
GROUP BY age_group

-- Yearly comparisons

-- Heart attack incidences per year
SELECT 
	"year",
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
GROUP BY "year"
ORDER BY "year"

-- What is the heart attack incidence trend for each state per year?
SELECT
	"state",
	"year",
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
GROUP BY "state", "year"
ORDER BY "state", "year"

-- What is the heart attack incidence trend by gender per year?
SELECT
	gender,
	"year",
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
WHERE NOT gender = 'Other' 
GROUP BY gender, "year"
ORDER BY gender, "year"

-- What is the heart attack incidence trend by age_group per year?
SELECT
	age_group,
	"year",
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
GROUP BY age_group, "year"
ORDER BY age_group, "year"

-- Risk factors

-- How does physical activity leveL, stress level affect heart attack incidences?
SELECT
	physical_activity_level,
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
GROUP BY physical_activity_level
ORDER BY heart_attack_pct DESC

-- What is the percentage of people with heart attack incidence that have a family_history, hypertension, diabetes
SELECT
	ROUND((COUNT(*) FILTER(WHERE family_history = 1)) * 100.0 / COUNT(*) , 1) AS family_hist_pct,
	ROUND((COUNT(*) FILTER(WHERE hypertension = 1)) * 100.0 / COUNT(*), 1) AS hypertension_pct,
	ROUND((COUNT(*) FILTER(WHERE diabetes = 1)) * 100.0 / COUNT(*), 1) AS diabetes_pct
FROM ht_data
WHERE heart_attack_incidence = 1 

-- The people who experienced heart attacks, how many are smokers and non smokers?
SELECT
	smoking_status,
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data	
GROUP BY smoking_status
ORDER BY heart_attack_pct DESC

-- How does diet quality affect heart attack incidence 
SELECT
	ROUND(COUNT(*) FILTER(WHERE diet_quality = 'Poor') * 100.0 / COUNT(*), 1) AS dq_poor,
	ROUND(COUNT(*) FILTER(WHERE diet_quality = 'Average') * 100.0 / COUNT(*), 1) AS dq_avg,
	ROUND(COUNT(*) FILTER(WHERE diet_quality = 'Good') * 100.0 / COUNT(*), 1) AS dq_good
FROM ht_data
WHERE heart_attack_incidence = 1

SELECT
	diet_quality,
	SUM(heart_attack_incidence) AS total_heart_attacks,
	COUNT(*) AS total_records,
	ROUND(SUM(heart_attack_incidence) * 100.0 / COUNT(*), 2) AS heart_attack_pct
FROM ht_data
GROUP BY diet_quality

