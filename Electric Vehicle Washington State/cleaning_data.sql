-- Create a copy of the table to be cleaned
CREATE TABLE ev_pop_cleaned AS
SELECT * FROM ev_population

-- Update column names to rid spaces and convert to lowercase
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "VIN (1-10)" TO vin
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Postal Code" TO postal_code
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Model Year" TO model_year
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Electric Vehicle Type" TO ev_type
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Clean Alternative Fuel Vehicle (CAFV) Eligibility" TO cafv_eligibility
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Electric Range" TO electric_range
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Base MSRP" TO base_MSRP
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Legislative District" TO legislative_district
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "DOL Vehicle ID" TO dol_vehicle_id
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Vehicle Location" TO vehicle_loc
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "Electric Utility" TO electric_utility
	
ALTER TABLE ev_pop_cleaned
	RENAME COLUMN "2020 Census Tract" TO census_tract

-- Check for NULLS in each column and update table by removing or updating row with proper value

-- 9 rows have a NULL county, remove rows
SELECT * FROM ev_pop_cleaned WHERE city IS NULL
DELETE FROM ev_pop_cleaned WHERE county IS NULL

-- 2 rows have a NULL electric_range featuring a 2024 Mercedes-Benz S-Class, a quick search revealed that it has an electric range of 46 miles
SELECT * FROM ev_pop_cleaned WHERE electric_range IS NULL
UPDATE ev_pop_cleaned
SET electric_range = 46
WHERE electric_range IS NULL

-- 2 rows have a NULL base_msrp featuring a 2024 Mercedes-Benz S-Class, a quick search revealed that the base msrp is $117,300
SELECT * FROM ev_pop_cleaned WHERE base_msrp IS NULL
UPDATE ev_pop_cleaned
SET base_msrp = 117300
WHERE base_msrp IS NULL

-- 423 rows have a Legislative District as NULL since they are all out Washington State, all rows will be deleted since only WA state will be considered
SELECT * FROM ev_pop_cleaned WHERE legislative_district IS NULL
DELETE FROM ev_pop_cleaned WHERE legislative_district IS NULL

-- 4 rows have vehicle location as NULL, it will be replaced with a string called Unknown
SELECT * FROM ev_pop_cleaned WHERE vehicle_loc IS NULL
UPDATE ev_pop_cleaned
SET vehicle_loc = 'Unknown'
WHERE vehicle_loc IS NULL

-- Check for duplicates using dol_vehicle_id
SELECT
	dol_vehicle_id,
	COUNT(dol_vehicle_id)
FROM ev_pop_cleaned
GROUP BY dol_vehicle_id
HAVING COUNT(dol_vehicle_id) > 1;

-- Update electric_range column to change 0 values with proper values by searching the specific car model
SELECT 
	model_year,
	make,
	model
FROM ev_pop_cleaned
WHERE electric_range = 0
GROUP BY model_year, make, model
ORDER BY make, model, model_year DESC

UPDATE ev_pop_cleaned
SET electric_range = 
		CASE
			WHEN make = 'ACURA' AND model = 'ZDX' THEN 306
			WHEN make = 'AUDI' AND model = 'E-TRON' THEN 226
			WHEN make = 'AUDI' AND model = 'E-TRON GT' THEN 238
			WHEN make = 'AUDI' AND model = 'E-TRON SPORTBACK' THEN 218
			WHEN make = 'AUDI' AND model = 'Q4' THEN 242
			WHEN make = 'AUDI' AND model = 'Q8' THEN 285
			WHEN make = 'AUDI' AND model = 'RS E-TRON GT' THEN 232
			WHEN make = 'AUDI' AND model = 'SQ8' THEN 254
			WHEN make = 'BMW' AND model = 'I3' THEN 153
			WHEN make = 'BMW' AND model = 'I4' THEN 307
			WHEN make = 'BMW' AND model = 'I5' THEN 295
			WHEN make = 'BMW' AND model = 'I7' THEN 318
			WHEN make = 'BMW' AND model = 'IX' THEN 324
			WHEN make = 'CADILLAC' AND model = 'LYRIQ' THEN 314
			WHEN make = 'CHEVROLET' AND model = 'BLAZER EV' THEN 324
			WHEN make = 'CHEVROLET' AND model = 'BOLT EUV' THEN 247
			WHEN make = 'CHEVROLET' AND model = 'BOLT EV' THEN 259
			WHEN make = 'CHEVROLET' AND model = 'EQUINOX EV' THEN 319
			WHEN make = 'CHEVROLET' AND model = 'SILVERADO EV' THEN 440
			WHEN make = 'FIAT' AND model = '500E' THEN 199
			WHEN make = 'FISKER' AND model = 'OCEAN' THEN 360
			WHEN make = 'FORD' AND model = 'F-150' THEN 320
			WHEN make = 'FORD' AND model = 'MUSTANG MACH-E' THEN 312
			WHEN make = 'FORD' AND model = 'TRANSIT' THEN 240
			WHEN make = 'GENESIS' AND model = 'G80' THEN 282
			WHEN make = 'GENESIS' AND model = 'GV60' THEN 248
			WHEN make = 'GENESIS' AND model = 'GV70' THEN 236
			WHEN make = 'GMC' AND model = 'HUMMER EV PICKUP' THEN 279
			WHEN make = 'HONDA' AND model = 'CR-V' THEN 62
			WHEN make = 'HONDA' AND model = 'PROLOGUE' THEN 240
			WHEN make = 'HYUNDAI' AND model = 'IONIQ' THEN 170
			WHEN make = 'HYUNDAI' AND model = 'IONIQ 5' THEN 303
			WHEN make = 'HYUNDAI' AND model = 'IONIQ 5 N' THEN 221
			WHEN make = 'HYUNDAI' AND model = 'IONIQ 6' THEN 270
			WHEN make = 'HYUNDAI' AND model = 'KONA ELECTRIC' THEN 261
			WHEN make = 'JAGUAR' AND model = 'I-PACE' THEN 292
			WHEN make = 'KIA' AND model = 'EV6' THEN 310
			WHEN make = 'KIA' AND model = 'NIRO' THEN 253
			WHEN make = 'KIA' AND model = 'EV9' THEN 304
			WHEN make = 'KIA' AND model = 'SOUL EV' THEN 250
			WHEN make = 'LEXUS' AND model = 'RZ' THEN 220
			WHEN make = 'LUCID' AND model = 'AIR' THEN 516
			WHEN make = 'MAZDA' AND model = 'MX-30' THEN 100
			WHEN make = 'MERCEDES-BENZ' AND (model LIKE 'EQB-CLASS%' OR model LIKE 'EQE-CLASS%' OR model LIKE 'EQS-CLASS%') THEN 223
			WHEN make = 'MERCEDES-BENZ' AND model = 'ESPRINTER' THEN 248
			WHEN make = 'MAZDA' AND model = 'ESPRINTER' THEN 248
			WHEN make = 'MINI' AND model = 'HARDTOP' THEN 114
			WHEN make = 'NISSAN' AND model = 'ARIYA' THEN 289
			WHEN make = 'NISSAN' AND model = 'LEAF' THEN 150
			WHEN make = 'POLESTAR' AND model = 'PS2' THEN 314
			WHEN make = 'PORSCHE' AND model = 'TAYCAN' THEN 246
			WHEN make = 'RAM' AND model = 'PROMASTER 3500' THEN 162
			WHEN make = 'RIVIAN' AND model = 'EDV' THEN 161
			WHEN make = 'RIVIAN' AND model = 'R1S' THEN 410
			WHEN make = 'RIVIAN' AND model = 'R1T' THEN 420
			WHEN make = 'ROLLS-ROYCE' AND model = 'SPECTRE' THEN 260
			WHEN make = 'SUBARU' AND model = 'SOLTERRA' THEN 300
			WHEN make = 'TESLA' AND model = 'CYBERTRUCK' THEN 340
			WHEN make = 'TESLA' AND model = 'MODEL 3' THEN 340
			WHEN make = 'TESLA' AND model = 'MODEL S' THEN 402
			WHEN make = 'TESLA' AND model = 'MODEL X' THEN 326
			WHEN make = 'TESLA' AND model = 'MODEL Y' THEN 308
			WHEN make = 'TOYOTA' AND model = 'BZ4X' THEN 252
			WHEN make = 'VOLKSWAGEN' AND model = 'ID.4' THEN 291
			WHEN make = 'VOLVO' AND model = 'C40' THEN 298
			WHEN make = 'VOLVO' AND model = 'XC40' THEN 293
		END
WHERE electric_range = 0 OR electric_range IS NULL

-- Create 2 new columns for longitude and latitude in ev_pop_cleaned table
ALTER TABLE ev_pop_cleaned
ADD COLUMN long NUMERIC;

ALTER TABLE ev_pop_cleaned
ADD COLUMN lat NUMERIC;

-- Create an empty table with desired columns frpm ev_pop_cleaned table
CREATE TABLE ev_pop_final AS
SELECT
	vin,
	county,
	city,
	postal_code,
	model_year,
	make,
	model,
	ev_type,
	cafv_eligibility,
	electric_range,
	legislative_district,
	electric_utility,
	long,
	lat
FROM ev_pop_cleaned
WITH NO DATA;

-- Extract the coordinates from vehicle_loc column in ev_pop_cleaned and place them into the new table ev_pop_final
INSERT INTO ev_pop_final
SELECT
	vin,
	county,
	city,
	postal_code,
	model_year,
	make,
	model,
	ev_type,
	cafv_eligibility,
	electric_range,
	legislative_district,
	electric_utility,
	SPLIT_PART(coordinates, ' ', 1)::numeric AS long,
	SPLIT_PART(coordinates, ' ', 2)::numeric AS lat
FROM (
	SELECT
		vin,
		county,
		city,
		state,
		postal_code,
		model_year,
		make,
		model,
		ev_type,
		cafv_eligibility,
		electric_range,
		legislative_district,
		electric_utility,
		CASE 
			WHEN vehicle_loc != 'Unknown' THEN TRIM(REGEXP_REPLACE(vehicle_loc, '[^-\d. ]', '', 'g'))
			ELSE NULL
		END AS coordinates
	FROM ev_pop_cleaned
) AS ev_coord_sep

-- Drop ev_pop_cleaned
DROP TABLE ev_pop_cleaned







