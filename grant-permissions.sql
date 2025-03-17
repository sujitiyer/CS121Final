DROP USER IF EXISTS 'animaladmin'@'localhost';
DROP USER IF EXISTS 'animalclient'@'localhost';

CREATE USER 'animaladmin'@'localhost' IDENTIFIED BY 'adminpw';
CREATE USER 'animalclient'@'localhost' IDENTIFIED BY 'clientpw';
-- Can add more users or refine permissions
GRANT ALL PRIVILEGES ON shelterdb.* TO 'animaladmin'@'localhost';
GRANT SELECT ON shelterdb.* TO 'animalclient'@'localhost';
GRANT EXECUTE ON FUNCTION shelterdb.authenticate_adopter TO 'animalclient'@'localhost';
GRANT EXECUTE ON PROCEDURE shelterdb.sp_add_adopter TO 'animalclient'@'localhost';
GRANT EXECUTE ON PROCEDURE shelterdb.submit_adoption_request TO 'animalclient'@'localhost';
FLUSH PRIVILEGES;

