-- Odd and Even Measurements (Google SQL Interview Question)
-- https://datalemur.com/questions/odd-even-measurements

-- This is the same question as problem #28 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you're given a table with measurement values obtained from a Google sensor over multiple days with 
-- measurements taken multiple times within each day.

-- Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular
-- day and display the results in two different columns. Refer to the Example Output below for the desired format.

-- Definition:

-- Within a day, measurements taken at 1st, 3rd, and 5th times are considered odd-numbered measurements, 
-- and measurements taken at 2nd, 4th, and 6th times are considered even-numbered measurements.


WITH measurement_numbers AS (
  SELECT measurement_time
    , measurement_time::DATE as measurement_day
    , measurement_value
    , ROW_NUMBER() OVER(PARTITION BY measurement_time::DATE ORDER BY measurement_time) as measurement_number
  FROM measurements
  ORDER BY measurement_time
)

SELECT measurement_day
  , SUM(CASE WHEN measurement_number % 2 = 1 THEN measurement_value END) as odd_sum
  , SUM(CASE WHEN measurement_number % 2 = 0 THEN measurement_value END) as even_sum

FROM measurement_numbers
GROUP BY measurement_day
ORDER BY measurement_day
;