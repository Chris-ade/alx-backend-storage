-- Ranks country origins of bands,
-- ordered by the number of (non-unique) fans
SELECT origin, SUM(nb_fans) as nb_fans -- Select the origin and sum of fans for each group of bands with the same origin
FROM metal_bands -- Source table containing information on the metal bands
GROUP BY origin -- Group the bands by their origin
ORDER BY nb_fans DESC; -- Order the result by the number of fans in descending order
