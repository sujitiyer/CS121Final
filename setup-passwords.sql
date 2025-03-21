DROP FUNCTION IF EXISTS make_salt;
DROP PROCEDURE IF EXISTS sp_add_adopter;
DROP PROCEDURE IF EXISTS sp_add_staff;
DROP FUNCTION IF EXISTS authenticate_adopter;
DROP FUNCTION IF EXISTS authenticate_staff;

-- (Provided) This function generates a specified number of characters for using as a
-- salt in passwords.
DELIMITER !
CREATE FUNCTION make_salt(num_chars INT)
RETURNS VARCHAR(20) NOT DETERMINISTIC NO SQL
BEGIN
    DECLARE salt VARCHAR(20) DEFAULT '';

    -- Don't want to generate more than 20 characters of salt.
    SET num_chars = LEAST(20, num_chars);

    -- Generate the salt!  Characters used are ASCII code 32 (space)
    -- through 126 ('z').
    WHILE num_chars > 0 DO
        SET salt = CONCAT(salt, CHAR(32 + FLOOR(RAND() * 95)));
        SET num_chars = num_chars - 1;
    END WHILE;

    RETURN salt;
END !
DELIMITER ;

DELIMITER !
-- Procedure: Adds a new adopter with a salted, hashed password.
CREATE PROCEDURE sp_add_adopter(
    new_email VARCHAR(255),
    new_password VARCHAR(255),
    new_name VARCHAR(255),
    new_address VARCHAR(255),
    new_zipcode INT,
    new_phone VARCHAR(20),
    new_date_joined DATE
)
BEGIN
    DECLARE salt CHAR(8);
    SET salt = make_salt(8);
    INSERT INTO adopters(name, address, zip_code, email, phone, salt, password_hash, date_joined)
    VALUES(new_name, new_address, new_zipcode, new_email, new_phone, salt, SHA2(CONCAT(salt, new_password), 256), new_date_joined);
END !
DELIMITER ;

DELIMITER !
-- Procedure: Adds a new staff member with a salted, hashed password.
CREATE PROCEDURE sp_add_staff(
    new_email VARCHAR(255),
    new_password VARCHAR(255),
    new_first_name VARCHAR(100),
    new_last_name VARCHAR(100),
    new_role VARCHAR(50),
    new_phone_number VARCHAR(20)
)
BEGIN
    DECLARE salt CHAR(8);
    SET salt = make_salt(8);
    INSERT INTO staff(first_name, last_name, role, phone_number, email, salt, password_hash)
    VALUES(new_first_name, new_last_name, new_role, new_phone_number, new_email, salt, SHA2(CONCAT(salt, new_password), 256));
END !
DELIMITER ;

DELIMITER !
CREATE FUNCTION authenticate_adopter(email VARCHAR(255), password VARCHAR(20))
RETURNS BIGINT UNSIGNED DETERMINISTIC
BEGIN
  DECLARE stored_salt CHAR(8);
  DECLARE stored_hash BINARY(64);
  DECLARE computed_hash BINARY(64);
  -- Instead of returning TINYINT on success, we modified the code
  -- We return the adopter's ID instead and use this ID during
  -- the python session.
  DECLARE aid BIGINT UNSIGNED;
  
  SELECT adopter_id, salt, password_hash
    INTO aid, stored_salt, stored_hash
  FROM adopters
  WHERE adopters.email = email;
  
  SET computed_hash = SHA2(CONCAT(stored_salt, password), 256);
  
  IF computed_hash = stored_hash THEN
    RETURN aid;
  ELSE
    RETURN 0;
  END IF;
END !
DELIMITER ;

DELIMITER !
CREATE FUNCTION authenticate_staff(email VARCHAR(255), password VARCHAR(20))
RETURNS BIGINT UNSIGNED DETERMINISTIC
BEGIN
  DECLARE stored_salt CHAR(8);
  DECLARE stored_hash BINARY(64);
  DECLARE computed_hash BINARY(64);
  -- On success, we want to return the staff ID
  DECLARE sid BIGINT UNSIGNED;
  
  SELECT staff_id, salt, password_hash
    INTO sid, stored_salt, stored_hash
  FROM staff
  WHERE staff.email = email;
  
  SET computed_hash = SHA2(CONCAT(stored_salt, password), 256);
  
  IF computed_hash = stored_hash THEN
    RETURN sid;
  ELSE
    RETURN 0;
  END IF;
END !
DELIMITER ;

-- Create a procedure sp_change_user_password to generate a new salt and change the given
-- user's password to the given password (after salting and hashing)
DELIMITER !
CREATE PROCEDURE sp_change_user_password(email VARCHAR(255), new_password VARCHAR(20))
BEGIN
  DECLARE new_salt CHAR(8);
  DECLARE new_hash BINARY(64);

  SET new_salt = make_salt(8);
  SET new_hash = SHA2(CONCAT(new_salt, new_password), 256);

  UPDATE adopters
  SET salt = new_salt,
    password_hash = new_hash
  WHERE adopters.email = email;
END !
DELIMITER ;

DELIMITER !
-- Create a procedure sp_change_staff_password to generate a new salt and change the given
-- staff's password to the given password (after salting and hashing)
CREATE PROCEDURE sp_change_staff_password(email VARCHAR(255), new_password VARCHAR(20))
BEGIN
  DECLARE new_salt CHAR(8);
  DECLARE new_hash BINARY(64);

  SET new_salt = make_salt(8);
  SET new_hash = SHA2(CONCAT(new_salt, new_password), 256);

  UPDATE staff
  SET salt = new_salt,
    password_hash = new_hash
  WHERE staff.email = email;
END !
DELIMITER ;