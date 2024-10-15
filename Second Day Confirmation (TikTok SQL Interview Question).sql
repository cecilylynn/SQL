-- Second Day Confirmation (TikTok SQL Interview Question)
-- https://datalemur.com/questions/second-day-confirmation

-- Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. 
-- New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message 
-- confirmation to activate their account.

-- Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed 
-- on the second day.

SELECT user_id
FROM emails as e
  LEFT JOIN texts as t
  ON e.email_id = t.email_id
  AND t.signup_action = 'Confirmed'
WHERE action_date::date - signup_date::date = 1
;