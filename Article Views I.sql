-- 1148. Article Views I
-- https://leetcode.com/problems/article-views-i/?envType=study-plan-v2&envId=top-sql-50

/*
Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by id in ascending order.
*/

SELECT DISTINCT author_id AS id
FROM views
WHERE author_id=viewer_id
ORDER BY author_id ASC
;
