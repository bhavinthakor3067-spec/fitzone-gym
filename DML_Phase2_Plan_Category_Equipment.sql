-- ==========================================
-- PHASE 2: PLANS, CATEGORIES & EQUIPMENT
-- ==========================================

-- 1. INSERT PLANS (Decoy Pricing & Tiers applied)
INSERT INTO Plan (PlanID, PlanName, DurationMonths, PlanPrice, PlanDiscountPercentage) VALUES
-- Silver (1 Month, 0% Discount)
('01', 'Silver I',   1, 1500.00, 0.00),
('02', 'Silver II',  1, 2000.00, 0.00),
('03', 'Silver III', 1, 2500.00, 0.00),

-- Gold (3 Months, 5% Discount - Much cheaper than 3x Silver)
('11', 'Gold I',     3, 4000.00, 5.00),
('12', 'Gold II',    3, 5200.00, 5.00),
('13', 'Gold III',   3, 6500.00, 5.00),

-- Platinum (6 Months, 10% Discount - Even better value)
('21', 'Platinum I',   6,  7500.00, 10.00),
('22', 'Platinum II',  6,  9500.00, 10.00),
('23', 'Platinum III', 6, 12000.00, 10.00),

-- Diamond (12 Months, 15% Discount - The Ultimate Value)
('31', 'Diamond I',   12, 13000.00, 15.00),
('32', 'Diamond II',  12, 16000.00, 15.00),
('33', 'Diamond III', 12, 20000.00, 15.00);

-- 2. INSERT CATEGORIES
INSERT INTO Category (CategoryName) VALUES
('Cardio Machines'),
('Free Weights'),
('Assisted Machines'),
('Premium Recovery');

-- 3. INSERT EQUIPMENT (At least 3 per category with brand variations)
INSERT INTO Equipment (EquipmentID, Name, EquipmentCategory, PurchaseCost, PurchaseDate, LastServiceDate, NextServiceDate, EquipmentStatus) VALUES
-- Cardio Machines (Treadmills & Ellipticals)
(101, 'LifeFitness Discover SE3 Treadmill', 'Cardio Machines', 250000.00, '2023-01-15', '2023-11-20', '2024-05-20', 'A'),
(102, 'Precor TRM 800 Series Treadmill', 'Cardio Machines', 230000.00, '2023-01-15', '2023-12-10', '2024-06-10', 'A'),
(103, 'Matrix Performance Elliptical', 'Cardio Machines', 180000.00, '2023-05-10', '2024-01-05', '2024-07-05', 'M'), -- Under Maintenance

-- Free Weights
(201, 'Rogue Fitness Hex Dumbbell Set', 'Free Weights', 85000.00, '2023-02-01', '2024-01-10', '2025-01-10', 'A'),
(202, 'Eleiko Olympic Barbell Set', 'Free Weights', 120000.00, '2023-02-01', '2024-01-10', '2025-01-10', 'A'),
(203, 'IronGrip Urethane Plates 500kg', 'Free Weights', 95000.00, '2023-06-15', '2024-01-10', '2025-01-10', 'A'),

-- Assisted Machines (Smith, Cables)
(301, 'Hammer Strength Smith Machine', 'Assisted Machines', 150000.00, '2023-03-20', '2023-10-15', '2024-04-15', 'A'),
(302, 'Cybex Eagle Cable Crossover', 'Assisted Machines', 175000.00, '2023-03-20', '2023-11-01', '2024-05-01', 'A'),
(303, 'Nautilus Assisted Pull-Up Station', 'Assisted Machines', 110000.00, '2023-08-10', '2024-02-01', '2024-08-01', 'A'),

-- Premium Recovery (Massage Chairs)
(401, 'Osaki OS-4D Pro Maestro', 'Premium Recovery', 450000.00, '2023-04-05', '2023-12-20', '2024-06-20', 'A'),
(402, 'Human Touch Super Novo', 'Premium Recovery', 480000.00, '2023-04-05', '2024-01-15', '2024-07-15', 'A'),
(403, 'Luraco iRobotics 7 Plus', 'Premium Recovery', 520000.00, '2023-09-01', '2024-02-10', '2024-08-10', 'A');


-- 4. INSERT PLAN EQUIPMENT ACCESS (The Many-to-Many Mapping)
INSERT INTO PlanEquipmentAccess (PlanID, EquipmentCategory) VALUES
-- ALL TIER I PLANS: Get Cardio and Free Weights
('01', 'Cardio Machines'), ('01', 'Free Weights'),
('11', 'Cardio Machines'), ('11', 'Free Weights'),
('21', 'Cardio Machines'), ('21', 'Free Weights'),
('31', 'Cardio Machines'), ('31', 'Free Weights'),

-- ALL TIER II PLANS: Get Tier I + Free Weights + Assisted Machines
('02', 'Cardio Machines'), ('02', 'Free Weights'), ('02', 'Assisted Machines'),
('12', 'Cardio Machines'), ('12', 'Free Weights'), ('12', 'Assisted Machines'),
('22', 'Cardio Machines'), ('22', 'Free Weights'), ('22', 'Assisted Machines'),
('32', 'Cardio Machines'), ('32', 'Free Weights'), ('32', 'Assisted Machines'),

-- ALL TIER III PLANS: Get Everything (Including Premium Recovery)
('03', 'Cardio Machines'), ('03', 'Free Weights'), ('03', 'Assisted Machines'), ('03', 'Premium Recovery'),
('13', 'Cardio Machines'), ('13', 'Free Weights'), ('13', 'Assisted Machines'), ('13', 'Premium Recovery'),
('23', 'Cardio Machines'), ('23', 'Free Weights'), ('23', 'Assisted Machines'), ('23', 'Premium Recovery'),
('33', 'Cardio Machines'), ('33', 'Free Weights'), ('33', 'Assisted Machines'), ('33', 'Premium Recovery');