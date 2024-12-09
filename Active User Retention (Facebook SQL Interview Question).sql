-- Active User Retention (Facebook SQL Interview Question)
-- https://datalemur.com/questions/user-retention

/*
Assume you're given a table containing information on Facebook user actions. 
Write a query to obtain number of monthly active users (MAUs) in July 2022, 
including the month in numerical format "1, 2, 3".
An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' 
in both the current month and the previous month.
*/

WITH june_actions AS ( --get a table of user actions from June
  SELECT *
  FROM user_actions
  WHERE DATE_PART('month', event_date)=6
)
, july_actions AS ( --get a table of user actions from July
  SELECT *
  FROM user_actions
  WHERE DATE_PART('month', event_date)=7
)
SELECT 7 AS month
  , COUNT(DISTINCT july_actions.user_id) AS monthly_active_users
FROM june_actions INNER JOIN july_actions --inner join the two months of user actions to get users active in both months
  ON june_actions.user_id=july_actions.user_id
;