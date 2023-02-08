-- Create a table to store the result of the ranking
CREATE TABLE IF NOT EXISTS country_origin_rank (
  origin VARCHAR(255) NOT NULL,
  nb_fans INT NOT NULL
);

-- Clear the contents of the table
TRUNCATE TABLE country_origin_rank;

-- Insert the result of the ranking into the table
INSERT INTO country_origin_rank (origin, nb_fans)
  SELECT origin, SUM(nb_fans) as nb_fans
  FROM metal_bands
  GROUP BY origin
  ORDER BY nb_fans DESC;
