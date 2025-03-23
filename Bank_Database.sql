-- Branch Table
CREATE TABLE Branches 
(
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(255),
    Address VARCHAR(255),
    State VARCHAR(100),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    PhoneNumber VARCHAR(20)
);


SELECT * FROM Branches

-- Customer Table
CREATE TABLE Customers 
(
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    PostalCode VARCHAR(20),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255),
    AccountType VARCHAR(50), -- e.g., Savings, Checking, Credit
    AccountNumber VARCHAR(50) UNIQUE,
    BranchID INT
);

SELECT * FROM Customers

-- Transactions Table
CREATE TABLE Transactions 
(
TransactionID INT PRIMARY KEY,
CustomerID INT,
AccountNumber VARCHAR(25),
TransactionDate DATE,
TransactionAmount DECIMAL(18, 2),
TransactionType VARCHAR(50), -- e.g., Deposit, Withdrawal, Transfer, Payment
TransactionDescription VARCHAR(100)
);

SELECT * FROM transactions

--Date Dimension Table (for time-based analysis)
CREATE TABLE DateDimension 
(
    DateID DATE PRIMARY KEY,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT,
    DayOfWeek INT,
    DayName VARCHAR(20),
    MonthName VARCHAR(20),
    QuarterName VARCHAR(10),
    YearMonth VARCHAR(7),
    YearQuarter VARCHAR(7)
);

SELECT * FROM DateDimension

-- Churn Analysis Table (example, may require more columns depending on analysis)
CREATE TABLE ChurnAnalysis 
(
    CustomerID INT PRIMARY KEY,
    LastInteractionDate DATE,
    ServiceUsage INT, -- e.g., number of logins, transactions
    CustomerSatisfaction INT, -- e.g., survey scores
    ChurnFlag BOOLEAN, -- 1 if churned, 0 if not
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

