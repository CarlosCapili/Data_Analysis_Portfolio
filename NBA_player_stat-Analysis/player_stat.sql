-- TRIVIAL STATS

-- Oldest and youngest player of per season
WITH ordered_age AS (
	SELECT
		player_name,
		player_age,
		season,
		ROW_NUMBER() OVER(PARTITION BY season ORDER BY player_age, player_name) AS rn_asc,
		ROW_NUMBER() OVER(PARTITION BY season ORDER BY player_age DESC, player_name) AS rn_desc
	FROM nba_data_cleaned
)

SELECT 
	season,
	MAX(CASE WHEN rn_asc = 1 THEN player_name END) AS youngest_player,
	MAX(CASE WHEN rn_asc = 1 THEN player_age END) AS youngest_player_age,
	MAX(CASE WHEN rn_desc = 1 THEN player_name END) AS oldest_player,
	MAX(CASE WHEN rn_desc = 1 THEN player_age END) AS oldest_player_age
FROM ordered_age
GROUP BY season;

-- What is the average number of games played by an NBA player per season? (What are the percentage increase/decline between season)
WITH season_gp AS (
	SELECT 
		season,
		ROUND(AVG(gp), 1) AS avg_gp,
		LAG(ROUND(AVG(gp), 1)) OVER(ORDER BY season) AS prev_avg_gp
	FROM nba_data_cleaned
	GROUP BY season
)
	
SELECT
	season,
	avg_gp,
	ROUND(ABS(avg_gp - prev_avg_gp) / prev_avg_gp * 100.0, 2) AS pct_inc_dec
FROM season_gp;

-- What is the average height of an NBA player per season?
SELECT 
	season,
	ROUND(AVG(player_height), 2) AS avg_player_height
FROM nba_data_cleaned
GROUP BY season
ORDER BY season;

Show how many countries are represented in the NBA per season
SELECT
	season,
	country,
	COUNT(*) AS num_players
FROM nba_data_cleaned
GROUP BY season, country
ORDER BY season, country

-- PERFORMANCE METRICS

-- Player with the highest ppg per season
WITH ordered_ppg AS (
	SELECT
		player_name,
		team_abbrev,
		country,
		pts,
		season,
		ROW_NUMBER() OVER(PARTITION BY season ORDER BY pts DESC) AS rn
	FROM nba_data_cleaned
)

SELECT
	season,
	player_name,
	team_abbrev,
	country,
	pts
FROM ordered_ppg
WHERE rn = 1;

-- Player with the highest rpg per season
WITH ordered_rpg AS (
	SELECT
		player_name,
		team_abbrev,
		country,
		reb,
		season,
		ROW_NUMBER() OVER(PARTITION BY season ORDER BY reb DESC) AS rn
	FROM nba_data_cleaned
)

SELECT
	season,
	player_name,
	team_abbrev,
	country,
	reb
FROM ordered_rpg
WHERE rn = 1;

-- Player with the highest apg per season
WITH ordered_apg AS (
	SELECT
		player_name,
		team_abbrev,
		country,
		ast,
		season,
		ROW_NUMBER() OVER(PARTITION BY season ORDER BY ast DESC) AS rn
	FROM nba_data_cleaned
)

SELECT
	season,
	player_name,
	team_abbrev,
	country,
	ast
FROM ordered_apg
WHERE rn = 1;

-- Top scorers in 2022-23 season
SELECT
	player_name,
	team_abbrev,
	pts
FROM nba_data_cleaned
WHERE season = '2022-23'
ORDER BY pts DESC
LIMIT 10;

-- Top rebounders in 2022-23 season
SELECT
	player_name,
	team_abbrev,
	reb
FROM nba_data_cleaned
WHERE season = '2022-23'
ORDER BY reb DESC
LIMIT 10;

-- Top assists in 2022-23 season
SELECT
	player_name,
	team_abbrev,
	ast
FROM nba_data_cleaned
WHERE season = '2022-23'
ORDER BY ast DESC
LIMIT 10;

-- Top 10 most efficient scorers in 2022-23 season (Who has the best true shooting percentage?)
SELECT
	player_name,
	team_abbrev,
	country,
	ROUND(ts_pct * 100, 1) AS ts_pct
FROM nba_data_cleaned
WHERE season = '2022-23'
ORDER BY ts_pct DESC
LIMIT 10;
	
-- Top 10 players who average a double-double in 2022-23 season (pts, rebs, ast, no steals or blocks are in dataset)
SELECT
	player_name,
	team_abbrev,
	pts,
	reb,
	ast
FROM nba_data_cleaned
WHERE season = '2022-23'
	AND ((pts >= 10 AND reb >= 10) OR (pts >= 10 AND ast >= 10) OR (reb >= 10 AND ast >= 10))
ORDER BY pts, reb, ast
LIMIT 10;

-- Calculate the total points, reb, ast for each player per season (Formula: pts|reb|ast / gp = ppg|rpg|apg)
SELECT
	season,
	team_abbrev,
	player_name,
	player_age,
	gp,
	ROUND(pts*gp) AS points,
	ROUND(reb*gp) AS rebounds,
	ROUND(ast*gp) AS assists
FROM nba_data_cleaned
ORDER BY season, team_abbrev, player_name

-- How many points, rebounds, assists has each team scored per season?
SELECT
	season,
	team_abbrev,
	SUM(ROUND(pts*gp)) AS points,
	SUM(ROUND(reb*gp)) AS rebounds,
	SUM(ROUND(ast*gp)) AS assists
FROM nba_data_cleaned
GROUP BY season, team_abbrev
ORDER BY season, team_abbrev

-- Which player scored the most points on each team per season?
WITH player_total_points AS ( 
	SELECT
		season,
		team_abbrev,
		player_name,
		ROUND(pts*gp) AS points,
		ROW_NUMBER() OVER(PARTITION BY season, team_abbrev ORDER BY ROUND(pts*gp) DESC) AS rn
 	FROM nba_data_cleaned
	ORDER BY season, team_abbrev
)

SELECT 
	season,
	team_abbrev,
	player_name,
	points
FROM player_total_points
WHERE rn = 1;

