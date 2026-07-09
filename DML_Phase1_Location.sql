-- ==========================================
-- PHASE 1: LOCATION DATA
-- ==========================================

INSERT INTO Location (Pincode, District, State) VALUES
-- 1. Same District & State, Different Pincodes (Ahmedabad, Gujarat)
('380001', 'Ahmedabad', 'Gujarat'),
('380009', 'Ahmedabad', 'Gujarat'), -- Navrangpura
('380015', 'Ahmedabad', 'Gujarat'), -- Satellite

-- 2. Same District & State, Different Pincodes (Gandhinagar, Gujarat)
('382007', 'Gandhinagar', 'Gujarat'),
('382010', 'Gandhinagar', 'Gujarat'), -- Sector 10

-- 3. Same State, Different District (Surat, Gujarat)
('395001', 'Surat', 'Gujarat'),

-- 4. Same District, Different State (Aurangabad: Maharashtra vs Bihar)
('431001', 'Aurangabad', 'Maharashtra'),
('824101', 'Aurangabad', 'Bihar'),

-- 5. Same District, Different State (Pratapgarh: Rajasthan vs Uttar Pradesh)
('312605', 'Pratapgarh', 'Rajasthan'),
('230001', 'Pratapgarh', 'Uttar Pradesh'),

-- 6. Same District, Different State (Bilaspur: Chhattisgarh vs Himachal Pradesh)
('495001', 'Bilaspur', 'Chhattisgarh'),
('174001', 'Bilaspur', 'Himachal Pradesh'),

-- 7. Different States & Districts (General Coverage)
('400001', 'Mumbai', 'Maharashtra'),
('411001', 'Pune', 'Maharashtra'),
('560001', 'Bengaluru', 'Karnataka'),
('110001', 'New Delhi', 'Delhi');
