-- Page With No Likes (Facebook SQL Interview Question)
-- https://datalemur.com/questions/sql-page-with-no-likes

-- Assume you're given two tables containing data about Facebook Pages and their respective likes 
-- (as in "Like a Facebook Page").
-- Write a query to return the IDs of the Facebook pages that have zero likes. 
-- The output should be sorted in ascending order based on the page IDs.


-- method 1: JOIN
SELECT p.page_id 
FROM pages as p
  LEFT JOIN page_likes as l
  ON p.page_id = l.page_id
WHERE user_id IS NULL
ORDER BY page_id ASC
;


-- method 2: EXCEPT
SELECT page_id
FROM pages
EXCEPT 
SELECT page_id
FROM page_likes
;
