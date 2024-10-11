-- Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

-- Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. Output the city name and the corresponding number of completed trade orders

SELECT city
  , COUNT(*) as completed_trades
FROM trades as t
  LEFT JOIN users as u
  ON t.user_id = u.user_id
WHERE status = 'Completed'
GROUP BY city
ORDER BY completed_trades DESC
LIMIT 3
;