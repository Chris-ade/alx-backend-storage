-- Create a table to store the result of the ranking
CREATE TABLE IF NOT EXISTS country_origin_rank (
  origin VARCHAR(255) NOT NULL, -- Column to store the origin of the band
  nb_fans INT NOT NULL -- Column to store the number of fans
);

-- Clear the contents of the table
TRUNCATE TABLE country_origin_rank;

-- Insert the result of the ranking into the table
INSERT INTO country_origin_rank (origin, nb_fans)
  SELECT origin, SUM(nb_fans) as nb_fans -- Select the origin and sum of fans for each group of bands with the same origin
  FROM metal_bands -- Source table containing information on the metal bands
  GROUP BY origin -- Group the bands by their origin
  ORDER BY nb_fans DESC; -- Order the result by the number of fans in descending order
