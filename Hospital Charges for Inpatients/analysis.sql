-- What are the 10 most common DRG?
SELECT 
	drg_def,
	COUNT(*) AS diagnosis_count
FROM working_data
GROUP BY drg_def
ORDER BY diagnosis_count DESC
LIMIT 10;

-- Which state has the most providers?
SELECT
	prov_state,
	COUNT(*) AS prov_count
FROM working_data
GROUP BY prov_state
ORDER BY prov_count DESC

-- What is the mean covered charges for all DRGs in across states?
SELECT
	prov_state,
	ROUND(AVG(avg_cov_chrgs)::numeric, 2) AS mean_cov_chrgs
FROM working_data
GROUP BY prov_state
ORDER BY mean_cov_chrgs DESC;

-- What is the mean total payments for all procedures in across states?
SELECT
	prov_state,
	ROUND(AVG(avg_tot_pymts)::numeric, 2) AS mean_tot_pymts
FROM working_data
GROUP BY prov_state
ORDER BY mean_tot_pymts DESC;

-- What is the mean covered charges for 194 - SIMPLE PNEUMONIA & PLEURISY W CC across states?
SELECT
	prov_state,
	ROUND(AVG(avg_cov_chrgs)::numeric, 2) AS mean_cov_chrgs
FROM working_data
WHERE drg_def = '194 - SIMPLE PNEUMONIA & PLEURISY W CC'
GROUP BY prov_state
ORDER BY mean_cov_chrgs DESC

-- What is the mean covered charges for 690 - KIDNEY & URINARY TRACT INFECTIONS W/O MCC across states?
SELECT
	prov_state,
	ROUND(AVG(avg_cov_chrgs)::numeric, 2) AS mean_cov_chrgs
FROM working_data
WHERE drg_def = '690 - KIDNEY & URINARY TRACT INFECTIONS W/O MCC'
GROUP BY prov_state
ORDER BY mean_cov_chrgs DESC

-- What is the most expensive and least expensive state mean cover charges for each DRG?
WITH state_charges AS (
	SELECT
		drg_def,
		prov_state,
		ROUND(AVG(avg_cov_chrgs)::numeric, 2) AS mean_cov_chrgs,
		DENSE_RANK() OVER(PARTITION BY drg_def ORDER BY ROUND(AVG(avg_cov_chrgs)::numeric, 2) DESC) AS dr_most,
		DENSE_RANK() OVER(PARTITION BY drg_def ORDER BY ROUND(AVG(avg_cov_chrgs)::numeric, 2)) AS dr_least
	FROM working_data
	GROUP BY drg_def, prov_state
)

SELECT 
	drg_def,
	MAX(CASE WHEN dr_most = 1 THEN prov_state END) AS highest_cover_chrg_state,
	MAX(CASE WHEN dr_most = 1 THEN mean_cov_chrgs END) AS highest_cover_chrg,
	MAX(CASE WHEN dr_least = 1 THEN prov_state END) AS lowest_cover_chrg_state,
	MAX(CASE WHEN dr_least = 1 THEN mean_cov_chrgs END) AS lowest_cover_chrg
FROM state_charges
GROUP BY drg_def

-- How do different states compare to average charges and payments?
SELECT
	prov_state,
	drg_def,
	ROUND(AVG(avg_cov_chrgs)::numeric, 2) AS state_avg_cov_chrgs,
	ROUND(AVG(avg_tot_pymts)::numeric, 2) AS state_avg_tot_pymts,
	ROUND(AVG(avg_med_pymts)::numeric, 2) AS state_avg_med_pymts
FROM working_data
GROUP BY prov_state, drg_def
ORDER BY drg_def, prov_state 

-- What are the average charges and payments in each referral region for a given DRG?
SELECT
	referral_region,
	drg_def,
	ROUND(AVG(avg_cov_chrgs)::numeric) AS region_cov_chrgs,
	ROUND(AVG(avg_tot_pymts)::numeric) AS region_tot_pymts,
	ROUND(AVG(avg_med_pymts)::numeric) AS region_med_pymts
FROM working_data
GROUP BY referral_region, drg_def
ORDER BY referral_region, region_cov_chrgs DESC;

