-- Create the users table if it does not already exist
CREATE TABLE IF NOT EXISTS users (
  -- The id column is an integer, never null, and is the primary key
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  -- The email column is a string of 255 characters, never null, and unique
  email VARCHAR(255) NOT NULL UNIQUE,
  -- The name column is a string of 255 characters
  name VARCHAR(255),
  -- The country column is an enumeration of three possible values: US, CO, and TN
  -- The column is never null, and has a default value of US
  country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US'
);
