-- Average Post Hiatus (Part 1) (Facebook SQL Interview Question)
-- https://datalemur.com/questions/sql-average-post-hiatus-1

-- Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the 
-- number of days between each user’s first post of the year and last post of the year in the year 2021. Output the 
-- user and number of the days between each user's first and last post.

SELECT user_id
  , MAX(post_date::DATE) - MIN(post_date::DATE) as days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING COUNT(post_date)>1
;