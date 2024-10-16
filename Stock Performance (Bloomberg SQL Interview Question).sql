-- Stock Performance (Bloomberg SQL Interview Question)
-- https://datalemur.com/questions/sql-bloomberg-stock-performance

-- The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a wide array of financial datasets. In this SQL interview query for Data Analyst at Bloomberg, you're given the historical data on Google's stock performance.

-- Your task is to:

-- 1. Calculate the difference in closing prices between consecutive months.
-- 2. Calculate the difference between the closing price of the current month and the closing price 
-- from 3 months prior.

SELECT date
  , ticker
  , close
  , close - LAG (close, 1) OVER(
      PARTITION BY ticker
      ORDER BY date
    ) as change_from_previous_month
  , close - LAG (close, 3) OVER(
      PARTITION BY ticker
      ORDER BY date
    ) as change_from_3_months_prior
FROM stock_prices 
LIMIT 10
;