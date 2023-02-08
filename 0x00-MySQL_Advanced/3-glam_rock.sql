-- Select the band_name and lifespan columns from the metal_bands table
SELECT band_name, 
       -- Calculate the lifespan of each band by subtracting their year of formation 
       -- from the year they split
       YEAR(split) - YEAR(formed) AS lifespan
FROM metal_bands
-- Only include bands with Glam Rock as their main style
WHERE main_style = 'Glam Rock'
-- Order the results by lifespan, from longest to shortest
ORDER BY lifespan DESC;
