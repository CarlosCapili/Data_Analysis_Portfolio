-- Create a copy of the inpatient_charges table to modify
CREATE TABLE working_data AS
SELECT * FROM inpatient_charges

-- Rename rows
ALTER TABLE working_data
	RENAME COLUMN "DRG Definition" TO drg_def
	
ALTER TABLE working_data
	RENAME COLUMN "Provider Id" TO prov_id

ALTER TABLE working_data
	RENAME COLUMN "Provider Name" TO prov_name
	
ALTER TABLE working_data
	RENAME COLUMN "Provider Street Address" TO prov_addr

ALTER TABLE working_data
	RENAME COLUMN "Provider City" TO prov_city

ALTER TABLE working_data
	RENAME COLUMN "Provider State" TO prov_state

ALTER TABLE working_data
	RENAME COLUMN "Provider Zip" TO prov_zip

ALTER TABLE working_data
	RENAME COLUMN "Hospital Referral Region Description" TO referral_region

ALTER TABLE working_data
	RENAME COLUMN "Total Discharges" TO total_discharges

ALTER TABLE working_data
	RENAME COLUMN "Average Covered Charges" TO avg_cov_chrgs
	
ALTER TABLE working_data
	RENAME COLUMN "Average Total Payments" TO avg_tot_pymts

ALTER TABLE working_data
	RENAME COLUMN "Average Medicare Payments" TO avg_med_pymts

-- Find duplicates and delete when found
SELECT
	drg_def,
	prov_id,
	prov_name,
	prov_city,
	prov_state
	prov_zip,
	referral_region,
	total_discharges,
	avg_cov_chrgs,
	avg_tot_pymts,
	avg_med_chrgs,
	COUNT(*)
FROM working_data
GROUP BY 	
	drg_def,
	prov_id,
	prov_name,
	prov_city,
	prov_state,
	prov_zip,
	referral_region,
	total_discharges,
	avg_cov_chrgs,
	avg_tot_pymts,
	avg_med_chrgs
HAVING COUNT(*) > 1

-- Check for NULL values and handle accordingly
SELECT * FROM working_data WHERE drg_def IS NULL
SELECT * FROM working_data WHERE prov_id IS NULL
SELECT * FROM working_data WHERE prov_name IS NULL
SELECT * FROM working_data WHERE prov_addr IS NULL
SELECT * FROM working_data WHERE prov_city IS NULL
SELECT * FROM working_data WHERE prov_state IS NULL
SELECT * FROM working_data WHERE prov_zip IS NULL
SELECT * FROM working_data WHERE referral_region IS NULL
SELECT * FROM working_data WHERE total_discharges IS NULL
SELECT * FROM working_data WHERE avg_cov_chrgs IS NULL
SELECT * FROM working_data WHERE avg_tot_pymts IS NULL
SELECT * FROM working_data WHERE avg_med_chrgs IS NULL

-- Remove $ from charges/payments columns and convert to numeric 
UPDATE working_data SET avg_cov_chrgs = LTRIM(avg_cov_chrgs, '$')
UPDATE working_data SET avg_tot_pymts = LTRIM(avg_tot_pymts, '$')
UPDATE working_data SET avg_med_chrgs = LTRIM(avg_med_chrgs, '$')

ALTER TABLE working_data
ALTER COLUMN avg_cov_chrgs TYPE double precision
USING avg_cov_chrgs::double precision

ALTER TABLE working_data
ALTER COLUMN avg_tot_pymts TYPE double precision
USING avg_tot_pymts::double precision

ALTER TABLE working_data
ALTER COLUMN avg_med_chrgs TYPE double precision
USING avg_med_chrgs::double precision