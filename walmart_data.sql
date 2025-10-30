/*
STEP 1: CREATE AND USE DATABASE
*/

CREATE DATABASE walmart;
USE walmart;

/*
STEP 2: DATA CLEANING – FIX DATE COLUMN FORMAT
*/

-- Check sample data
SELECT * FROM walmart.walmart LIMIT 10;

-- Add a new clean date column
ALTER TABLE walmart.walmart
ADD COLUMN date_clean DATE;

-- Convert text-based date (DD-MM-YYYY) to MySQL DATE format
UPDATE walmart.walmart
SET date_clean = STR_TO_DATE(Date, '%Y-%m-%d');

-- Verify conversion
SELECT Date, date_clean FROM walmart.walmart LIMIT 10;

-- Drop old text column and rename the new one
ALTER TABLE walmart.walmart
DROP COLUMN Date;

ALTER TABLE walmart.walmart
CHANGE COLUMN date_clean Date DATE;

-- Confirm the cleaned date range of the dataset
SELECT 
    MIN(Date) AS start_date,
    MAX(Date) AS end_date,
    DATEDIFF(MAX(Date), MIN(Date)) AS total_days
FROM walmart.walmart;


/*-------------------------------------------------------------
STEP 3: STORE PERFORMANCE ANALYSIS
--------------------------------------------------------------*/

-- Total and average weekly sales per store
SELECT 
    Store,
    SUM(Weekly_Sales) AS Total_Sales,
    AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM walmart.walmart
GROUP BY Store
ORDER BY Total_Sales DESC;

-- Rank stores from highest to lowest total sales
SELECT 
    Store,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Rank_Position
FROM (
    SELECT 
        Store, 
        SUM(Weekly_Sales) AS Total_Sales
    FROM walmart.walmart
    GROUP BY Store
) AS ranked_stores;


/*-------------------------------------------------------------
STEP 4: HOLIDAY IMPACT ANALYSIS
--------------------------------------------------------------*/

-- Compare total and average weekly sales during holiday vs non-holiday weeks
SELECT 
    Store,
    Holiday_Flag,
    SUM(Weekly_Sales) AS Total_Sales,
    AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM walmart.walmart
GROUP BY Store, Holiday_Flag
ORDER BY Store, Holiday_Flag;


/*-------------------------------------------------------------
STEP 5: TIME-BASED SALES ANALYSIS
--------------------------------------------------------------*/

-- Monthly sales per store (identify store-level seasonality)
select store, sum(weekly_sales),
MONTHNAME(Date) 
from walmart.walmart 
group by monthname(date),store;

-- Total monthly sales across all stores (find most profitable months)/highest sale month
SELECT 
    MONTHNAME(Date) AS Month,
    SUM(Weekly_Sales) AS Total_Monthly_Sales
FROM walmart.walmart
GROUP BY MONTHNAME(Date)
ORDER BY Total_Monthly_Sales DESC;

-- Yearly and monthly trend (for both seasonality and overall growth)
SELECT 
    YEAR(Date) AS Year,
    MONTHNAME(MIN(Date)) AS Month,
    SUM(Weekly_Sales) AS Total_Sales
FROM walmart.walmart
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, MONTH(MIN(Date));

/*-------------------------------------------------------------
STEP 6: FACTOR-WISE IMPACT ON SALES
--------------------------------------------------------------*/

-- Temperature vs Sales
SELECT 
    CASE 
        WHEN Temperature < 40 THEN 'Cold'
        WHEN Temperature BETWEEN 40 AND 70 THEN 'Moderate'
        ELSE 'Hot'
    END AS Temperature_Range,
    ROUND(AVG(Weekly_Sales), 2) AS Avg_Sales
FROM walmart.walmart
GROUP BY Temperature_Range
ORDER BY Avg_Sales DESC;

-- Fuel Price vs Sales
SELECT 
    CASE 
        WHEN Fuel_Price < 2.8 THEN 'Low'
        WHEN Fuel_Price BETWEEN 2.8 AND 3.2 THEN 'Medium'
        ELSE 'High'
    END AS Fuel_Range,
    ROUND(AVG(Weekly_Sales), 2) AS Avg_Sales
FROM walmart.walmart
GROUP BY Fuel_Range
ORDER BY Avg_Sales DESC;

-- CPI vs Sales
SELECT 
    CASE 
        WHEN CPI < 200 THEN 'Low'
        WHEN CPI BETWEEN 200 AND 220 THEN 'Medium'
        ELSE 'High'
    END AS CPI_Level,
    ROUND(AVG(Weekly_Sales), 2) AS Avg_Sales
FROM walmart.walmart
GROUP BY CPI_Level
ORDER BY Avg_Sales DESC;

-- Holiday vs Non-Holiday Sales
SELECT 
    Holiday_Flag,
    ROUND(AVG(Weekly_Sales), 2) AS Avg_Sales
FROM walmart.walmart
GROUP BY Holiday_Flag;



