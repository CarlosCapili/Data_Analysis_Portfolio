-- Create a copy of the data to manipulate and clean
CREATE TABlE nba_data_cleaned AS
SELECT *
FROM nba_data;

-- Check for NULL values in each column
SELECT
	COUNT(*) AS total_rows,
	COUNT(*) FILTER(WHERE player_id IS NULL) AS null_player_id,
	COUNT(*) FILTER(WHERE player_name IS NULL) AS null_player_name,
	COUNT(*) FILTER(WHERE team_abbrev IS NULL) AS null_team_abbrev,
	COUNT(*) FILTER(WHERE player_age IS NULL) AS null_player_age,
	COUNT(*) FILTER(WHERE player_height IS NULL) AS null_player_height,
	COUNT(*) FILTER(WHERE player_weight IS NULL) AS null_player_weight,
	COUNT(*) FILTER(WHERE college IS NULL) AS null_college,
	COUNT(*) FILTER(WHERE country IS NULL) AS null_country,
	COUNT(*) FILTER(WHERE draft_year IS NULL) AS null_draft_year,
	COUNT(*) FILTER(WHERE draft_round IS NULL) AS null_draft_round,
	COUNT(*) FILTER(WHERE draft_num IS NULL) AS null_draft_num,
	COUNT(*) FILTER(WHERE gp IS NULL) AS null_gp,
	COUNT(*) FILTER(WHERE pts IS NULL) AS null_pts,
	COUNT(*) FILTER(WHERE reb IS NULL) AS null_reb,
	COUNT(*) FILTER(WHERE ast IS NULL) AS null_ast,
	COUNT(*) FILTER(WHERE net_rating IS NULL) AS null_net_rating,
	COUNT(*) FILTER(WHERE oreb_pct IS NULL) AS null_oreb_pct,
	COUNT(*) FILTER(WHERE dreb_pct IS NULL) AS null_dreb_pct,
	COUNT(*) FILTER(WHERE usg_pct IS NULL) AS null_usg_pct,
	COUNT(*) FILTER(WHERE ts_pct IS NULL) AS null_ts_pct,
	COUNT(*) FILTER(WHERE ast_pct IS NULL) AS null_ast_pct,
	COUNT(*) FILTER(WHERE season IS NULL) AS null_season
FROM nba_data_cleaned;

-- Update columns to be rounded to a certain amount of decimal place
UPDATE nba_data_cleaned
SET player_height = ROUND(player_height::numeric, 1),
	player_weight = ROUND(player_weight::numeric, 1),
	oreb_pct = ROUND(oreb_pct::numeric, 3),
	dreb_pct = ROUND(dreb_pct::numeric, 3),
	usg_pct = ROUND(usg_pct::numeric, 3),
	ts_pct = ROUND(ts_pct::numeric, 3),
	ast_pct = ROUND(ast_pct::numeric, 3);
	
-- Update table to only contain seasons 2012-13 and up. Seasons before this are incomplete and not continuous. (ie. 1996-97, 2000)
DELETE FROM nba_data_cleaned
WHERE season NOT LIKE '20__-__';

