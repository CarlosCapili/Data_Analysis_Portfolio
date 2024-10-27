-- How is each sales team performing against the rest?
SELECT
	st.manager,
	SUM(sp.close_value) AS team_sales
FROM sales_pipeline AS sp
LEFT JOIN sales_team AS st
	ON sp.sales_agent = st.sales_agent
WHERE sp.close_value IS NOT NULL
GROUP BY st.manager 
ORDER BY team_sales DESC

-- How is each sales agent for each team performing?
SELECT 
	sp.sales_agent,
	st.manager,
	SUM(close_value) AS agent_sales,
	DENSE_RANK() OVER(PARTITION BY st.manager ORDER BY SUM(close_value) DESC)
FROM sales_pipeline AS sp
LEFT JOIN sales_team AS st
	ON sp.sales_agent = st.sales_agent 
WHERE sp.close_value IS NOT NULL
GROUP BY sp.sales_agent, st.manager

-- Who are the top 5 sales agents?
SELECT 
	sales_agent,
	SUM(close_value) AS agent_sales
FROM sales_pipeline 
WHERE close_value IS NOT NULL
GROUP BY sales_agent
ORDER BY agent_sales DESC
LIMIT 5

-- What is the average time to close a deal for each agent?
WITH avg_deal_time AS (
	SELECT
		sales_agent,
		engage_date,
		close_date,
		(close_date - engage_date) AS time_to_close
	FROM sales_pipeline
	WHERE engage_date IS NOT NULL
		AND close_date IS NOT NULL
)

SELECT 
	sales_agent,
	ROUND(AVG(time_to_close), 1) AS time_to_close
FROM avg_deal_time
GROUP BY sales_agent
ORDER BY time_to_close DESC

-- How is each regional office performing?
SELECT 
	st.regional_office,
	SUM(close_value) AS office_sales
FROM sales_pipeline AS sp
LEFT JOIN sales_team AS st
	ON sp.sales_agent = st.sales_agent 
WHERE sp.close_value IS NOT NULL
GROUP BY st.regional_office
ORDER BY office_sales DESC

-- What are the total sales for each product?
SELECT 
	product,
	SUM(close_value) AS product_sales
FROM sales_pipeline 
WHERE close_value IS NOT NULL
	AND deal_stage = 'Won'
GROUP BY product
ORDER BY product_sales DESC

-- What products have a better win rate? (Show breakdown between won and lost in the deal_stage column)
WITH product_count AS (
	SELECT
		product,
		deal_stage,
		CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END AS win_count,
		CASE WHEN deal_stage = 'Lost' THEN 1 ELSE 0 END AS lost_count
	FROM sales_pipeline
	WHERE deal_stage IN ('Won', 'Lost')
)

SELECT
	product,
	SUM(win_count) AS win_count,
	SUM(lost_count) AS lost_count,
	ROUND(SUM(win_count) * 1.0 / (SUM(win_count) + SUM(lost_count)) * 100.0, 1) AS win_rate
FROM product_count
GROUP BY product
ORDER BY win_rate DESC

-- What are the total sales for each sector?
SELECT
	acc.sector,
	SUM(sp.close_value) AS sector_sales
FROM sales_pipeline AS sp
INNER JOIN accounts AS acc
	ON sp.account = acc.account
WHERE sp.close_value IS NOT NULL
GROUP BY acc.sector
ORDER BY sector_sales DESC

-- What are the sales of each product in each sector?
SELECT
	sp.product,
	acc.sector,
	SUM(sp.close_value) AS product_sales,
	DENSE_RANK() OVER(PARTITION BY sp.product ORDER BY SUM(sp.close_value) DESC)
FROM sales_pipeline AS sp
INNER JOIN accounts AS acc
	ON sp.account = acc.account
WHERE close_value IS NOT NULL
GROUP BY acc.sector, sp.product

-- What is the total amount of sales each account has?
SELECT
	account,
	SUM(close_value) AS account_sales
FROM sales_pipeline
WHERE close_value IS NOT NULL
GROUP BY account
ORDER BY account_sales DESC

-- How much net profit does each sales_agent/team/office bring in?

-- Sales agent real sales
SELECT
	sp.sales_agent,
	st.manager,
	SUM(sp.close_value) AS total_closing_val,
	SUM(pr.sales_price) AS total_sales_price,
	SUM(close_value) - SUM(sales_price) AS net_sales
FROM sales_pipeline AS sp
LEFT JOIN sales_team AS st
	ON sp.sales_agent = st.sales_agent
LEFT JOIN products as pr
	ON sp.product = pr.product
WHERE sp.close_value IS NOT NULL
	AND sp.deal_stage = 'Won' 
GROUP BY sp.sales_agent, st.manager
ORDER BY st.manager, net_sales DESC

-- Team real sales
SELECT
	st.manager,
	SUM(sp.close_value) - SUM(pr.sales_price) AS net_sales
FROM sales_pipeline AS sp
LEFT JOIN sales_team AS st
	ON sp.sales_agent = st.sales_agent
LEFT JOIN products AS pr
	ON sp.product = pr.product
WHERE sp.close_value IS NOT NULL
	AND sp.deal_stage = 'Won'
GROUP BY st.manager
ORDER BY net_sales DESC

-- Regional office real/projected sales
SELECT
	st.regional_office,
	SUM(sp.close_value) AS sum_close_val,
	SUM(pr.sales_price) AS sum_sales_price,
	SUM(sp.close_value) - SUM(pr.sales_price) AS net_sales
FROM sales_pipeline AS sp
LEFT JOIN sales_team AS st
	ON sp.sales_agent = st.sales_agent
LEFT JOIN products AS pr
	ON sp.product = pr.product
WHERE sp.close_value IS NOT NULL
	AND sp.deal_stage = 'Won'
GROUP BY st.regional_office
ORDER BY net_sales DESC
