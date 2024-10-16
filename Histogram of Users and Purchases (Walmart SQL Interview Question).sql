-- Histogram of Users and Purchases (Walmart SQL Interview Question)
-- https://datalemur.com/questions/histogram-users-purchases

-- This is the same question as problem #13 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you're given a table on Walmart user transactions. 
-- Based on their most recent transaction date, 
-- write a query that retrieve the users along with the total number of products they've bought so far.

-- Output the user's most recent transaction date, user ID, and the number of products, 
-- sorted in chronological order by the transaction date.


WITH cte AS (
  SELECT transaction_date
    , user_id
    , COUNT(*) OVER(PARTITION BY user_id ORDER BY transaction_date) as purchase_count
    , MAX(transaction_date) OVER(PARTITION BY user_id) as max_date
  FROM user_transactions
)

SELECT DISTINCT transaction_date
  , user_id
  , purchase_count
FROM cte
WHERE transaction_date = max_date
ORDER BY transaction_date
;

