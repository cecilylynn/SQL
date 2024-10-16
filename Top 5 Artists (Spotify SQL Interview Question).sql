-- Top 5 Artists (Spotify SQL Interview Question)
-- https://datalemur.com/questions/top-fans-rank

-- Assume there are three Spotify tables: artists, songs, and global_song_rank, which contain information about 
-- the artists, songs, and music charts, respectively.

-- Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the global_song_rank 
-- table. Display the top 5 artist names in ascending order, along with their song appearance ranking.

-- If two or more artists have the same number of song appearances, they should be assigned the same ranking, 
-- and the rank numbers should be continuous (i.e. 1, 2, 2, 3, 4, 5).

WITH cte as (
SELECT artist_name
  , DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) as artist_rank
FROM global_song_rank as g
  INNER JOIN songs as s --in this example, there are songs in global_song_rank that are not present in songs so I'm using an inner join to avoid NULLs for artists
    ON g.song_id = s.song_id
  INNER JOIN artists as a
    ON s.artist_id = a.artist_id
WHERE rank < 10
GROUP BY artist_name)

SELECT *
FROM cte
WHERE artist_rank <= 5
;