-- Creates a stored procedure ComputeAverageScoreForUser to compute and store the average score for a student
CREATE PROCEDURE AddBonus(IN p_user_id INT, IN p_project_name VARCHAR(255), IN p_score INT)
BEGIN
    DECLARE project_id INT;

    -- Check if project exists, if not insert it
    SELECT id INTO project_id FROM projects WHERE name = p_project_name;
    IF NOT FOUND THEN
        INSERT INTO projects (name) VALUES (p_project_name);
        SET project_id = LAST_INSERT_ID();
    END IF;

    -- Insert correction for the user and project
    INSERT INTO corrections (user_id, project_id, score) VALUES (p_user_id, project_id, p_score);
END
