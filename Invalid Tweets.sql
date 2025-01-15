-- 1683. Invalid Tweets
-- https://leetcode.com/problems/invalid-tweets/?envType=study-plan-v2&envId=top-sql-50

/*
Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.

Return the result table in any order.
*/

SELECT tweet_id
FROM tweets
WHERE LENGTH(content) > 15
;