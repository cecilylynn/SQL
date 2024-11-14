-- Sending vs. Opening Snaps (Snapchat SQL Interview Question)
-- https://datalemur.com/questions/time-spent-snaps

/*
This is the same question as problem #25 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given tables with information on Snapchat users, 
including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps 
as a percentage of total time spent on these activities grouped by age group. 
Round the percentage to 2 decimal places in the output.
*/


SELECT age_bucket
    , ROUND(100.0*SUM(CASE activity_type WHEN 'send' THEN time_spent ELSE 0 END)
    /SUM(CASE activity_type 
      WHEN 'open' THEN time_spent 
      WHEN 'send' THEN time_spent
      ELSE 0 END),2) AS send_perc
  , ROUND(100.0*SUM(CASE activity_type WHEN 'open' THEN time_spent ELSE 0 END)
    /SUM(CASE activity_type 
      WHEN 'open' THEN time_spent 
      WHEN 'send' THEN time_spent
      ELSE 0 END),2) AS open_perc
FROM activities as a
  LEFT JOIN age_breakdown as b
    ON a.user_id = b.user_id
GROUP BY age_bucket
;



