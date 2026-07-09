-- ==========================================
-- PHASE 5: THE FINANCIALS (20 Invoices, Details & Refunds)
-- ==========================================

-- ------------------------------------------
-- 1. INSERT INVOICES (20 Rows)
-- Buyers: Members (Gold/Diamond/Plat/Silver), Walk-ins, Trainers
-- ------------------------------------------
INSERT INTO Invoice (InvoiceNo, InvoiceDate, PaymentMethod, BuyerID) VALUES
(10001, '2024-02-10 10:00:00', 'UPI', 1),         -- Gold Member (5%)
(10002, '2024-07-15 11:30:00', 'Credit Card', 2), -- Diamond Member (15%)
(10003, '2024-03-05 18:00:00', 'Cash', 32),       -- Walk-In Customer (0%)
(10004, '2024-01-20 09:15:00', 'Net Banking', 41),-- Trainer (25%)
(10005, '2024-08-22 14:00:00', 'Debit Card', 8),  -- Platinum Member (10%)
(10006, '2024-09-10 16:45:00', 'UPI', 42),        -- Trainer (25%)
(10007, '2024-10-05 08:30:00', 'Credit Card', 18),-- Gold Member (5%)
(10008, '2024-11-12 19:00:00', 'Cash', 35),       -- Walk-In Customer (0%)
(10009, '2024-12-01 10:15:00', 'UPI', 4),         -- Diamond Member (15%)
(10010, '2025-01-15 07:30:00', 'Net Banking', 12),-- Silver Member (0%)
(10011, '2025-01-20 18:45:00', 'Cash', 43),       -- Trainer (25%)
(10012, '2025-02-10 09:00:00', 'Credit Card', 7), -- Diamond Member (15%)
(10013, '2025-02-18 17:15:00', 'UPI', 13),        -- Gold Member (5%)
(10014, '2025-03-05 20:30:00', 'Cash', 39),       -- Walk-In Customer (0%)
(10015, '2025-03-12 11:45:00', 'Debit Card', 19), -- Platinum Member (10%)
(10016, '2025-04-01 14:20:00', 'Credit Card', 20),-- Diamond Member (15%)
(10017, '2025-04-15 08:10:00', 'UPI', 44),        -- Trainer (25%)
(10018, '2025-05-10 19:30:00', 'Net Banking', 27),-- Gold Member (5%)
(10019, '2025-05-22 16:00:00', 'Cash', 40),       -- Walk-In Customer (0%)
(10020, '2025-06-05 10:45:00', 'Cheque', 30);     -- Diamond Member (15%)


-- ------------------------------------------
-- 2. INSERT INVOICE DETAILS (26 Rows - The Math Layer)
-- Constraint Check: DiscountApplied <= UnitPrice * Quantity
-- ------------------------------------------
INSERT INTO InvoiceDetails (InvoiceNo, ItemID, Quantity, UnitPrice, DiscountApplied) VALUES
-- 10001 (Gold 5%): Protein. 6500 * 5% = 325
(10001, 1, 1, 6500.00, 325.00),
-- 10002 (Diamond 15%): Protein. 6500 * 15% = 975
(10002, 1, 1, 6500.00, 975.00),
-- 10003 (Walk-in 0%): 5 Gatorades. 60 * 5 = 300. Discount = 0
(10003, 6, 5, 60.00, 0.00),
-- 10004 (Trainer 25%): Gym Towel. 250 * 25% = 62.50
(10004, 5, 1, 250.00, 62.50),
-- 10005 (Plat 10%): Yoga Mat. 800 * 10% = 80
(10005, 7, 1, 800.00, 80.00),
-- 10006 (Trainer 25%): Protein. 6500 * 25% = 1625
(10006, 1, 1, 6500.00, 1625.00),
-- 10007 (Gold 5%): 2 BCAAs. (1800*2) = 3600 * 5% = 180
(10007, 2, 2, 1800.00, 180.00),
-- 10008 (Walk-in 0%): 1 Shaker. Discount = 0
(10008, 3, 1, 350.00, 0.00),
-- 10009 (Diamond 15%): 3 Protein Bars. (450*3) = 1350 * 15% = 202.50
(10009, 8, 3, 450.00, 202.50),
-- 10010 (Silver 0%): 1 Belt. Discount = 0
(10010, 4, 1, 1200.00, 0.00),
-- 10011 (Trainer 25%): 10 Gatorades. (60*10) = 600 * 25% = 150
(10011, 6, 10, 60.00, 150.00),
-- 10012 (Diamond 15%): Multi-item purchase (Protein & Shaker)
(10012, 1, 1, 6500.00, 975.00),
(10012, 3, 1, 350.00, 52.50),
-- 10013 (Gold 5%): Multi-item purchase (Towel & Mat)
(10013, 5, 1, 250.00, 12.50),
(10013, 7, 1, 800.00, 40.00),
-- 10014 (Walk-in 0%): 1 BCAA. Discount = 0
(10014, 2, 1, 1800.00, 0.00),
-- 10015 (Plat 10%): 2 Protein Bars. (450*2) = 900 * 10% = 90
(10015, 8, 2, 450.00, 90.00),
-- 10016 (Diamond 15%): Multi-item purchase (BCAA & Belt)
(10016, 2, 1, 1800.00, 270.00),
(10016, 4, 1, 1200.00, 180.00),
-- 10017 (Trainer 25%): Multi-item purchase (Mat & Towel)
(10017, 7, 1, 800.00, 200.00),
(10017, 5, 1, 250.00, 62.50),
-- 10018 (Gold 5%): Protein
(10018, 1, 1, 6500.00, 325.00),
-- 10019 (Walk-in 0%): Multi-item purchase (Shaker & Gatorade)
(10019, 3, 1, 350.00, 0.00),
(10019, 6, 2, 60.00, 0.00),
-- 10020 (Diamond 15%): Belt
(10020, 4, 1, 1200.00, 180.00);


-- ------------------------------------------
-- 3. INSERT REFUNDS (20 Rows)
-- Note: Refund methods are strictly 'Cash', 'Net Banking', or 'Cheque'.
-- Note: RefundAmount strictly honors the discounted price they paid.
-- ------------------------------------------
INSERT INTO Refund (RefundId, InvoiceNo, ItemID, RefundMethod, RefundAmount, RefundDate, RefundReason) VALUES
-- Full return of Gold Protein (6500 - 325) = 6175
(1, 10001, 1, 'Net Banking', 6175.00, '2024-02-12 10:00:00', 'Allergic reaction'),
-- Full return of Diamond Protein (6500 - 975) = 5525
(2, 10002, 1, 'Net Banking', 5525.00, '2024-07-20 14:00:00', 'Seal broken on delivery'),
-- Partial return Walk-in Gatorades. Bought 5, returned 2. (60 * 2) = 120
(3, 10003, 6, 'Cash', 120.00, '2024-03-05 18:10:00', 'Bought too many'),
-- Full return of Trainer Towel (250 - 62.50) = 187.50
(4, 10004, 5, 'Net Banking', 187.50, '2024-01-22 09:00:00', 'Color mismatch'),
-- Full return Plat Yoga Mat (800 - 80) = 720
(5, 10005, 7, 'Net Banking', 720.00, '2024-08-25 10:30:00', 'Too thin'),
-- Full return Trainer Protein (6500 - 1625) = 4875
(6, 10006, 1, 'Cheque', 4875.00, '2024-09-15 11:00:00', 'Found cheaper online'),
-- Partial return Gold BCAA. Bought 2, returned 1. Price paid per tub = (1800 - 90) = 1710
(7, 10007, 2, 'Net Banking', 1710.00, '2024-10-10 16:00:00', 'Did not like flavor'),
-- Full return Walk-in Shaker. Paid 350.
(8, 10008, 3, 'Cash', 350.00, '2024-11-13 12:00:00', 'Defective lid'),
-- Full return Diamond Protein Bars. (1350 - 202.50) = 1147.50
(9, 10009, 8, 'Net Banking', 1147.50, '2024-12-05 09:30:00', 'Stale product'),
-- Full return Silver Belt. Paid 1200.
(10, 10010, 4, 'Cash', 1200.00, '2025-01-18 15:00:00', 'Wrong size'),
-- Partial return Trainer Gatorade. Bought 10, returns 2. Price paid per bottle = (60 - 15) = 45. Refund for 2 = 90.
(11, 10011, 6, 'Cash', 90.00, '2025-01-20 19:00:00', 'Changed mind'),
-- Full return Diamond Shaker from multi-item invoice. (350 - 52.50) = 297.50
(12, 10012, 3, 'Net Banking', 297.50, '2025-02-12 11:00:00', 'Cracked plastic'),
-- Full return Gold Towel from multi-item invoice. (250 - 12.50) = 237.50
(13, 10013, 5, 'Net Banking', 237.50, '2025-02-20 18:00:00', 'Frayed edges'),
-- Full return Walk-in BCAA. Paid 1800.
(14, 10014, 2, 'Cash', 1800.00, '2025-03-08 10:00:00', 'Unopened return'),
-- Partial return Plat Protein Bars. Bought 2, returns 1. Price paid per box = (450 - 45) = 405.
(15, 10015, 8, 'Net Banking', 405.00, '2025-03-15 14:30:00', 'Box crushed'),
-- Full return Diamond Belt. (1200 - 180) = 1020
(16, 10016, 4, 'Net Banking', 1020.00, '2025-04-05 09:15:00', 'Velcro ripped'),
-- Full return Trainer Yoga Mat. (800 - 200) = 600
(17, 10017, 7, 'Net Banking', 600.00, '2025-04-18 16:45:00', 'Too short'),
-- Full return Gold Protein. (6500 - 325) = 6175
(18, 10018, 1, 'Net Banking', 6175.00, '2025-05-15 11:30:00', 'Doctor recommended stopping'),
-- Full return Walk-in Shaker. Paid 350.
(19, 10019, 3, 'Cash', 350.00, '2025-05-23 10:00:00', 'Found it cheaper elsewhere'),
-- Full return Diamond Belt. (1200 - 180) = 1020
(20, 10020, 4, 'Cheque', 1020.00, '2025-06-10 14:00:00', 'Ordered wrong size online');