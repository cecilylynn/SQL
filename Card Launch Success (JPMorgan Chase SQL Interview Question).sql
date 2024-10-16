-- Card Launch Success (JPMorgan Chase SQL Interview Question)
-- https://datalemur.com/questions/card-launch-success

-- Your team at JPMorgan Chase is soon launching a new credit card. You are asked to estimate how many cards  
-- you'll issue in the first month.

-- Before you can answer this question, you want to first get some perspective on how well new credit card  
-- launches typically do in their first month.

-- Write a query that outputs the name of the credit card, and how many cards were issued in its launch month. 
-- The launch month is the earliest record in the monthly_cards_issued table for a given card. Order the results 
-- starting from the biggest issued amount.

SELECT DISTINCT card_name
  , FIRST_VALUE (issued_amount) OVER (
      PARTITION BY card_name ORDER BY MAKE_DATE(issue_year, issue_month, 1)) as issued_in_first_month
FROM monthly_cards_issued
ORDER BY issued_in_first_month DESC
;