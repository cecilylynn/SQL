-- FAANG Stock Min-Max (Part 1) (Bloomberg SQL Interview Question)
-- https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

/*
The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a 
wide array of financial datasets. As a Data Analyst at Bloomberg, you have access to historical data on 
stock performance.

Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

For each FAANG stock, display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding 
highest and lowest open prices (refer to the Example Output format). 
Ensure that the results are sorted by ticker symbol.
*/

--the following CTE pulls out the min and max open for each ticker
WITH min_max AS (
  SELECT ticker
    , MAX(open) AS highest_open
    , MIN(open) AS lowest_open
  FROM stock_prices
  GROUP BY ticker
  ORDER BY ticker
)

SELECT s.ticker
  , MAX( --take the max to get rid of the null rows
    TO_CHAR(
      CASE WHEN open = highest_open THEN date END -- get the date of the highest month
      , 'Mon-YYYY' --format it
      )
    ) AS highest_mth
  , highest_open
  , MAX( --take the max to get rid of the null rows
    TO_CHAR(
      CASE WHEN open = lowest_open THEN date END -- get the date of the lowest month
      , 'Mon-YYYY' --format it
      )
    ) AS lowest_mth
  , lowest_open
FROM stock_prices AS s
  INNER JOIN min_max AS m
  ON s.ticker = m.ticker
    AND (s.open = highest_open OR s.open = lowest_open) --this filters us to the rows that have the min and max opens
GROUP BY 1, 3, 5 --group by everything except the aggregated fields
ORDER BY s.ticker
;