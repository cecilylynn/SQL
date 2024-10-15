-- Advertiser Status (Facebook SQL Interview Question)
-- https://datalemur.com/questions/updated-status

-- You're provided with two tables: the advertiser table contains information about advertisers and their respective 
-- payment status, and the daily_pay table contains the current payment information for advertisers, and it only 
-- includes advertisers who have made payments.

-- Write a query to update the payment status of Facebook advertisers based on the information in the daily_pay 
-- table. The output should include the user ID and their current payment status, sorted by the user id.

SELECT COALESCE(a.user_id, p.user_id) AS user_id
  , CASE
      WHEN p.paid IS NULL THEN 'CHURN'
      WHEN a.status = 'CHURN' THEN 'RESURRECT'
      WHEN a.status IS NULL THEN 'NEW'
      ELSE 'EXISTING'
    END AS new_status
FROM
  advertiser AS a
    FULL OUTER JOIN daily_pay as p
    ON a.user_id = p.user_id
ORDER BY user_id
;

