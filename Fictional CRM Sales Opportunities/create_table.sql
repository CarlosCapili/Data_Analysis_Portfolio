-- Create tables for each dataset 
CREATE TABLE sales_pipeline (
	opportunity_id char(8),
	sales_agent text,
	product text,
	account text,
	deal_stage text,
	engage_date date,
	close_date date,
	close_value int
)

CREATE TABLE accounts (
	account text,
	sector text,
	year_established int,
	revenue numeric,
	employees int,
	office_location text,
	subsidiary_of text
)

CREATE TABLE products (
	product text,
	series varchar(3),
	sales_price int
)

CREATE TABLE sales_team (
	sales_agent text,
	manager text,
	regional_office text
)