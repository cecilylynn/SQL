-- User's Third Transaction (Uber SQL Interview Question)
-- https://datalemur.com/questions/sql-third-transaction


/*
This is the same question as problem #11 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below on Uber transactions made by users. 
Write a query to obtain the third transaction of every user. 
Output the user id, spend and transaction date.
*/

WITH cte AS (
SELECT * 
  , ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date ASC) AS transaction_number
FROM transactions
)
SELECT user_id
  , spend
  , transaction_date
FROM cte
WHERE transaction_number = 3
;