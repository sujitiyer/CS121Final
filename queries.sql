-- Query to get all available animals for adoption
SELECT * FROM animals WHERE is_available = 1;

-- Query to get details of a specific animal by ID
SELECT * FROM animals WHERE animal_id = 5;

-- Query to search for animals by breed and/or age range (-2 to +2 of target age)
SELECT * FROM animals WHERE 1=1
AND breed = "Boxer"
AND age BETWEEN 4 AND 6;

-- Query to find available animals near an adopter, ordered by proximity
SELECT animals.*, shelters.zip_code,
       ABS(shelters.zip_code - 94000) AS zip_diff
FROM animals
JOIN shelters ON animals.shelter_id = shelters.shelter_id
WHERE animals.is_available = 1
ORDER BY zip_diff ASC;

-- Query to retrieve all past adoptions for a specific adopter
SELECT animal_id, animal_name, breed, age, gender, adoption_date
FROM adoption_overview
WHERE adopter_id = 15
ORDER BY adoption_date DESC;

-- Query to retrieve all current adoption requests, ordered by request date
-- This helps admin choose who's adoption to approve next
SELECT ar.request_id, a.name AS animal_name, ad.name AS adopter_name, ar.request_date
FROM adoption_requests ar
JOIN animals a ON ar.animal_id = a.animal_id
JOIN adopters ad ON ar.adopter_id = ad.adopter_id
ORDER BY ar.request_date DESC;

-- Finds the number of animals per shelter
-- Helps admins track the capacity of each shelter.
SELECT s.shelter_id, s.location, COALESCE(COUNT(a.animal_id), 0) AS animal_count
FROM shelters s
LEFT JOIN animals a ON s.shelter_id = a.shelter_id
GROUP BY s.shelter_id, s.location
ORDER BY animal_count DESC;

-- Finds the most commonly adopted breeds
-- Helps shelter understand which breeds are in high demand
SELECT breed, COUNT(adoption_date) AS adoption_count
FROM adoption_overview
WHERE adoption_date IS NOT NULL
GROUP BY breed
ORDER BY adoption_count DESC
LIMIT 10;

-- Finds number of adoptions per month
-- Helps analyze adoption trends over time
SELECT DATE_FORMAT(ad.date_taken, '%Y-%m') AS adoption_month, COUNT(*) AS adoption_count
FROM adoptions ad
GROUP BY adoption_month
ORDER BY adoption_month DESC;