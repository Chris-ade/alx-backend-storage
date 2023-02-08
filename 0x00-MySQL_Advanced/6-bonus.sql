-- Creates a stored procedure ComputeAverageScoreForUser to compute and store the average score for a student
CREATE PROCEDURE ComputeAverageScoreForUser(IN p_user_id INT)
BEGIN
  -- Declare variable to store average score
  DECLARE average_score FLOAT;

  -- Compute the average score by summing all scores for the user and dividing by the number of scores
  SELECT AVG(score) INTO average_score 
  FROM corrections 
  WHERE user_id = p_user_id;

  -- Update the user's average score in the users table
  UPDATE users 
  SET average_score = average_score 
  WHERE id = p_user_id;
END;
