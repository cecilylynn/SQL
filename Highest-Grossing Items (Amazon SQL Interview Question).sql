-- Highest-Grossing Items (Amazon SQL Interview Question)
-- https://datalemur.com/questions/sql-highest-grossing

/*
Assume you're given a table containing data on Amazon customers and their spending on products in 
different category, write a query to identify the top two highest-grossing products within each category 
in the year 2022. The output should include the category, product, and total spend.
*/

WITH total_product_spend AS (
  SELECT category
    , product
    , SUM(spend) AS total_spend
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)
, ranked_products AS (
  SELECT *
    , RANK() OVER(
      PARTITION BY category
      ORDER BY total_spend DESC
      ) AS rank
  FROM total_product_spend
)
SELECT category
  , product
  , total_spend
FROM ranked_products
WHERE rank <= 2
;