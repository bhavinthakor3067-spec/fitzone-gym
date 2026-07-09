SET SEARCH_PATH TO gym;

-- ----------------------------------------------
-- - ⚪ Level 1: Filtering, Sorting, and Limits -
-- ----------------------------------------------

/* 1. List all active Members sorted by the newest joiners. */
SELECT FirstName, LastName, JoinDate, Email 
FROM Member 
ORDER BY JoinDate DESC;

/* 2. Find the top 3 most expensive Gym Plans. (LIMIT & ORDER BY) */
SELECT PlanName, DurationMonths, PlanPrice 
FROM Plan 
ORDER BY PlanPrice DESC 
LIMIT 3;

/* 3. Show all Trainers with a rating above 4.5 who charge less than 
12% commission. (Multiple WHERE conditions) */
SELECT TrainerName, TrainerRating, CommissionRate 
FROM Trainer 
WHERE TrainerRating > 4.5 AND CommissionRate < 12.00;

/* 4. Find all Members born in the 1990s (Date Filtering) */
SELECT FirstName, LastName, DateOfBirth 
FROM Member 
WHERE DateOfBirth BETWEEN '1990-01-01' AND '1999-12-31';


/* 5. Find Retail Items that are running low on stock (less than 30) to reorder. */
SELECT ItemName, StockQuantity 
FROM Items 
WHERE StockQuantity < 30 
ORDER BY StockQuantity ASC;

-- -------------------------------------------------
-- - 🟢 Level 2: Aggregation, GROUP BY, and HAVING -
-- -------------------------------------------------

/* 6. What is the total expected revenue from all currently 
active Subscriptions? (SUM) */
SELECT SUM(BillingAmount) AS TotalActiveRevenue 
FROM Subscription 
WHERE Status = 'A';

/* 7. How many members are male, female, or other? (GROUP BY, COUNT) */
SELECT Gender, COUNT(*) AS MemberCount 
FROM Member 
GROUP BY Gender;

/* 8. Which Pincodes have more than 3 members residing in them? (GROUP BY, HAVING) */
SELECT Pincode, COUNT(MemberID) AS ResidentCount 
FROM Member 
GROUP BY Pincode 
HAVING COUNT(MemberID) > 3;

/* 9. What is the average Purchase Cost of Equipment per Category? (AVG, GROUP BY) */
SELECT EquipmentCategory, AVG(PurchaseCost) AS AvgCost 
FROM Equipment 
GROUP BY EquipmentCategory;

/* 10. Find the total penalty amounts collected from Cancelled subscriptions. (SUM) */
SELECT SUM(PenaltyAmount) AS TotalPenalties 
FROM Cancellation;

/* 11. Which retail item categories have a total combined stock of 
more than 50 units? (HAVING) */
SELECT Category, SUM(StockQuantity) AS TotalStock 
FROM Items 
GROUP BY Category 
HAVING SUM(StockQuantity) > 50;

-- ----------------------------------------------
-- - 🔵 Level 3: Standard Joins (1 and 2 Joins) -
-- ----------------------------------------------

/* 12. Show every Member's Name alongside their actual City (District) 
and State. (1 JOIN) */
SELECT M.FirstName, M.LastName, L.District, L.State 
FROM Member M
JOIN Location L ON M.Pincode = L.Pincode;

/* 13. Show the Plan Name for every Active Subscription. (1 JOIN) */
SELECT S.SubscriptionID, P.PlanName, S.StartDate 
FROM Subscription S
JOIN Plan P ON S.PlanID = P.PlanID
WHERE S.Status = 'A';

/* 14. List all Equipment and the Categories they belong to. (1 JOIN) */
SELECT E.Name, C.CategoryName, E.EquipmentStatus
FROM Equipment E
JOIN Category C ON E.EquipmentCategory = C.CategoryName;

/* 15. Display Member Names, the Plan they purchased, and 
their Subscription Status. (2 JOINS) */
SELECT M.FirstName, M.LastName, P.PlanName, S.Status
FROM Subscription S
JOIN Member M ON S.MemberID = M.MemberID
JOIN Plan P ON S.PlanID = P.PlanID;

/* 16. Show Invoice Details: Invoice No, Item Name, Quantity, and the 
Final Price Paid after discount. (2 JOINS) */
SELECT ID.InvoiceNo, I.ItemName, ID.Quantity, 
       ((ID.UnitPrice * ID.Quantity) - ID.DiscountApplied) AS FinalPricePaid
FROM InvoiceDetails ID
JOIN Items I ON ID.ItemID = I.ItemID;

-- ---------------------------------------------
-- - 🟣 Level 4: Complex Deep Joins (3+ Joins) -
-- ---------------------------------------------

/* 17. Which Trainer is assigned to which Member, and for what Plan? (3 JOINS) */
SELECT T.TrainerName, M.FirstName AS MemberName, P.PlanName, S.StartDate
FROM Subscription S
JOIN Trainer T ON S.TrainerID = T.TrainerID
JOIN Member M ON S.MemberID = M.MemberID
JOIN Plan P ON S.PlanID = P.PlanID;

/* 18. What specific Equipment Categories does the 'Platinum II' plan 
grant access to? (3 JOINS) */
SELECT P.PlanName, C.CategoryName
FROM Plan P
JOIN PlanEquipmentAccess PEA ON P.PlanID = PEA.PlanID
JOIN Category C ON PEA.EquipmentCategory = C.CategoryName
WHERE P.PlanName = 'Platinum II';

/* 19. Fetch a complete Refund Receipt: Member ID, Refund Date, Item Name, 
and Refund Amount. (3 JOINS)*/
SELECT B.MemberID, R.RefundDate, I.ItemName, R.RefundAmount, R.RefundReason
FROM Refund R
JOIN InvoiceDetails ID ON R.InvoiceNo = ID.InvoiceNo AND R.ItemID = ID.ItemID
JOIN Invoice INV ON R.InvoiceNo = INV.InvoiceNo
JOIN Buyer B ON INV.BuyerID = B.BuyerID
JOIN Items I ON ID.ItemID = I.ItemID;

/* 20. Track Attendance: Show the Member's Name, Plan Name, 
and every Check-In Timestamp. (3 JOINS) */
SELECT M.FirstName, P.PlanName, A.CheckInTimeStamp
FROM Attendance A
JOIN Subscription S ON A.SubscriptionID = S.SubscriptionID
JOIN Member M ON S.MemberID = M.MemberID
JOIN Plan P ON S.PlanID = P.PlanID
ORDER BY A.CheckInTimeStamp DESC;

-- -----------------------------------------------
-- - 🟡 Level 5: The Polymorphic Query Challenge -
-- -----------------------------------------------

/* 21. Retail Sales Report: Show the Invoice Date, Item Name, and 
the Name of the Walk-In Customer who bought it. */
SELECT INV.InvoiceDate, I.ItemName, W.CustomerName
FROM Invoice INV
JOIN Buyer B ON INV.BuyerID = B.BuyerID
JOIN WalkInCustomer W ON B.CustomerID = W.CustomerID
JOIN InvoiceDetails ID ON INV.InvoiceNo = ID.InvoiceNo
JOIN Items I ON ID.ItemID = I.ItemID;

/* 22. Trainer Retail Purchases: What supplements or gear did our own Trainers buy? */
SELECT T.TrainerName, I.ItemName, ID.Quantity, ID.DiscountApplied
FROM Invoice INV
JOIN Buyer B ON INV.BuyerID = B.BuyerID
JOIN Trainer T ON B.TrainerID = T.TrainerID
JOIN InvoiceDetails ID ON INV.InvoiceNo = ID.InvoiceNo
JOIN Items I ON ID.ItemID = I.ItemID;

/* 23. The Ultimate Polymorphic Receipt: Show ALL purchases and dynamically 
display the buyer's name whether they are a Member, Customer, or Trainer 
using COALESCE */
SELECT INV.InvoiceNo, I.ItemName, 
       COALESCE(M.FirstName, W.CustomerName, T.TrainerName) AS BuyerName,
       B.Type AS BuyerRole
FROM Invoice INV
JOIN Buyer B ON INV.BuyerID = B.BuyerID
LEFT JOIN Member M ON B.MemberID = M.MemberID
LEFT JOIN WalkInCustomer W ON B.CustomerID = W.CustomerID
LEFT JOIN Trainer T ON B.TrainerID = T.TrainerID
JOIN InvoiceDetails ID ON INV.InvoiceNo = ID.InvoiceNo
JOIN Items I ON ID.ItemID = I.ItemID;

-- ------------------------------------------
-- - 🟠 Level 6: Outer Joins (LEFT / RIGHT) -
-- ------------------------------------------

/* 24. Find all Gym Plans that currently have ZERO active or 
past Subscriptions. (LEFT JOIN with NULL check) */
SELECT P.PlanName 
FROM Plan P
LEFT JOIN Subscription S ON P.PlanID = S.PlanID
WHERE S.SubscriptionID IS NULL;

/* 25. Find Walk-In Customers who have registered their contact info 
but have NEVER made a retail purchase. */
SELECT W.CustomerName, W.PhoneNumber, W.Email
FROM WalkInCustomer W
LEFT JOIN Buyer B ON W.CustomerID = B.CustomerID
LEFT JOIN Invoice INV ON B.BuyerID = INV.BuyerID
WHERE INV.InvoiceNo IS NULL;

/* 26. List ALL Items in inventory and any invoices associated with them, 
including items that have never been sold. */
SELECT I.ItemName, ID.InvoiceNo, ID.Quantity
FROM Items I
LEFT JOIN InvoiceDetails ID ON I.ItemID = ID.ItemID;

/* 27. Find Members who have NO Attendance records 
(They bought a sub but never showed up!). */
SELECT M.FirstName, M.LastName
FROM Member M
JOIN Subscription S ON M.MemberID = S.MemberID
LEFT JOIN Attendance A ON S.SubscriptionID = A.SubscriptionID
WHERE A.CheckInTimeStamp IS NULL;

/* 28. List all Trainers and total Subscriptions they manage, 
including Trainers managing 0 members. */
SELECT T.TrainerName, COUNT(S.SubscriptionID) AS ManagedMembers
FROM Trainer T
LEFT JOIN Subscription S ON T.TrainerID = S.TrainerID
GROUP BY T.TrainerName;

-- ---------------------------------------------------------
-- - 🔴 Level 7: Set Operations (UNION, INTERSECT, EXCEPT) -
-- ---------------------------------------------------------

/* 29. Marketing Blast: Get a single, massive list of EVERY unique Email address in
 the entire system (Members, Walk-ins, Trainers). (UNION) */
SELECT Email, 'Member' AS Role FROM Member WHERE Email IS NOT NULL
UNION
SELECT Email, 'Customer' AS Role FROM WalkInCustomer WHERE Email IS NOT NULL
UNION
SELECT Email, 'Trainer' AS Role FROM Trainer WHERE Email IS NOT NULL;

/* 30. Find Pincodes where BOTH a Member lives AND a Trainer lives. (INTERSECT) */
SELECT Pincode FROM Member
INTERSECT
SELECT Pincode FROM Trainer;

/* 31. Find Locations (Pincodes) that we have in our database, but NO Members
currently live there. (EXCEPT / MINUS) */
SELECT Pincode FROM Location
EXCEPT
SELECT Pincode FROM Member;

/* 32. Get a combined list of all cancelled subscriptions AND 
all refunded items. (UNION) */
SELECT 'Subscription Cancelled' AS Event, CancellationDate AS EventDate, Reason FROM Cancellation
UNION
SELECT 'Item Refunded' AS Event, RefundDate AS EventDate, RefundReason FROM Refund;

-- -------------------------------------------------
-- - 🟤 Level 8: Subqueries and Correlated Queries -
-- -------------------------------------------------

/* 33. Find the Member(s) who bought the most expensive Plan. */
SELECT M.FirstName, M.LastName, S.BillingAmount
FROM Member M
JOIN Subscription S ON M.MemberID = S.MemberID
WHERE S.BillingAmount = (SELECT MAX(BillingAmount) FROM Subscription);

/* 34. Find Retail Items whose selling price is higher than the overall
average selling price. */
SELECT ItemName, SellingPrice 
FROM Items 
WHERE SellingPrice > (SELECT AVG(SellingPrice) FROM Items);

/* 35. List Trainers whose commission rate is above the average commission rate 
of all Trainers. */
SELECT TrainerName, CommissionRate
FROM Trainer
WHERE CommissionRate > (SELECT AVG(CommissionRate) FROM Trainer);

/* 36. Find all Invoices where the total discount applied to the line items was 
greater than ₹500. (Correlated Subquery) */
SELECT InvoiceNo, InvoiceDate 
FROM Invoice INV
WHERE (SELECT SUM(DiscountApplied) 
       FROM InvoiceDetails ID 
       WHERE ID.InvoiceNo = INV.InvoiceNo) > 500;
	   
-- -----------------------------------
-- - ⚫ Level 9: Realtional Division -
-- -----------------------------------

/* 37. Relational Division 1: Find the Plan(s) that grant access to 
EVERY SINGLE Equipment Category in the gym. */
SELECT P.PlanName 
FROM Plan P
WHERE NOT EXISTS (
    SELECT C.CategoryName 
    FROM Category C
    WHERE NOT EXISTS (
        SELECT 1 
        FROM PlanEquipmentAccess PEA 
        WHERE PEA.PlanID = P.PlanID 
        AND PEA.EquipmentCategory = C.CategoryName
    )
);

/* 38. Relational Division 2: Find Members who have purchased EVERY supplement
currently available in the 'Supplements' category. */
SELECT M.FirstName, M.LastName
FROM Member M
WHERE NOT EXISTS (
    SELECT I.ItemID 
    FROM Items I 
    WHERE I.Category = 'Supplements'
    AND NOT EXISTS (
        SELECT 1
        FROM Buyer B
        JOIN Invoice INV ON B.BuyerID = INV.BuyerID
        JOIN InvoiceDetails ID ON INV.InvoiceNo = ID.InvoiceNo
        WHERE B.MemberID = M.MemberID AND ID.ItemID = I.ItemID
    )
);

-- -----------------------------------------
-- - ⭕ Level 10: Extra Analytical Queries -
-- -----------------------------------------

/* 39. Advanced Analytics: Rank Trainers by the total revenue generated
from the Subscriptions they manage. */
SELECT T.TrainerName, SUM(S.BillingAmount) AS TotalRevenueGenerated
FROM Trainer T
JOIN Subscription S ON T.TrainerID = S.TrainerID
GROUP BY T.TrainerName
ORDER BY TotalRevenueGenerated DESC;

/* 40. Churn Risk: Find Members whose subscriptions are active, but they haven't
attended the gym in the last 30 days. */
SELECT M.FirstName, M.LastName, S.SubscriptionID
FROM Member M
JOIN Subscription S ON M.MemberID = S.MemberID
WHERE S.Status = 'A' 
AND S.SubscriptionID NOT IN (
    SELECT SubscriptionID 
    FROM Attendance 
    WHERE CheckInTimeStamp >= CURRENT_DATE - INTERVAL '30 DAYS'
);