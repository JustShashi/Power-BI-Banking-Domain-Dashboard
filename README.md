# **Banking Data Analysis with Power BI**

This project demonstrates a banking data analysis workflow using Power BI. It includes data generation, database setup, data import using Python, and basic Power BI modeling.

## **Project Structure**

Banking-Data-Analysis/  
├── banking\_data.xlsx      \# Sample banking data in Excel format  
├── database\_setup.sql    \# SQL queries to create the database tables  
├── README.md             \# Project documentation (this file)  
├── generate\_data.py      \# Python script to generate the Excel data  
├── import\_data.py        \# Python script to import Excel data into the database

## **Getting Started**

1. **Generate Sample Data:**  
   * Run the generate\_data.py script to create the banking\_data.xlsx file.  
     python generate\_data.py

   * This script generates Excel data that corresponds to the SQL table structure.

\# generate\_data.py  
import pandas as pd  
import random  
from datetime import datetime, timedelta

def generate\_banking\_data(num\_customers=100, num\_transactions=500, start\_date=datetime(2023, 1, 1), end\_date=datetime(2024, 12, 31), num\_branches=5):  
    """Generates sample banking data and saves it to Excel files.

    Args:  
        num\_customers (int): The number of customers to generate.  
        num\_transactions (int): The number of transactions to generate.  
        start\_date (datetime): The start date for the data range.  
        end\_date (datetime): The end date for the data range.  
        num\_branches (int): The number of branches  
    Returns:  
        str: The path to the generated Excel file.  
    """  
    \# Branches Data  
    branches\_data \= {  
        'BranchID': range(1, num\_branches \+ 1),  
        'BranchName': \[f'Branch {i}' for i in range(1, num\_branches \+ 1)\],  
        'Address': \[f'{random.randint(100, 999)} Main St' for \_ in range(num\_branches)\],  
        'City': random.choices(\['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'\], k=num\_branches),  
        'State': random.choices(\['NY', 'CA', 'IL', 'TX', 'AZ'\], k=num\_branches),  
        'PostalCode': \[f'{random.randint(10000, 99999)}' for \_ in range(num\_branches)\],  
        'PhoneNumber': \[f'({random.randint(100, 999)}) {random.randint(100, 999)}-{random.randint(1000, 9999)}' for \_ in range(num\_branches)\]  
    }  
    branches\_df \= pd.DataFrame(branches\_data)

    \# Customers Data  
    customers\_data \= {  
        'CustomerID': range(1, num\_customers \+ 1),  
        'FirstName': \[random.choice(\['Alice', 'Bob', 'Charlie', 'David', 'Eve'\]) for \_ in range(num\_customers)\],  
        'LastName': \[random.choice(\['Smith', 'Johnson', 'Williams', 'Brown', 'Jones'\]) for \_ in range(num\_customers)\],  
        'DateOfBirth': \[start\_date \+ timedelta(days=random.randint(0, 365 \* 60)) for \_ in range(num\_customers)\],  
        'Gender': random.choices(\['Male', 'Female'\], k=num\_customers),  
        'Address': \[f'{random.randint(100, 999)} Oak St' for \_ in range(num\_customers)\],  
        'City': random.choices(\['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'\], k=num\_customers),  
        'State': random.choices(\['NY', 'CA', 'IL', 'TX', 'AZ'\], k=num\_customers),  
        'PostalCode': \[f'{random.randint(10000, 99999)}' for \_ in range(num\_customers)\],  
        'PhoneNumber': \[f'({random.randint(100, 999)}) {random.randint(100, 999)}-{random.randint(1000, 9999)}' for \_ in range(num\_customers)\],  
        'Email': \[f'user{i}@example.com' for i in range(num\_customers)\],  
        'AccountType': random.choices(\['Savings', 'Checking', 'Credit'\], k=num\_customers),  
        'AccountNumber': \[f'ACC{random.randint(10000000, 99999999)}' for \_ in range(num\_customers)\],  
        'BranchID': random.choices(range(1, num\_branches \+ 1), k=num\_customers)  
    }  
    customers\_df \= pd.DataFrame(customers\_data)

    \# Transactions Data  
    transactions\_data \= {  
        'TransactionID': range(1, num\_transactions \+ 1),  
        'CustomerID': random.choices(range(1, num\_customers \+ 1), k=num\_transactions),  
        'AccountNumber': \[customers\_df\['AccountNumber'\].iloc\[random.randint(0, num\_customers \- 1)\] for \_ in range(num\_transactions)\],  
        'TransactionDate': \[start\_date \+ timedelta(days=random.randint(0, (end\_date \- start\_date).days)) for \_ in range(num\_transactions)\],  
        'TransactionAmount': \[round(random.uniform(-1000, 5000), 2\) for \_ in range(num\_transactions)\],  
        'TransactionType': random.choices(\['Deposit', 'Withdrawal', 'Transfer', 'Payment'\], k=num\_transactions),  
        'TransactionDescription': \[random.choice(\['Grocery', 'ATM Withdrawal', 'Online Transfer', 'Bill Payment'\]) for \_ in range(num\_transactions)\]  
    }  
    transactions\_df \= pd.DataFrame(transactions\_data)

    \# Churn Analysis Data  
    churn\_data \= {  
        'CustomerID': range(1, num\_customers \+ 1),  
        'LastInteractionDate': \[start\_date \+ timedelta(days=random.randint(0, (end\_date \- start\_date).days)) for \_ in range(num\_customers)\],  
        'ServiceUsage': \[random.randint(1, 100\) for \_ in range(num\_customers)\],  
        'CustomerSatisfaction': \[random.randint(1, 5\) for \_ in range(num\_customers)\],  
        'ChurnFlag': random.choices(\[True, False\], k=num\_customers)  
    }  
    churn\_df \= pd.DataFrame(churn\_data)

    \# Date Dimension Data  
    date\_range \= pd.date\_range(start=start\_date, end=end\_date)  
    date\_data \= {  
        'DateID': date\_range,  
        'Year': date\_range.year,  
        'Quarter': date\_range.quarter,  
        'Month': date\_range.month,  
        'Day': date\_range.day,  
        'DayOfWeek': date\_range.dayofweek,  
        'DayName': date\_range.day\_name(),  
        'MonthName': date\_range.month\_name(),  
        'QuarterName': \['Q' \+ str(q) for q in date\_range.quarter\],  
        'YearMonth': date\_range.strftime('%Y-%m'),  
        'YearQuarter': date\_range.to\_period('Q').strftime('%Y-Q%q')  
    }  
    date\_df \= pd.DataFrame(date\_data)

    \# Save to Excel files  
    with pd.ExcelWriter('banking\_data.xlsx') as writer:  
        branches\_df.to\_excel(writer, sheet\_name='Branches', index=False)  
        customers\_df.to\_excel(writer, sheet\_name='Customers', index=False)  
        transactions\_df.to\_excel(writer, sheet\_name='Transactions', index=False)  
        churn\_df.to\_excel(writer, sheet\_name='ChurnAnalysis', index=False)  
        date\_df.to\_excel(writer, sheet\_name='DateDimension', index=False)

    return "banking\_data.xlsx"

if \_\_name\_\_ \== "\_\_main\_\_":  
    excel\_file\_path \= generate\_banking\_data()  
    print(f"Excel file '{excel\_file\_path}' created successfully.")

2. **Set up the Database:**  
   * Create a database (e.g., in MySQL, PostgreSQL, SQL Server).  
   * Execute the SQL queries in database\_setup.sql to create the necessary tables.

\-- database\_setup.sql  
\-- Customer Table  
CREATE TABLE Customers (  
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
    AccountType VARCHAR(50),  \-- e.g., Savings, Checking, Credit  
    AccountNumber VARCHAR(50) UNIQUE,  
    BranchID INT,  
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)  
);

\-- Transactions Table  
CREATE TABLE Transactions (  
    TransactionID INT PRIMARY KEY,  
    CustomerID INT,  
    AccountNumber VARCHAR(50),  
    TransactionDate DATE,  
    TransactionAmount DECIMAL(18, 2),  
    TransactionType VARCHAR(50),  \-- e.g., Deposit, Withdrawal, Transfer, Payment  
    TransactionDescription VARCHAR(255),  
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),  
    FOREIGN KEY (AccountNumber) REFERENCES Customers(AccountNumber)  
);

\-- Date Dimension Table (for time-based analysis)  
CREATE TABLE DateDimension (  
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

\-- Branches Table  
CREATE TABLE Branches (  
    BranchID INT PRIMARY KEY,  
    BranchName VARCHAR(255),  
    Address VARCHAR(255),  
    City VARCHAR(100),  
    State VARCHAR(100),  
    PostalCode VARCHAR(20),  
    PhoneNumber VARCHAR(20)  
);

\-- Churn Analysis Table (example, may require more columns depending on analysis)  
CREATE TABLE ChurnAnalysis (  
    CustomerID INT PRIMARY KEY,  
    LastInteractionDate DATE,  
    ServiceUsage INT,  \-- e.g., number of logins, transactions  
    CustomerSatisfaction INT,  \-- e.g., survey scores  
    ChurnFlag BOOLEAN,  \-- 1 if churned, 0 if not  
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)  
);

\-- Example of how to populate the Date Dimension Table  
CREATE PROCEDURE PopulateDateDimension(  
    @StartDate DATE,  
    @EndDate DATE  
)  
AS  
BEGIN  
    DECLARE @CurrentDate DATE \= @StartDate;

    WHILE @CurrentDate \<= @EndDate  
    BEGIN  
        INSERT INTO DateDimension (  
            DateID,  
            Year,  
            Quarter,  
            Month,  
            Day,  
            DayOfWeek,  
            DayName,  
            MonthName,  
            QuarterName,  
            YearMonth,  
            YearQuarter  
        )  
        VALUES (  
            @CurrentDate,  
            YEAR(@CurrentDate),  
            DATEPART(QUARTER, @CurrentDate),  
            MONTH(@CurrentDate),  
            DAY(@CurrentDate),  
            DATEPART(WEEKDAY, @CurrentDate),  
            DATENAME(WEEKDAY, @CurrentDate),  
            DATENAME(MONTH, @CurrentDate),  
            'Q' \+ CAST(DATEPART(QUARTER, @CurrentDate) AS VARCHAR(10)),  
            FORMAT(@CurrentDate, 'yyyy-MM'),  
            FORMAT(DATEADD(qq, DATEPART(qq, @CurrentDate) \- 1, DATEADD(yy, DATEDIFF(yy, 0, @CurrentDate), 0)), 'yyyy-QQ')  
        );

        SET @CurrentDate \= DATEADD(DAY, 1, @CurrentDate);  
    END  
END;

\-- Example Execution of the Date Dimension Population Procedure  
EXEC PopulateDateDimension '2020-01-01', '2025-12-31';

3. **Import Data into the Database:**  
   * Run the import\_data.py script to import data from banking\_data.xlsx into the database.  
   * Make sure to replace the connection details with your database credentials.

\# import\_data.py  
import pandas as pd  
import sqlalchemy

def import\_excel\_to\_database(excel\_file, database\_uri):  
    """Imports data from an Excel file into a database.

    Args:  
        excel\_file (str): The path to the Excel file.  
        database\_uri (str): The database connection URI.  
    """  
    engine \= sqlalchemy.create\_engine(database\_uri)

    with pd.ExcelFile(excel\_file) as xls:  
        for sheet\_name in xls.sheet\_names:  
            df \= pd.read\_excel(xls, sheet\_name=sheet\_name)  
            df.to\_sql(sheet\_name, engine, if\_exists='replace', index=False)  
            print(f"Imported {sheet\_name} successfully.")

if \_\_name\_\_ \== "\_\_main\_\_":  
    excel\_file \= "banking\_data.xlsx"  
    \# Example database connection string (replace with your actual credentials)  
    \#  The following are examples.  YOU MUST CHANGE THE USERNAME, PASSWORD,  
    \#  HOST, PORT and DATABASE NAME to match your database.  
    \#  The general form is:  
    \#  dialect+driver://username:password@host:port/database  
    \#  where the dialect is one of:  
    \#  'mysql', 'postgresql', 'mssql', 'sqlite', etc.  
    \#  and the driver is specific to the database.  
    database\_uri \= "mysql+pymysql://user:password@host/database"  \# Example for MySQL.  
    \# database\_uri \= "postgresql://user:password@host:port/database"  \# Example for PostgreSQL.  
    \# database\_uri \= "mssql+pyodbc://user:password@dsn"  \# Example for SQL Server.  Requires a DSN.  
    \# database\_uri \= "sqlite:///mydatabase.db" \# Example for SQLite

    import\_excel\_to\_database(excel\_file, database\_uri)

4. **Power BI Setup:**  
   * Open Power BI Desktop.  
   * Connect to your database.  
   * Import the necessary tables (Customers, Transactions, DateDimension, Branches, ChurnAnalysis).  
   * Create relationships between the tables based on the foreign keys defined in the database schema.  
   * Build your Power BI data model and create visualizations.

## **Power BI Analysis**

This project can be used to perform various banking data analyses, such as:

* Customer transaction analysis.  
* Customer segmentation.  
* Churn prediction.  
* Branch performance analysis.  
* Time-based trend analysis.

## **Contributing**

Contributions are welcome\! Feel free to submit pull requests or open issues to improve this project.

## Author - JustShashi

This project is part of my portfolio, showcasing the skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!


- **LinkedIn**: [Connect with me professionally]([www.linkedin.com/in/venkata-manikanta-sasank-reddy-ramireddy-a7158730b](https://www.linkedin.com/in/venkata-manikanta-sasank-reddy-ramireddy-a7158730b/))

Thank you for your support, and I look forward to connecting with you!
