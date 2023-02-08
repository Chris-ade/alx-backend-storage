-- Create the users table if it does not already exist
CREATE TABLE IF NOT EXISTS users (
  -- The id column is an integer, never null, and is the primary key
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  -- The email column is a string of 255 characters, never null, and unique
  email VARCHAR(255) NOT NULL UNIQUE,
  -- The name column is a string of 255 characters
  name VARCHAR(255)
);
