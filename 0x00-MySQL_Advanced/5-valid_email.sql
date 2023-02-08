-- Createes a trigger that resets the attribute
-- valid_email only when the email has been changed.
DELIMITER //
CREATE PROCEDURE AddBonus (IN user_id INT, IN project_name VARCHAR(255), IN score INT)
BEGIN
    DECLARE project_id INT;

    -- Insert project if it doesn't exist
    INSERT INTO projects (name)
    SELECT project_name
    FROM dual
    WHERE NOT EXISTS (
        SELECT id FROM projects WHERE name = project_name
    ) LIMIT 1;

    SET project_id = (SELECT id FROM projects WHERE name = project_name);

    -- Insert correction
    INSERT INTO corrections (user_id, project_id, score)
    VALUES (user_id, project_id, score);

    -- Update user's average score
    UPDATE users SET average_score = (
        SELECT AVG(score)
        FROM corrections
        WHERE user_id = users.id
    ) WHERE id = user_id;
END //
DELIMITER ;
