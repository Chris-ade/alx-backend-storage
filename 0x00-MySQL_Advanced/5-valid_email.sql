-- Create the stored procedure `AddBonus`
DELIMITER $$
CREATE PROCEDURE AddBonus(IN user_id INT, IN project_name VARCHAR(255), IN score INT)
BEGIN
    DECLARE project_id INT;

    -- Check if the project exists
    SELECT id INTO project_id FROM projects WHERE name = project_name;
    -- If not, insert a new project
    IF project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (project_name);
        SELECT LAST_INSERT_ID() INTO project_id;
    END IF;

    -- Insert the new correction into the `corrections` table
    INSERT INTO corrections (user_id, project_id, score) VALUES (user_id, project_id, score);

    -- Update the average score of the user
    UPDATE users
    SET average_score = (SELECT AVG(score) FROM corrections WHERE user_id = user_id)
    WHERE id = user_id;
END $$
DELIMITER ;
