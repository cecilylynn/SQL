-- Median Google Search Frequency (Google SQL Interview Question)
-- https://datalemur.com/questions/median-search-freq

/*
Google's marketing team is making a Superbowl commercial and needs a simple statistic 
to put on their TV ad: the median number of searches a person made last year.

However, at Google scale, querying the 2 trillion searches is too costly. 
Luckily, you have access to the summary table which tells you the number of searches made 
last year and how many Google users fall into that bucket.

Write a query to report the median of searches made by a user. Round the median to one decimal point.
*/

WITH searches_expanded AS (
  SELECT searches
  FROM search_frequency
  GROUP BY searches
    , GENERATE_SERIES(1, num_users) --each number of searches will now appear one time for each user who did that number of searches
  ORDER BY searches
)
SELECT PERCENTILE_CONT(.5) WITHIN GROUP ( --median is 50th percentile
  ORDER BY searches) AS median
FROM searches_expanded
;
