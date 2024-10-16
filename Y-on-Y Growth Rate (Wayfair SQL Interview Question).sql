-- Y-on-Y Growth Rate (Wayfair SQL Interview Question)
-- https://datalemur.com/questions/yoy-growth-rate

-- This is the same question as problem #32 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you're given a table containing information about Wayfair user transactions for different products. 
-- Write a query to calculate the year-on-year growth rate for the total spend of each product, 
-- grouping the results by product ID.

-- The output should include the year in ascending order, product ID, current year's spend, previous year's spend 
-- and year-on-year growth percentage, rounded to 2 decimal places.


WITH cte AS (
  SELECT EXTRACT('year' FROM transaction_date) as year
    , product_id
    , spend as curr_year_spend
    , LAG(spend, 1) OVER (PARTITION BY product_id ORDER BY transaction_date) as prev_year_spend
  FROM user_transactions
)
SELECT *
  , ROUND(100*(curr_year_spend-prev_year_spend)/prev_year_spend,2) as yoy_rate
FROM cte
ORDER BY product_id, year
;