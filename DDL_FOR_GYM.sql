CREATE TABLE Location(
	Pincode CHAR(6) PRIMARY KEY,
	District VARCHAR(20) NOT NULL,
	State VARCHAR(20) NOT NULL
);

CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(40) NOT NULL,
    MiddleName VARCHAR(40),
    LastName VARCHAR(40) NOT NULL,
    Gender CHAR(1),
    DateOfBirth DATE,
    AddressLine_1 VARCHAR(255) NOT NULL,
    AddressLine_2 VARCHAR(255) NOT NULL,
    Pincode CHAR(6) NOT NULL,
    JoinDate DATE NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    PhoneNumber CHAR(10) UNIQUE NOT NULL,
	CONSTRAINT fk_member_location FOREIGN KEY(Pincode) REFERENCES Location(Pincode) ON UPDATE CASCADE,
    CONSTRAINT chk_gender CHECK (Gender IN ('M', 'F', 'O'))
);

CREATE TABLE Plan (
    PlanID CHAR(2) PRIMARY KEY,
    PlanName VARCHAR(20) UNIQUE NOT NULL,
    DurationMonths INT,
    PlanPrice INT,
    PlanDiscountPercentage DECIMAL(4,2),
    CONSTRAINT chk_planprice CHECK (PlanPrice > 0),
    CONSTRAINT chk_durationmonths CHECK (DurationMonths > 0)
);

CREATE TABLE Trainer (
    TrainerID INT PRIMARY KEY,
    TrainerName VARCHAR(40) NOT NULL,
    PhoneNumber CHAR(10) UNIQUE NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Gender CHAR(1),
    Pincode CHAR(6) NOT NULL, 
    JoinDate DATE NOT NULL,
    TrainerRating DECIMAL(3,2) NOT NULL,
    CommissionRate DECIMAL(4,2) NOT NULL,
    ExperienceYears INT NOT NULL,
    CONSTRAINT fk_trainer_location FOREIGN KEY (Pincode) REFERENCES Location(Pincode) ON UPDATE CASCADE,
    CONSTRAINT chk_gender CHECK (Gender IN ('M', 'F', 'O')),
    CONSTRAINT chk_trainer_rating CHECK (TrainerRating >= 0 AND TrainerRating <= 5.0)
);

CREATE TABLE WalkInCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(40) NOT NULL,
    PhoneNumber CHAR(10) UNIQUE NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Items (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(70) NOT NULL,
    Category VARCHAR(40),
    SellingPrice DECIMAL(10,2),
    PurchasePrice DECIMAL(10,2),
    StockQuantity INT NOT NULL,
    CONSTRAINT chk_positive_selling_price CHECK (SellingPrice >= 0),
    CONSTRAINT chk_positive_purchase_price CHECK (PurchasePrice >= 0)
);

CREATE TABLE Buyer (
    BuyerID INT PRIMARY KEY,
    MemberID INT UNIQUE,
    CustomerID INT UNIQUE,
    TrainerID INT UNIQUE,
    Type CHAR(1) NOT NULL,
    CONSTRAINT fk_buyer_member FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    CONSTRAINT fk_buyer_customer FOREIGN KEY (CustomerID) REFERENCES WalkInCustomer(CustomerID),
    CONSTRAINT fk_buyer_trainer FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID),
    CONSTRAINT chk_buyer_exclusive CHECK (
    (MemberID IS NOT NULL AND CustomerID IS NULL AND TrainerID IS NULL AND Type='M') OR
    (MemberID IS NULL AND CustomerID IS NOT NULL AND TrainerID IS NULL AND Type='C') OR
    (MemberID IS NULL AND CustomerID IS NULL AND TrainerID IS NOT NULL AND Type='T')
    )
);

CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY,
    PlanID CHAR(2) NOT NULL,
    MemberID INT NOT NULL,
    TrainerID INT,
    Status CHAR(1) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    CONSTRAINT fk_sub_plan FOREIGN KEY (PlanID) REFERENCES Plan(PlanID) ON UPDATE CASCADE,
    CONSTRAINT fk_sub_member FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    CONSTRAINT fk_sub_trainer FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID),
    CONSTRAINT chk_sub_dates CHECK (EndDate >= StartDate),
    CONSTRAINT chk_sub_status CHECK (Status IN ('A', 'I', 'C'))
);

CREATE TABLE Cancellation (
    CancellationID INT PRIMARY KEY,
    SubscriptionID INT UNIQUE NOT NULL,
    CancellationDate DATE NOT NULL,
    Reason VARCHAR(100),
    PenaltyAmount INT NOT NULL,
    RefundStatus CHAR(1) NOT NULL,
    CONSTRAINT fk_cancel_sub FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID) ON DELETE CASCADE,
    CONSTRAINT chk_refund_status CHECK (RefundStatus IN ('P', 'D', 'C')),
    CONSTRAINT chk_penaltyamount CHECK (PenaltyAmount >= 0)
);

CREATE TABLE Attendance (
    SubscriptionID INT,
    CheckInTimeStamp TIMESTAMP, 
    PRIMARY KEY (SubscriptionID, CheckInTimeStamp),
    CONSTRAINT fk_attendance_sub FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID) ON DELETE CASCADE
);

CREATE TABLE Invoice (
    InvoiceNo INT PRIMARY KEY,
    InvoiceDate DATE NOT NULL,
    ActualAmount DECIMAL(10,2),
    TotalDiscountApplied DECIMAL(10,2),
    BuyerID INT NOT NULL,
    CONSTRAINT fk_invoice_buyer FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
    CONSTRAINT chk_actualamount CHECK (ActualAmount >= 0),
    CONSTRAINT chk_totaldiscountapplied CHECK (TotalDiscountApplied >= 0)
);

CREATE TABLE InvoiceDetails (
    InvoiceNo INT,
    ItemID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    DiscountApplied DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (InvoiceNo, ItemID),
    CONSTRAINT fk_invdet_invoice FOREIGN KEY (InvoiceNo) REFERENCES Invoice(InvoiceNo) ON DELETE CASCADE,
    CONSTRAINT fk_invdet_item FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    CONSTRAINT chk_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_unitprice CHECK (UnitPrice > 0),
    CONSTRAINT chk_discountapplied CHECK (DiscountApplied >= 0)
);

CREATE TABLE Refund (
    RefundId INT PRIMARY KEY,
    InvoiceNo INT NOT NULL,
    ItemID INT NOT NULL,
    RefundAmount DECIMAL(10,2) NOT NULL,
    RefundDate DATE NOT NULL,
    RefundReason VARCHAR(100),
	CONSTRAINT unique_fk UNIQUE (InvoiceNo, ItemID),
    CONSTRAINT fk_refund_invdet FOREIGN KEY (InvoiceNo, ItemID) REFERENCES InvoiceDetails(InvoiceNo, ItemID),
    CONSTRAINT chk_refundamount CHECK (RefundAmount >= 0)
);