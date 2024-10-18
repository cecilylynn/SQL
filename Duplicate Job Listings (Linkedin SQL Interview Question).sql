-- Duplicate Job Listings (Linkedin SQL Interview Question)
-- https://datalemur.com/questions/duplicate-job-listings

-- This is the same question as problem #8 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you're given a table containing job postings from various companies on the LinkedIn platform. 
-- Write a query to retrieve the count of companies that have posted duplicate job listings.

-- Definition:
-- Duplicate job listings are defined as two job listings within the same company that share identical titles 
-- and descriptions.


SELECT COUNT(DISTINCT j1.company_id) as duplicate_companies --the companies left after the join and filter have made at least one duplicate post.
FROM job_listings as j1
  LEFT JOIN job_listings as j2
  ON j1.company_id = j2.company_id --join the listings from within each company to themselves
    AND j1.job_id != j2.job_id --excluding the exact same listing
WHERE j1.title = j2.title --then find the ones where the job title matches
  AND j1.description = j2.description --and the job description match
;