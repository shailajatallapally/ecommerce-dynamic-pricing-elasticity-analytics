CREATE DATABASE apple_products_db;

USE apple_products_db;

CREATE TABLE apple_products_pricing (
    Date DATE,
    Platform VARCHAR(50),
    Product_Category VARCHAR(100),
    Model_Name VARCHAR(255),
    Product_Condition VARCHAR(50),
    Launch_Price_USD DECIMAL(10,2),
    Launch_Price_INR DECIMAL(12,2),
    Current_Price_USD DECIMAL(10,2),
    Current_Price_INR DECIMAL(12,2),
    Discount_Pct DECIMAL(5,2),
    Sale_Event VARCHAR(100),
    Stock_Status VARCHAR(50),
    Rating DECIMAL(3,2),
    Reviews_Count INT
);

USE apple_products_db;

CREATE TABLE platform_lookup (
     platform_ID INT 
AUTO_INCREMENT PRIMARY KEY,
    platform VARCHAR (50)
);    
INSERT INTO platform_lookup
(platform)
SELECT DISTINCT Platform
FROM apple_products_pricing;

SELECT 
     a.Model_Name,
     a.Platform,
     p.Platform_ID
FROM apple_products_pricing a JOIN platform_lookup p 
ON a.Platform = p.Platform;   

CREATE TABLE category_lookup (
    Category_ID INT 
AUTO_INCREMENT PRIMARY KEY,
   Product_Category VARCHAR(100)
);
INSERT INTO category_lookup
(Product_category)   
SELECT DISTINCT
Product_Category
FROM apple_products_pricing;

SELECT 
     a.Model_Name,
     a.Product_Category,
     c.Category_ID
FROM apple_products_pricing a JOIN
category_lookup c 
ON a.Product_Category = 
c.Product_Category;     
   
SELECT
    Product_Category,
    COUNT(*) AS Total_Products,
    AVG(Launch_Price_USD) AS Avg_Launch_Price_USD,
    AVG(Launch_Price_INR) AS Avg_Launch_Price_INR,
    AVG(Current_Price_USD) AS Avg_Current_Price_USD,
    MIN(Current_Price_USD) AS Min_Current_Price_USD,
    MAX(Current_Price_USD) AS Max_Current_Price_USD
FROM apple_products_pricing
GROUP BY Product_Category; 

SELECT
    Stock_Status,
    COUNT(*) AS Total_Products,
    AVG(Launch_Price_USD) AS Avg_Launch_Price_USD,
    AVG(Launch_Price_INR) AS Avg_Launch_Price_INR,
    AVG(Current_Price_USD) AS Avg_Current_Price_USD,
    MIN(Current_Price_USD) AS Min_Current_Price_USD,
    MAX(Current_Price_USD) AS Max_Current_Price_USD
FROM apple_products_pricing
GROUP BY Stock_Status;  

SELECT
    Product_Category,
    Stock_Status,
    COUNT(*) AS Total_Products,
    AVG(Launch_Price_USD) AS Avg_Launch_Price_USD,
    AVG(Launch_Price_INR) AS Avg_Launch_Price_INR,
    AVG(Current_Price_USD) AS Avg_Current_Price_USD
FROM apple_products_pricing
GROUP BY Product_Category, Stock_Status;

 KPI 1:Total Products
 SELECT COUNT(*) AS 
 Total_Products
 FROM apple_products_pricing;
 
 KPI 2 :Average Launch Price (USD & INR)
 SELECT
    AVG(Launch_Price_USD) AS Avg_Launch_Price_USD,
    AVG(Launch_Price_INR) AS Avg_Launch_Price_INR
FROM apple_products_pricing;

KPI 3:Average Current Price (USD)
SELECT AVG(Current_Price_USD) AS Avg_Current_Price_USD
FROM apple_products_pricing;

KPI 4: Average Discount Percentage
SELECT AVG(Discount_Pct) AS Avg_Discount_Percentage
FROM apple_products_pricing;

KPI 5: Product Count by Category
SELECT
    Product_Category,
    COUNT(*) AS Total_Products
FROM apple_products_pricing
GROUP BY Product_Category;

KPI 6: Products by Stock Status
SELECT
    Stock_Status,
    COUNT(*) AS Total_Products
FROM apple_products_pricing
GROUP BY Stock_Status;
KPI 7: Highest Current Price
SELECT
    Model_Name,
    Current_Price_USD
FROM apple_products_pricing
ORDER BY Current_Price_USD DESC
LIMIT 1;
KPI 8: Highest Rated Product
SELECT
    Model_Name,
    Rating
FROM apple_products_pricing
ORDER BY Rating DESC

-- Create SQL views for Top KPI'savepoint
 USE apple_products_db;
 
 - View 1 : Average price by product category
 
CREATE VIEW vw_avg_price AS 
SELECT 
	 Product_Category,
     AVG(Launch_Price_USD) AS Avg_Launch_Price,
	 AVG(Current_Price_INR) AS Avg_Current_Price
FROM apple_products_pricing
GROUP BY Product_Category;

SELECT * FROM vw_avg_price;


-- View 2 : Stock summary 
CREATE VIEW vw_stock_status AS
SELECT
	Stock_Status,
	COUNT(*) AS Total_Products
FROM apple_products_pricing
GROUP BY Stock_Status;

SELECT * FROM vw_stock_status;     

--View 3 : Average rating;
CREATE VIEW vw_avg_rating AS
SELECT 
    Product_Category,
    AVG(Rating) AS Average_rating
FROM apple_products_pricing
GROUP BY Product_Category; 

SELECT * FROM vw_avg_rating;   

-- WINDOWS FUNCTIONS

- Running total 
SELECT 
    Date,
    Launch_Price_USD,
    SUM(Launch_Price_USD)OVER(ORDER BY date) AS Running_Total
FROM apple_products_pricing;

-- Row_Number :
SELECT 
Model_Name, Launch_Price_USD,
ROW_NUMBER() OVER(ORDER BY Launch_Price_USD DESC) AS Row_Num
FROM apple_products_pricing;
      
-- RANK()
SELECT
Model_Name, Launch_Price_USD,
RANK() OVER(ORDER BY Launch_Price_USD DESC) AS Price_Rank
FROM apple_products_pricing; 

-- DENSE RANK
SELECT
     Model_Name, 
     Launch_Price_USD,
	 DENSE_RANK() OVER(ORDER 
BY Launch_Price_USD DESC) AS
'Dense_Rank'
FROM apple_products_pricing;    
     
-- LAG()
SELECT
    Date,Current_Price_USD,LAG(Current_Price_USD)
    OVER(ORDER BY Date) AS Previous_Price
FROM apple_products_pricing;    

-- LEAD()
SELECT
    Date,Current_Price_USD,LEAD(Current_Price_USD)
    OVER(ORDER BY Date) AS Next_Price
FROM apple_products_pricing; 

   
    -- Create README : 
Day 10 - SQL Views and window functions

Tasks completed 
1. Created SQL Views
- Avg pRICE VIEW
- Stock status view
- Average Rating view

2. Practiced window functions
- ROW_NUMBER
- RANK()
- DENSE_RANK
- RANK()
- LAG()
- LEAD()
- Running total

Dataset : apple products pricing

Tool : MySQL Workbench