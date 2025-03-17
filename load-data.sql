INSERT INTO staff (first_name, last_name, role, phone_number, email, salt, password) VALUES
('Alice', 'Johnson', 'manager', '555-123-4567', 'alice.johnson@shelter.com', 'A1b2C3d4', SHA2(CONCAT('A1b2C3d4', 'SecurePass1'), 256)),
('Bob', 'Smith', 'admin', '555-234-5678', 'bob.smith@shelter.com', 'X5y6Z7w8', SHA2(CONCAT('X5y6Z7w8', 'AdminPass2'), 256)),
('Charlie', 'Brown', 'vet', '555-345-6789', 'charlie.brown@shelter.com', 'Q1W2E3R4', SHA2(CONCAT('Q1W2E3R4', 'VetPass3'), 256)),
('Diana', 'Prince', 'manager', '555-456-7890', 'diana.prince@shelter.com', 'M4N5O6P7', SHA2(CONCAT('M4N5O6P7', 'SecurePass4'), 256)),
('Edward', 'Norton', 'vet', '555-567-8901', 'edward.norton@shelter.com', 'J1K2L3M4', SHA2(CONCAT('J1K2L3M4', 'VetPass5'), 256)),
('Fiona', 'Gallagher', 'manager', '555-678-9012', 'fiona.gallagher@shelter.com', 'T8U7V6W5', SHA2(CONCAT('T8U7V6W5', 'SecurePass6'), 256)),
('George', 'Washington', 'admin', '555-789-0123', 'george.washington@shelter.com', 'R2D2C3P0', SHA2(CONCAT('R2D2C3P0', 'AdminPass7'), 256)),
('Helen', 'Parr', 'vet', '555-890-1234', 'helen.parr@shelter.com', 'A3B2C1D4', SHA2(CONCAT('A3B2C1D4', 'VetPass8'), 256)),
('Ian', 'McKellen', 'manager', '555-901-2345', 'ian.mckellen@shelter.com', 'Z9Y8X7W6', SHA2(CONCAT('Z9Y8X7W6', 'SecurePass9'), 256)),
('Jane', 'Doe', 'admin', '555-012-3456', 'jane.doe@shelter.com', 'M5N4O3P2', SHA2(CONCAT('M5N4O3P2', 'AdminPass10'), 256)),
('Kevin', 'Hart', 'vet', '555-223-3445', 'kevin.hart@shelter.com', 'L4M3N2O1', SHA2(CONCAT('L4M3N2O1', 'VetPass11'), 256)),
('Laura', 'Croft', 'manager', '555-334-4556', 'laura.croft@shelter.com', 'P8Q7R6S5', SHA2(CONCAT('P8Q7R6S5', 'SecurePass12'), 256)),
('Mike', 'Tyson', 'vet', '555-445-5667', 'mike.tyson@shelter.com', 'B3C2D1E4', SHA2(CONCAT('B3C2D1E4', 'VetPass13'), 256)),
('Nancy', 'Drew', 'admin', '555-556-6778', 'nancy.drew@shelter.com', 'X4Y3Z2W1', SHA2(CONCAT('X4Y3Z2W1', 'AdminPass14'), 256)),
('Oscar', 'Isaac', 'manager', '555-667-7889', 'oscar.isaac@shelter.com', 'M9N8O7P6', SHA2(CONCAT('M9N8O7P6', 'SecurePass15'), 256)),
('Peter', 'Parker', 'admin', '555-778-8990', 'peter.parker@shelter.com', 'T3U2V1W4', SHA2(CONCAT('T3U2V1W4', 'AdminPass16'), 256)),
('Quincy', 'Jones', 'vet', '555-889-9001', 'quincy.jones@shelter.com', 'A7B6C5D4', SHA2(CONCAT('A7B6C5D4', 'VetPass17'), 256)),
('Rachel', 'Green', 'manager', '555-990-0112', 'rachel.green@shelter.com', 'Q9W8E7R6', SHA2(CONCAT('Q9W8E7R6', 'SecurePass18'), 256)),
('Steve', 'Jobs', 'vet', '555-101-1123', 'steve.jobs@shelter.com', 'M2N1O4P3', SHA2(CONCAT('M2N1O4P3', 'VetPass19'), 256)),
('Tina', 'Turner', 'admin', '555-212-2234', 'tina.turner@shelter.com', 'P5Q4R3S2', SHA2(CONCAT('P5Q4R3S2', 'AdminPass20'), 256)),
('Ursula', 'K. Le Guin', 'manager', '555-323-3345', 'ursula.k@shelter.com', 'B6C5D4E3', SHA2(CONCAT('B6C5D4E3', 'SecurePass21'), 256)),
('Victor', 'Hugo', 'vet', '555-434-4456', 'victor.hugo@shelter.com', 'X8Y7Z6W5', SHA2(CONCAT('X8Y7Z6W5', 'VetPass22'), 256)),
('Wendy', 'Darling', 'admin', '555-545-5567', 'wendy.darling@shelter.com', 'M1N2O3P4', SHA2(CONCAT('M1N2O3P4', 'AdminPass23'), 256)),
('Xander', 'Cage', 'manager', '555-656-6678', 'xander.cage@shelter.com', 'T6U5V4W3', SHA2(CONCAT('T6U5V4W3', 'SecurePass24'), 256)),
('Yolanda', 'Adams', 'admin', '555-767-7789', 'yolanda.adams@shelter.com', 'A9B8C7D6', SHA2(CONCAT('A9B8C7D6', 'AdminPass25'), 256)),
('Zane', 'Grey', 'vet', '555-878-8890', 'zane.grey@shelter.com', 'Q2W1E4R3', SHA2(CONCAT('Q2W1E4R3', 'VetPass26'), 256)),
('Albert', 'Einstein', 'manager', '555-989-9001', 'albert.einstein@shelter.com', 'M8N7O6P5', SHA2(CONCAT('M8N7O6P5', 'SecurePass27'), 256)),
('Bruce', 'Wayne', 'admin', '555-090-0012', 'bruce.wayne@shelter.com', 'X3Y2Z1W4', SHA2(CONCAT('X3Y2Z1W4', 'AdminPass28'), 256)),
('Clark', 'Kent', 'vet', '555-101-1123', 'clark.kent@shelter.com', 'P7Q6R5S4', SHA2(CONCAT('P7Q6R5S4', 'VetPass29'), 256)),
('David', 'Bowie', 'manager', '555-111-2222', 'david.bowie@shelter.com', 'N1M2O3P4', SHA2(CONCAT('N1M2O3P4', 'SecurePass30'), 256)),
('Eleanor', 'Roosevelt', 'admin', '555-222-3333', 'eleanor.roosevelt@shelter.com', 'X9Y8Z7W6', SHA2(CONCAT('X9Y8Z7W6', 'AdminPass31'), 256)),
('Freddie', 'Mercury', 'vet', '555-333-4444', 'freddie.mercury@shelter.com', 'A6B5C4D3', SHA2(CONCAT('A6B5C4D3', 'VetPass32'), 256)),
('Gloria', 'Steinem', 'manager', '555-444-5555', 'gloria.steinem@shelter.com', 'Q5W4E3R2', SHA2(CONCAT('Q5W4E3R2', 'SecurePass33'), 256)),
('Harrison', 'Ford', 'vet', '555-555-6666', 'harrison.ford@shelter.com', 'M3N2O1P4', SHA2(CONCAT('M3N2O1P4', 'VetPass34'), 256)),
('Isaac', 'Newton', 'admin', '555-666-7777', 'isaac.newton@shelter.com', 'B4C3D2E1', SHA2(CONCAT('B4C3D2E1', 'AdminPass35'), 256)),
('Jackie', 'Chan', 'manager', '555-777-8888', 'jackie.chan@shelter.com', 'X2Y1Z4W3', SHA2(CONCAT('X2Y1Z4W3', 'SecurePass36'), 256)),
('Kurt', 'Cobain', 'vet', '555-888-9999', 'kurt.cobain@shelter.com', 'T5U4V3W2', SHA2(CONCAT('T5U4V3W2', 'VetPass37'), 256)),
('Leonardo', 'Da Vinci', 'admin', '555-999-0000', 'leo.davinci@shelter.com', 'A8B7C6D5', SHA2(CONCAT('A8B7C6D5', 'AdminPass38'), 256)),
('Marie', 'Curie', 'manager', '555-010-1010', 'marie.curie@shelter.com', 'Q3W2E1R4', SHA2(CONCAT('Q3W2E1R4', 'SecurePass39'), 256)),
('Nikola', 'Tesla', 'vet', '555-020-2020', 'nikola.tesla@shelter.com', 'M6N5O4P3', SHA2(CONCAT('M6N5O4P3', 'VetPass40'), 256)),
('Oprah', 'Winfrey', 'admin', '555-030-3030', 'oprah.winfrey@shelter.com', 'B7C6D5E4', SHA2(CONCAT('B7C6D5E4', 'AdminPass41'), 256)),
('Pablo', 'Picasso', 'manager', '555-040-4040', 'pablo.picasso@shelter.com', 'X1Y2Z3W4', SHA2(CONCAT('X1Y2Z3W4', 'SecurePass42'), 256)),
('Quentin', 'Tarantino', 'vet', '555-050-5050', 'quentin.tarantino@shelter.com', 'T9U8V7W6', SHA2(CONCAT('T9U8V7W6', 'VetPass43'), 256)),
('Rosa', 'Parks', 'admin', '555-060-6060', 'rosa.parks@shelter.com', 'A5B4C3D2', SHA2(CONCAT('A5B4C3D2', 'AdminPass44'), 256)),
('Stephen', 'Hawking', 'manager', '555-070-7070', 'stephen.hawking@shelter.com', 'Q7W6E5R4', SHA2(CONCAT('Q7W6E5R4', 'SecurePass45'), 256)),
('Tolkien', 'J.R.R.', 'vet', '555-080-8080', 'tolkien.jrr@shelter.com', 'M1N2O3P4', SHA2(CONCAT('M1N2O3P4', 'VetPass46'), 256)),
('Usain', 'Bolt', 'admin', '555-090-9090', 'usain.bolt@shelter.com', 'B9C8D7E6', SHA2(CONCAT('B9C8D7E6', 'AdminPass47'), 256)),
('Vincent', 'Van Gogh', 'manager', '555-101-0101', 'vincent.vangogh@shelter.com', 'X6Y5Z4W3', SHA2(CONCAT('X6Y5Z4W3', 'SecurePass48'), 256)),
('Walt', 'Disney', 'admin', '555-111-1111', 'walt.disney@shelter.com', 'T4U3V2W1', SHA2(CONCAT('T4U3V2W1', 'AdminPass49'), 256));


INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 95781, 49);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 93702, 18);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 94364, 44);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 96268, 2);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 98208, 46);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 91324, 7);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 95035, 31);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 95089, 11);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 99036, 7);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 97156, 31);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 97059, 10);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 96375, 22);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 92204, 38);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 94269, 3);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 93959, 41);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 97995, 34);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 97586, 9);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 91533, 14);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 94531, 20);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 99910, 44);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 94720, 27);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 93226, 34);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 98846, 9);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 98982, 12);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 92215, 40);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 94935, 10);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 90859, 13);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 98328, 20);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 95391, 5);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 94528, 14);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 96097, 38);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 98590, 26);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 95622, 45);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 99125, 42);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 93412, 21);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 99387, 45);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 94059, 14);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 98100, 39);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 97124, 38);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 92592, 48);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 99078, 22);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 94362, 8);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 95444, 18);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 93248, 2);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 97886, 35);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('New York, NY', 97716, 35);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Austin, TX', 98306, 48);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Chicago, IL', 99637, 1);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Seattle, WA', 90171, 18);
INSERT INTO shelters (location, zip_code, staff_id) VALUES ('Los Angeles, CA', 99587, 34);

INSERT INTO adopters (name, address, zip_code, email, phone, salt, password, date_joined) VALUES
('Adopter1', '123 Main St Apt 1', 91910, 'adopter1@email.com', '555-708-5483', 'A1B2C3D4', SHA2(CONCAT('A1B2C3D4', 'SecurePass1'), 256), '2023-07-29'),
('Adopter2', '123 Main St Apt 2', 99060, 'adopter2@email.com', '555-410-4551', 'X5Y6Z7W8', SHA2(CONCAT('X5Y6Z7W8', 'SecurePass2'), 256), '2021-11-19'),
('Adopter3', '123 Main St Apt 3', 95557, 'adopter3@email.com', '555-472-4010', 'Q9W8E7R6', SHA2(CONCAT('Q9W8E7R6', 'SecurePass3'), 256), '2021-06-26'),
('Adopter4', '123 Main St Apt 4', 98631, 'adopter4@email.com', '555-608-6269', 'M1N2O3P4', SHA2(CONCAT('M1N2O3P4', 'SecurePass4'), 256), '2020-11-18'),
('Adopter5', '123 Main St Apt 5', 91944, 'adopter5@email.com', '555-314-4454', 'B5C6D7E8', SHA2(CONCAT('B5C6D7E8', 'SecurePass5'), 256), '2020-09-20'),
('Adopter6', '123 Main St Apt 6', 92502, 'adopter6@email.com', '555-291-3072', 'T1U2V3W4', SHA2(CONCAT('T1U2V3W4', 'SecurePass6'), 256), '2021-11-03'),
('Adopter7', '123 Main St Apt 7', 98782, 'adopter7@email.com', '555-449-9602', 'X9Y8Z7W6', SHA2(CONCAT('X9Y8Z7W6', 'SecurePass7'), 256), '2021-03-30'),
('Adopter8', '123 Main St Apt 8', 97081, 'adopter8@email.com', '555-531-7016', 'A6B5C4D3', SHA2(CONCAT('A6B5C4D3', 'SecurePass8'), 256), '2022-04-16'),
('Adopter9', '123 Main St Apt 9', 90418, 'adopter9@email.com', '555-372-2946', 'Q5W4E3R2', SHA2(CONCAT('Q5W4E3R2', 'SecurePass9'), 256), '2020-12-15'),
('Adopter10', '123 Main St Apt 10', 95987, 'adopter10@email.com', '555-961-4577', 'M3N2O1P4', SHA2(CONCAT('M3N2O1P4', 'SecurePass10'), 256), '2020-10-22'),
('Adopter11', '123 Main St Apt 11', 97535, 'adopter11@email.com', '555-751-1452', 'B4C3D2E1', SHA2(CONCAT('B4C3D2E1', 'SecurePass11'), 256), '2020-01-15'),
('Adopter12', '123 Main St Apt 12', 95127, 'adopter12@email.com', '555-371-1684', 'X2Y1Z4W3', SHA2(CONCAT('X2Y1Z4W3', 'SecurePass12'), 256), '2022-02-06'),
('Adopter13', '123 Main St Apt 13', 94651, 'adopter13@email.com', '555-376-5264', 'T5U4V3W2', SHA2(CONCAT('T5U4V3W2', 'SecurePass13'), 256), '2021-05-09'),
('Adopter14', '123 Main St Apt 14', 91294, 'adopter14@email.com', '555-234-7914', 'A8B7C6D5', SHA2(CONCAT('A8B7C6D5', 'SecurePass14'), 256), '2021-01-24'),
('Adopter15', '123 Main St Apt 15', 90507, 'adopter15@email.com', '555-807-6657', 'Q3W2E1R4', SHA2(CONCAT('Q3W2E1R4', 'SecurePass15'), 256), '2020-09-27'),
('Adopter16', '123 Main St Apt 16', 92285, 'adopter16@email.com', '555-152-4135', 'M6N5O4P3', SHA2(CONCAT('M6N5O4P3', 'SecurePass16'), 256), '2021-03-24'),
('Adopter17', '123 Main St Apt 17', 93137, 'adopter17@email.com', '555-627-4942', 'B7C6D5E4', SHA2(CONCAT('B7C6D5E4', 'SecurePass17'), 256), '2020-09-20'),
('Adopter18', '123 Main St Apt 18', 91857, 'adopter18@email.com', '555-116-4843', 'X1Y2Z3W4', SHA2(CONCAT('X1Y2Z3W4', 'SecurePass18'), 256), '2020-05-20'),
('Adopter19', '123 Main St Apt 19', 90011, 'adopter19@email.com', '555-649-5173', 'T9U8V7W6', SHA2(CONCAT('T9U8V7W6', 'SecurePass19'), 256), '2021-08-27'),
('Adopter20', '123 Main St Apt 20', 98630, 'adopter20@email.com', '555-910-1825', 'A5B4C3D2', SHA2(CONCAT('A5B4C3D2', 'SecurePass20'), 256), '2023-11-11'),
('Adopter21', '123 Main St Apt 21', 96287, 'adopter21@email.com', '555-130-7483', 'D7E6F5G4', SHA2(CONCAT('D7E6F5G4', 'SecurePass21'), 256), '2022-10-08'),
('Adopter22', '123 Main St Apt 22', 94317, 'adopter22@email.com', '555-667-6516', 'K1L2M3N4', SHA2(CONCAT('K1L2M3N4', 'SecurePass22'), 256), '2022-02-09'),
('Adopter23', '123 Main St Apt 23', 92140, 'adopter23@email.com', '555-471-1556', 'P5Q6R7S8', SHA2(CONCAT('P5Q6R7S8', 'SecurePass23'), 256), '2023-07-10'),
('Adopter24', '123 Main St Apt 24', 90709, 'adopter24@email.com', '555-882-3825', 'X4Y3Z2W1', SHA2(CONCAT('X4Y3Z2W1', 'SecurePass24'), 256), '2023-12-12'),
('Adopter25', '123 Main St Apt 25', 93387, 'adopter25@email.com', '555-931-3812', 'V1W2X3Y4', SHA2(CONCAT('V1W2X3Y4', 'SecurePass25'), 256), '2023-07-14'),
('Adopter26', '123 Main St Apt 26', 95331, 'adopter26@email.com', '555-105-4751', 'Z5A6B7C8', SHA2(CONCAT('Z5A6B7C8', 'SecurePass26'), 256), '2023-05-29'),
('Adopter27', '123 Main St Apt 27', 90497, 'adopter27@email.com', '555-423-4025', 'D1E2F3G4', SHA2(CONCAT('D1E2F3G4', 'SecurePass27'), 256), '2022-03-10');


INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Coco', 'German Shepherd', 6, 'F', '2024-03-03', 41, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Nala', 'Bulldog', 11, 'U', '2024-08-19', 40, 0, 1);       
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Rex', 'Boxer', 15, 'M', '2024-10-24', 41, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Moose', 'Bulldog', 10, 'U', '2024-07-09', 50, 0, 0);      
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Penny', 'Husky', 11, 'U', '2024-07-03', 28, 1, 1);        
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Ginger', 'Poodle', 11, 'F', '2024-05-19', 31, 0, 0);      
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Max', 'Poodle', 13, 'M', '2022-09-19', 34, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Ruby', 'Dachshund', 6, 'M', '2023-06-10', 30, 0, 0);      
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Charlie', 'Doberman', 5, 'M', '2022-09-18', 23, 1, 0);    
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Bear', 'Dachshund', 9, 'U', '2023-07-30', 10, 1, 0);      
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Buddy', 'Shih Tzu', 1, 'M', '2022-07-24', 1, 1, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Bailey', 'Boxer', 15, 'U', '2024-06-30', 32, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Coco', 'Mastiff', 2, 'F', '2024-08-13', 20, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Chloe', 'Great Dane', 9, 'U', '2023-07-09', 38, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Maggie', 'Beagle', 4, 'U', '2023-11-24', 45, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Benny', 'Beagle', 10, 'F', '2023-06-13', 37, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Finn', 'Golden Retriever', 13, 'U', '2023-05-09', 38, 1, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Chloe', 'Shih Tzu', 13, 'U', '2023-01-28', 40, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Buster', 'Beagle', 2, 'F', '2024-10-14', 17, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Bentley', 'Dachshund', 4, 'M', '2022-09-28', 45, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Rocky', 'Mastiff', 15, 'M', '2024-01-01', 13, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Murphy', 'Labrador', 8, 'F', '2025-03-13', 12, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Ace', 'Labrador', 15, 'F', '2024-04-10', 11, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Daisy', 'Beagle', 12, 'F', '2023-04-04', 8, 1, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Bentley', 'German Shepherd', 14, 'M', '2024-11-23', 27, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Max', 'Beagle', 3, 'U', '2023-09-23', 18, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Chloe', 'Golden Retriever', 15, 'M', '2024-03-22', 40, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Lily', 'Pug', 3, 'M', '2025-03-14', 1, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Sophie', 'Boxer', 5, 'U', '2025-02-11', 26, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Duke', 'Golden Retriever', 7, 'F', '2023-10-09', 33, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Tucker', 'Bulldog', 6, 'U', '2024-10-09', 23, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Rocky', 'Chihuahua', 10, 'M', '2023-12-13', 15, 1, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Ace', 'Boxer', 9, 'M', '2022-07-31', 26, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Rosie', 'Bulldog', 4, 'F', '2023-12-09', 2, 1, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Lily', 'Dachshund', 10, 'F', '2023-04-25', 43, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Chloe', 'Great Dane', 14, 'F', '2023-02-17', 3, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Chloe', 'Dachshund', 14, 'M', '2024-05-23', 46, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Bailey', 'Poodle', 5, 'M', '2024-01-28', 9, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Finn', 'Bulldog', 13, 'U', '2022-04-08', 10, 1, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Rosie', 'Doberman', 3, 'M', '2025-01-04', 7, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Winston', 'Beagle', 7, 'M', '2024-03-29', 15, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Bella', 'Bulldog', 1, 'U', '2022-04-19', 29, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Rosie', 'Dachshund', 8, 'U', '2024-02-21', 40, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Moose', 'Doberman', 3, 'U', '2023-07-13', 27, 0, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Rex', 'Husky', 15, 'M', '2022-06-20', 45, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Winston', 'Boxer', 15, 'F', '2022-07-28', 41, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Benny', 'Great Dane', 2, 'M', '2022-08-21', 34, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Charlie', 'Golden Retriever', 1, 'M', '2022-04-21', 43, 0, 1);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Milo', 'Beagle', 1, 'M', '2024-07-25', 8, 1, 0);
INSERT INTO animals (name, breed, age, gender, intake_date, shelter_id, is_healthy, is_available) VALUES ('Molly', 'Labrador', 15, 'U', '2023-09-20', 29, 1, 0);

INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-04-03', 13, 35, 3);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-07-07', 14, 4, 31);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-01-12', 9, 14, 4);        -- 36 → 9
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-10-27', 2, 17, 22);       -- 29 → 2
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-05-23', 19, 32, 9);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-08-23', 5, 50, 47);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-03-25', 18, 49, 17);       -- 45 → 18
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-11-04', 8, 11, 47);        -- 35 → 8
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-07-10', 6, 5, 27);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-08-29', 22, 31, 36);       -- 49 → 22
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-07-22', 5, 44, 10);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-07-17', 26, 11, 6);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-09-11', 3, 20, 18);        -- 30 → 3
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-10-18', 10, 23, 31);       -- 37 → 10
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-11-05', 15, 35, 9);        -- 42 → 15
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-03-23', 27, 44, 45);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-07-29', 4, 7, 29);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-08-18', 10, 22, 26);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-07-30', 15, 33, 23);       -- 42 → 15
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2025-02-05', 2, 38, 16);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-02-02', 2, 41, 12);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-03-30', 15, 24, 5);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-07-18', 10, 44, 41);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-11-22', 8, 27, 24);        -- 35 → 8
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-09-29', 10, 15, 31);       -- 37 → 10
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-05-16', 26, 19, 28);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2025-01-05', 26, 2, 42);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-01-02', 8, 9, 48);         -- 35 → 8
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-11-26', 24, 45, 31);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-09-24', 16, 14, 33);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-05-31', 3, 42, 21);        -- 30 → 3
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-06-24', 12, 1, 7);         -- 39 → 12
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-08-15', 1, 38, 25);        -- 28 → 1
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-05-21', 20, 11, 47);       -- 47 → 20
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-10-28', 4, 35, 45);        -- 31 → 4
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2025-01-21', 14, 8, 17);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-12-19', 4, 13, 37);        -- 31 → 4
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-05-31', 6, 12, 43);        -- 33 → 6
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-05-26', 15, 27, 36);       -- 42 → 15
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-01-21', 16, 12, 19);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-12-06', 17, 15, 38);       -- 44 → 17
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-02-17', 26, 19, 29);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-12-19', 2, 7, 29);         -- 29 → 2
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-03-29', 12, 32, 25);       -- 39 → 12
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-01-01', 1, 34, 26);        -- 28 → 1
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-04-27', 12, 29, 32);       -- 39 → 12
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-05-02', 1, 17, 45);        -- 28 → 1
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2024-03-28', 13, 14, 39);
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-12-28', 14, 36, 11);       -- 41 → 14
INSERT INTO adoptions (date_taken, adopter_id, animal_id, shelter_id) VALUES ('2023-08-17', 6, 4, 47);

INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (24, 1, '2023-07-28');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (17, 17, '2023-03-26');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (6, 50, '2023-06-09');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (27, 15, '2023-03-28');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (7, 48, '2023-03-28');       -- 34 mod 27 = 7
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (20, 45, '2023-11-03');      -- 47 mod 27 = 20
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (13, 35, '2023-05-01');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (17, 3, '2023-08-14');       -- 44 mod 27 = 17
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (2, 30, '2023-10-19');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (14, 23, '2023-11-21');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (21, 15, '2023-02-22');      -- 48 mod 27 = 21
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (15, 27, '2023-10-03');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (19, 27, '2023-04-08');      -- 46 mod 27 = 19
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (8, 47, '2023-08-09');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (8, 23, '2023-09-22');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (8, 39, '2023-09-01');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (24, 18, '2023-06-18');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (8, 3, '2023-05-06');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (21, 34, '2023-01-17');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (18, 7, '2023-03-17');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (20, 1, '2023-07-07');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (24, 50, '2023-06-09');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (16, 5, '2023-03-14');      -- 43 mod 27 = 16
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (15, 49, '2023-12-01');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (22, 9, '2023-08-17');      -- 49 mod 27 = 22
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (15, 31, '2023-05-16');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (9, 36, '2023-06-03');       -- 36 mod 27 = 9
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (18, 34, '2023-10-06');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (14, 44, '2023-12-13');      -- 41 mod 27 = 14
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (4, 25, '2023-09-21');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (14, 24, '2023-08-13');      -- 41 mod 27 = 14
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (11, 38, '2023-10-08');      -- 38 mod 27 = 11
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (8, 27, '2023-01-22');       -- 35 mod 27 = 8
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (11, 33, '2023-02-01');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (3, 41, '2023-04-13');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (1, 48, '2023-08-10');       -- 28 mod 27 = 1
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (20, 23, '2023-07-20');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (10, 6, '2023-07-27');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (22, 48, '2023-08-22');      -- 49 mod 27 = 22
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (11, 17, '2023-05-01');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (9, 47, '2023-08-19');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (14, 47, '2023-07-01');       -- 41 mod 27 = 14
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (23, 49, '2023-04-18');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (16, 3, '2023-02-28');       -- 43 mod 27 = 16
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (1, 24, '2023-11-11');
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (21, 32, '2023-05-19');      -- 48 mod 27 = 21
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (13, 3, '2023-02-12');       -- 40 mod 27 = 13
INSERT INTO adoption_requests (adopter_id, animal_id, request_date) VALUES (22, 4, '2023-01-02');       -- 49 mod 27 = 22
