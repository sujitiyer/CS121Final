-- setup-proposal.sql

-- Drop tables in the correct order to avoid foreign key constraint issues
DROP TABLE IF EXISTS adoption_requests;
DROP TABLE IF EXISTS adoptions;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS adopters;
DROP TABLE IF EXISTS shelters;
DROP TABLE IF EXISTS medical_records;
DROP TABLE IF EXISTS staff;

-- ======================================================
-- 1. staff TABLE
-- ------------------------------------------------------
-- Stores information about shelter staff (admins, managers, etc.)
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    -- 'admin', 'manager', 'vet'
    role VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(255) NOT NULL UNIQUE,
    -- In production, store hashed passwords
    password VARCHAR(255) NOT NULL
);

-- ======================================================
-- 2. medical_records TABLE
-- ------------------------------------------------------
-- Stores medical history for animals.
-- All text types because summaries might be long.
-- TODO: health_status
CREATE TABLE medical_records (
    medical_record_id INT AUTO_INCREMENT PRIMARY KEY,
    diagnosis TEXT,
    treatment TEXT,
    summary TEXT
);

-- ======================================================
-- 3. shelters TABLE
-- ------------------------------------------------------
-- Stores shelter information. Each shelter may be managed by one staff member.
CREATE TABLE shelters (
    shelter_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    zip_code INT,
    staff_id INT,
    CONSTRAINT fk_shelter_staff
        FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id)
        ON DELETE SET NULL
);

-- ======================================================
-- 4. adopters TABLE
-- ------------------------------------------------------
-- Stores potential adopter (client) information.
CREATE TABLE adopters (
    adopter_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    zip_code INT, 
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    -- In production, store hashed passwords
    password VARCHAR(255) NOT NULL,
    date_joined DATE,
    waitlist_number INT
);

-- ======================================================
-- 5. animals TABLE
-- ------------------------------------------------------
-- Stores animal information available for adoption.
-- TODO: availability_status
CREATE TABLE animals (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    breed VARCHAR(255),
    age INT,
    gender VARCHAR(10), -- Char(1), 'M'/'F'/'U'/'A'
    intake_date DATE,
    shelter_id INT,
    medical_record_id INT NULL,

    CONSTRAINT fk_animal_shelter
        FOREIGN KEY (shelter_id)
        REFERENCES shelters(shelter_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_animal_medical
        FOREIGN KEY (medical_record_id)
        REFERENCES medical_records(medical_record_id)
        ON DELETE SET NULL
);

-- ======================================================
-- 6. adoptions TABLE
-- ------------------------------------------------------
-- Records adoptions that have occurred.
CREATE TABLE adoptions (
    adoption_id INT AUTO_INCREMENT PRIMARY KEY,
    date_taken DATE,
    adopter_id INT,
    animal_id INT,
    shelter_id INT,
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
-- 7. ADOPTION_REQUESTS TABLE
-- ------------------------------------------------------
-- Optionally, record adoption requests before final approval.
CREATE TABLE adoption_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    adopter_id INT,
    animal_id INT,
    request_date DATE,
    CONSTRAINT fk_request_adopter
        FOREIGN KEY (adopter_id)
        REFERENCES adopters(adopter_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_request_animal
        FOREIGN KEY (animal_id)
        REFERENCES animals(animal_id)
        ON DELETE CASCADE
);
