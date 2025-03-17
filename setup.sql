-- setup.sql

-- Drop tables in the correct order to avoid foreign key constraint issues
DROP TABLE IF EXISTS adoption_requests;
DROP TABLE IF EXISTS adoptions;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS adopters;
DROP TABLE IF EXISTS shelters;
DROP TABLE IF EXISTS staff;
DROP VIEW IF EXISTS adoption_overview

-- ======================================================
-- 1. staff TABLE
-- ------------------------------------------------------
-- Stores information about shelter staff (admins, managers, etc.)
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    -- 'admin', 'manager', 'vet'
    role VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(255) NOT NULL UNIQUE,
    salt CHAR(8) NOT NULL,
    password BINARY(64) NOT NULL
);

-- ======================================================
-- 2. shelters TABLE
-- ------------------------------------------------------
-- Stores shelter information. Each shelter may be managed by one staff member.
CREATE TABLE shelters (
    shelter_id SERIAL PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    zip_code INT,
    staff_id BIGINT UNSIGNED,
    CONSTRAINT fk_shelter_staff
        FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id)
        ON DELETE SET NULL
);

-- ======================================================
-- 3. adopters TABLE
-- ------------------------------------------------------
-- Stores potential adopter (client) information.
CREATE TABLE adopters (
    adopter_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    zip_code INT, 
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    salt CHAR(8) NOT NULL,
    password BINARY(64) NOT NULL,
    date_joined DATE
);

-- ======================================================
-- 4. animals TABLE
-- ------------------------------------------------------
-- Stores animal information available for adoption.
CREATE TABLE animals (
    animal_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    breed VARCHAR(255),
    age INT,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'U')), 
    intake_date DATE NOT NULL,
    shelter_id BIGINT UNSIGNED,
    is_healthy TINYINT(1) NOT NULL DEFAULT 0, -- not healthy until evaluated
    is_available TINYINT(1) NOT NULL DEFAULT 0, -- 0: not available; 1: available 
    CONSTRAINT fk_animal_shelter
        FOREIGN KEY (shelter_id)
        REFERENCES shelters(shelter_id)
        ON DELETE CASCADE
);

-- ======================================================
-- 5. adoptions TABLE
-- ------------------------------------------------------
-- Records adoptions that have occurred.
CREATE TABLE adoptions (
    adoption_id SERIAL PRIMARY KEY,
    date_taken DATE NOT NULL,
    adopter_id BIGINT UNSIGNED,
    animal_id BIGINT UNSIGNED,
    shelter_id BIGINT UNSIGNED,
    CONSTRAINT fk_adoption_adopter
        FOREIGN KEY (adopter_id)
        REFERENCES adopters(adopter_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_adoption_animal
        FOREIGN KEY (animal_id)
        REFERENCES animals(animal_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_adoption_shelter
        FOREIGN KEY (shelter_id)
        REFERENCES shelters(shelter_id)
        ON DELETE CASCADE
);

-- ======================================================
-- 6. ADOPTION_REQUESTS TABLE
-- ------------------------------------------------------
CREATE TABLE adoption_requests (
    request_id SERIAL PRIMARY KEY,
    adopter_id BIGINT UNSIGNED,
    animal_id BIGINT UNSIGNED,
    request_date DATE NOT NULL,
    CONSTRAINT fk_request_adopter
        FOREIGN KEY (adopter_id)
        REFERENCES adopters(adopter_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_request_animal
        FOREIGN KEY (animal_id)
        REFERENCES animals(animal_id)
        ON DELETE CASCADE
);

-- ======================================================
-- VIEW: Provides a combined overview of animal details and adoption info
-- ------------------------------------------------------
CREATE VIEW adoption_overview AS
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

CREATE INDEX idx_intake_date ON animals(intake_date);