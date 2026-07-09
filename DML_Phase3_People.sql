-- ==========================================
-- PHASE 3: THE PEOPLE (Trainers, Walk-ins, Members)
-- ==========================================

-- ------------------------------------------
-- 1. INSERT TRAINERS (15 Rows)
-- ------------------------------------------
INSERT INTO Trainer (TrainerID, TrainerName, PhoneNumber, Email, Gender, Pincode, AddressLine_1, AddressLine_2, JoinDate, TrainerRating, CommissionRate, ExperienceYears) VALUES
(201, 'Rahul Sharma',  '9876543001', 'rahul.s@fitzone.com', 'M', '380001', '12 Fitness Avenue', NULL, '2023-01-10', 4.8, 12.00, 5),
(202, 'Priya Patel',   '9876543002', 'priya.p@fitzone.com', 'F', '382007', 'Block C, Apollo Flats', 'Near InfoCity', '2023-02-15', 4.9, 15.00, 8),
(203, 'Amit Singh',    '9876543003', 'amit.s@fitzone.com',  'M', '395001', 'Ring Road Plaza', NULL, '2023-03-20', 4.2, 10.00, 3),
(204, 'Neha Desai',    '9876543004', 'neha.d@fitzone.com',  'F', '380009', 'Navrangpura Heights', 'Opp. University', '2023-04-10', 4.5, 12.00, 4),
(205, 'Vikram Rathod', '9876543005', 'vikram.r@fitzone.com','M', '380015', 'Satellite Towers', 'Apt 4B', '2023-05-12', 3.8, 8.00, 2),
(206, 'Sneha Joshi',   '9876543006', 'sneha.j@fitzone.com', 'F', '382010', 'Sector 10 CHS', NULL, '2023-06-18', 4.7, 10.00, 6),
(207, 'Rohan Mehta',   '9876543007', 'rohan.m@fitzone.com', 'M', '400001', 'Marine Drive Gym', 'South Bombay', '2023-07-22', 4.9, 15.00, 10),
(208, 'Kiran Kumar',   '9876543008', 'kiran.k@fitzone.com', 'O', '560001', 'MG Road Complex', NULL, '2023-08-30', 4.6, 11.00, 5),
(209, 'Pooja Tiwari',  '9876543009', 'pooja.t@fitzone.com', 'F', '110001', 'Connaught Place', 'Shop 12', '2023-09-14', 4.1, 9.00, 3),
(210, 'Suresh Pillai', '9876543010', 'suresh.p@fitzone.com','M', '411001', 'FC Road Gym', NULL, '2023-10-05', 3.5, 7.00, 1),
(211, 'Anita Shah',    '9876543011', 'anita.s@fitzone.com', 'F', '380001', 'Ashram Road', 'Building C', '2024-01-11', 4.3, 10.00, 4),
(212, 'Imran Khan',    '9876543012', 'imran.k@fitzone.com', 'M', '380009', 'CG Road', NULL, '2024-02-20', 4.8, 12.50, 7),
(213, 'Riya Verma',    '9876543013', 'riya.v@fitzone.com',  'F', '380015', 'Iskcon Cross Road', NULL, '2024-03-15', 4.0, 8.50, 2),
(214, 'Karan Patel',   '9876543014', 'karan.p@fitzone.com', 'M', '382007', 'Kudasan Road', 'Shop 2', '2024-04-10', 4.4, 9.50, 3),
(215, 'Manoj Gupta',   '9876543015', 'manoj.g@fitzone.com', 'M', '431001', 'Jalna Road', NULL, '2024-05-01', 3.9, 8.00, 2);


-- ------------------------------------------
-- 2. INSERT WALK-IN CUSTOMERS (15 Rows - Testing the NULL logic)
-- ------------------------------------------
INSERT INTO WalkInCustomer (CustomerID, CustomerName, PhoneNumber, Email) VALUES
-- Both Phone and Email
(301, 'Akash Trivedi', '8876543001', 'akash.t@gmail.com'),
(302, 'Bhavna Chauhan','8876543002', 'bhavna.c@yahoo.com'),
(303, 'Chirag Modi',   '8876543003', 'chirag.m@hotmail.com'),
(304, 'Deepak Jain',   '8876543004', 'deepak.j@outlook.com'),
(305, 'Esha Rajput',   '8876543005', 'esha.r@gmail.com'),
-- ONLY Phone (Testing your OR constraint)
(306, 'Farhan Sheikh', '8876543006', NULL),
(307, 'Gaurav Das',    '8876543007', NULL),
(308, 'Hetal Parmar',  '8876543008', NULL),
(309, 'Ishan Bhatt',   '8876543009', NULL),
(310, 'Jatin Vaghela', '8876543010', NULL),
-- ONLY Email (Testing your OR constraint)
(311, 'Kavita Iyer',   NULL, 'kavita.i@gmail.com'),
(312, 'Lalit Yadav',   NULL, 'lalit.y@yahoo.com'),
(313, 'Megha Nair',    NULL, 'megha.n@hotmail.com'),
(314, 'Nitin Soni',    NULL, 'nitin.s@outlook.com'),
(315, 'Omkar Pandit',  NULL, 'omkar.p@gmail.com');


-- ------------------------------------------
-- 3. INSERT MEMBERS (30 Rows - Robust Demographics)
-- ------------------------------------------
INSERT INTO Member (MemberID, FirstName, MiddleName, LastName, Gender, DateOfBirth, AddressLine_1, AddressLine_2, Pincode, JoinDate, Email, PhoneNumber) VALUES
(1001, 'Aarav', 'Kumar', 'Patel',   'M', '1995-04-12', '101 Shanti Heights', NULL, '380001', '2023-01-15', 'aarav.p@gmail.com', '7876543001'),
(1002, 'Diya',  NULL,    'Shah',    'F', '1998-08-22', 'B-24 Navrang Flats', 'Behind Post Office', '380009', '2023-02-10', 'diya.shah@yahoo.com', '7876543002'),
(1003, 'Ravi',  'Bhai',  'Desai',   'M', '1985-11-05', '5 Satellite Row Houses', NULL, '380015', '2023-03-01', 'ravi.desai@hotmail.com', '7876543003'),
(1004, 'Sonal', 'Ben',   'Joshi',   'F', '1990-02-14', 'Sector 2A', 'Plot 45', '382007', '2023-03-15', 'sonal.j@gmail.com', '7876543004'),
(1005, 'Kunal', NULL,    'Mehta',   'M', '2001-07-30', 'InfoCity Complex', NULL, '382010', '2023-04-20', 'kunal.m@outlook.com', '7876543005'),
(1006, 'Priya', NULL,    'Singh',   'F', '1993-09-18', 'Vesu Main Road', 'Apt 12B', '395001', '2023-05-10', 'priya.s@gmail.com', '7876543006'),
(1007, 'Arjun', 'Sinh',  'Rathod',  'M', '1988-12-01', 'CIDCO N4', NULL, '431001', '2023-06-05', 'arjun.r@yahoo.com', '7876543007'),
(1008, 'Neha',  NULL,    'Verma',   'F', '1996-05-25', 'Boring Road', 'Lane 2', '824101', '2023-07-12', 'neha.v@gmail.com', '7876543008'),
(1009, 'Rahul', 'Dev',   'Sharma',  'M', '1992-03-10', 'Station Road', NULL, '312605', '2023-08-18', 'rahul.s@hotmail.com', '7876543009'),
(1010, 'Pooja', NULL,    'Tiwari',  'F', '1999-10-05', 'Civil Lines', 'Near Park', '230001', '2023-09-22', 'pooja.t@gmail.com', '7876543010'),
(1011, 'Amit',  'Kumar', 'Gupta',   'M', '1982-01-20', 'Vyapar Vihar', NULL, '495001', '2023-10-01', 'amit.g@outlook.com', '7876543011'),
(1012, 'Riya',  NULL,    'Sen',     'F', '2003-06-15', 'Mall Road', 'Shop 5', '174001', '2023-11-11', 'riya.s@gmail.com', '7876543012'),
(1013, 'Vijay', NULL,    'Nair',    'M', '1975-08-08', 'Andheri West', NULL, '400001', '2023-12-05', 'vijay.n@yahoo.com', '7876543013'),
(1014, 'Anita', 'Ben',   'Patil',   'F', '1980-04-12', 'Kothrud', 'Building A', '411001', '2024-01-10', 'anita.p@gmail.com', '7876543014'),
(1015, 'Kiran', NULL,    'Reddy',   'O', '1994-11-30', 'Indiranagar', NULL, '560001', '2024-02-14', 'kiran.r@hotmail.com', '7876543015'),
(1016, 'Manoj', 'Bhai',  'Chauhan', 'M', '1989-02-28', 'Karol Bagh', 'Street 3', '110001', '2024-03-20', 'manoj.c@gmail.com', '7876543016'),
(1017, 'Sneha', NULL,    'Modi',    'F', '2000-09-10', 'Bopal', NULL, '380001', '2024-04-05', 'sneha.m@outlook.com', '7876543017'),
(1018, 'Yash',  'Raj',   'Jadeja',  'M', '1997-07-22', 'SG Highway', 'Block C', '380009', '2024-05-12', 'yash.j@gmail.com', '7876543018'),
(1019, 'Kavya', NULL,    'Bhatt',   'F', '1991-12-05', 'Vastrapur', NULL, '380015', '2024-06-18', 'kavya.b@yahoo.com', '7876543019'),
(1020, 'Harsh', NULL,    'Pandya',  'M', '1986-03-15', 'Sector 11', 'Plot 88', '382007', '2024-07-22', 'harsh.p@gmail.com', '7876543020'),
(1021, 'Nidhi', 'Ben',   'Parmar',  'F', '1998-10-20', 'Kudasan', NULL, '382010', '2024-08-30', 'nidhi.p@hotmail.com', '7876543021'),
(1022, 'Rohan', NULL,    'Vaghela', 'M', '2002-01-08', 'Adajan', 'Apt 1', '395001', '2024-09-14', 'rohan.v@gmail.com', '7876543022'),
(1023, 'Esha',  NULL,    'Rajput',  'F', '1995-05-30', 'CIDCO N6', NULL, '431001', '2024-10-05', 'esha.r@outlook.com', '7876543023'),
(1024, 'Chirag',NULL,    'Soni',    'M', '1984-08-12', 'MG Road', 'Shop 10', '824101', '2024-11-11', 'chirag.s@gmail.com', '7876543024'),
(1025, 'Megha', NULL,    'Iyer',    'F', '1993-02-25', 'Link Road', NULL, '312605', '2024-12-01', 'megha.i@yahoo.com', '7876543025'),
(1026, 'Nitin', 'Kumar', 'Das',     'M', '1987-07-14', 'Main Bazar', 'Lane 1', '230001', '2025-01-10', 'nitin.d@gmail.com', '7876543026'),
(1027, 'Bhavna',NULL,    'Pandit',  'F', '2000-11-05', 'Ring Road', NULL, '495001', '2025-02-15', 'bhavna.p@hotmail.com', '7876543027'),
(1028, 'Deepak',NULL,    'Yadav',   'M', '1990-04-18', 'Hill View', 'Apt 2', '174001', '2025-03-20', 'deepak.y@gmail.com', '7876543028'),
(1029, 'Gaurav',NULL,    'Sheikh',  'M', '1981-09-22', 'Bandra', NULL, '400001', '2025-04-05', 'gaurav.s@outlook.com', '7876543029'),
(1030, 'Hetal', 'Ben',   'Jain',    'F', '1996-12-30', 'Deccan Gymkhana', 'Plot 5', '411001', '2025-05-12', 'hetal.j@gmail.com', '7876543030');