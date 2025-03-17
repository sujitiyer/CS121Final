-- procedures_udfs.sql
-- Drop funcs/procedures/views if already existing
DROP FUNCTION IF EXISTS days_in_shelter;
DROP FUNCTION IF EXISTS get_waitlist_position;
DROP PROCEDURE IF EXISTS transfer_animal;
DROP PROCEDURE IF EXISTS adopt_pet;
DROP TRIGGER IF EXISTS trg_update_availability;
DROP VIEW IF EXISTS Adoption_Overview;

DELIMITER !

-- UDF: Returns the number of days an animal has been in the shelter based on its intake date.
CREATE FUNCTION days_in_shelter(p_animal_id INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE intake DATE;
    DECLARE days INT;
    SELECT intake_date INTO intake FROM animals WHERE animal_id = p_animal_id;
    IF intake IS NULL THEN
        RETURN NULL;
    END IF;
    SET days = DATEDIFF(CURDATE(), intake);
    RETURN days;
END !

-- UDF: Returns the waitlist “rank” for a given adopter based on waitlist_number.
CREATE FUNCTION get_waitlist_position(p_adopter_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE wnum INT DEFAULT 0;
    DECLARE pos INT DEFAULT 0;

    SELECT waitlist_number
        INTO wnum
        FROM adopters
        WHERE adopter_id = p_adopter_id;

    IF wnum IS NULL THEN
        RETURN 0;
    END IF;

    -- Count how many adopters have a lower waitlist_number
    SELECT COUNT(*) + 1
        INTO pos
        FROM adopters
        WHERE waitlist_number IS NOT NULL
            AND waitlist_number < wnum;

    RETURN pos;
END !

-- Procedure: Transfers an animal to a new shelter.
CREATE PROCEDURE transfer_animal(IN p_animal_id INT, IN p_new_shelter_id INT)
BEGIN
    UPDATE animals
    SET shelter_id = p_new_shelter_id
    WHERE animal_id = p_animal_id AND is_available = 1;
END !


-- Procedure: Inserts an adoption record and removes existing requests
CREATE PROCEDURE adopt_pet(
    IN p_pet_id INT,
    IN p_adopter_id INT
)
BEGIN
    DECLARE not_adopted INT DEFAULT 0;

    SELECT is_available
    INTO not_adopted
    FROM animals
    WHERE animal_id = p_pet_id;

    IF not_adopted = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This pet is not available for adoption.';
    ELSE
        -- Insert an adoption record using the current date
        INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id)
        SELECT CURDATE(), p_adopter_id, p_pet_id, shelter_id
        FROM animals
        WHERE animal_id = p_pet_id;

        DELETE FROM adoption_requests
        WHERE adopter_id = p_adopter_id
            AND animal_id = p_pet_id;

        -- Set animal's availability to 'Adopted'
        UPDATE animals
        SET is_available = 0
        WHERE animal_id = p_pet_id;
    END IF;
END !

-- Trigger: After healthy medicals, animal is available
-- OR, after adoption, animal is not available
CREATE TRIGGER trg_update_availability
AFTER UPDATE
ON animals
FOR EACH ROW
BEGIN
    -- If the health_status changed to 'healthy', set availability_status to 'Available'
    IF OLD.is_healthy = 0 AND NEW.is_healthy = 1 THEN
        UPDATE animals
        SET is_available = 1
        WHERE animal_id = NEW.animal_id;
    END IF;

    -- If an animal becomes unhealthy again, it should not be available for adoption
    IF OLD.is_healthy = 1 AND NEW.is_healthy = 0 THEN
        UPDATE animals
        SET is_available = 0
        WHERE animal_id = NEW.animal_id;
    END IF;

    -- If an adoption occurs, update availability status
    IF EXISTS (
        SELECT 1 FROM adoptions WHERE animal_id = NEW.animal_id
    ) THEN
        UPDATE animals
        SET is_available = 0
        WHERE animal_id = NEW.animal_id;
    END IF;
END !

CREATE PROCEDURE update_health_status(IN p_animal_id INT, IN p_new_health_status TINYINT(1))
BEGIN
    UPDATE animals
    SET is_healthy = p_new_health_status
    WHERE animal_id = p_animal_id;
END !

DELIMITER ;

-- View: Provides a combined overview of animal details and adoption info
CREATE VIEW Adoption_Overview AS
SELECT 
    a.animal_id,
    a.name AS animal_name,
    a.breed,
    a.age,
    a.gender,
    a.intake_date,
    a.is_healthy,
    a.is_available,
    ad.date_taken AS adoption_date,
    ad.adopter_id
FROM animals a
LEFT JOIN adoptions ad ON a.animal_id = ad.animal_id;
