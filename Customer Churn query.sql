CREATE DATABASE customer_churn;
USE customer_churn;

SELECT * FROM `final project`
LIMIT 10;

ALTER TABLE `final project`
RENAME TO final_project;

SELECT * FROM final_project
LIMIT 5;

SHOW COLUMNS FROM final_project;

ALTER TABLE final_project
RENAME COLUMN `ï»¿Customer ID` TO `Customer ID`;

DESCRIBE final_project;

SELECT VERSION();

#total no. of customers
SELECT COUNT(`Customer ID`) AS Total_Customers FROM final_project;

#total churned customers
SELECT COUNT(`Customer ID`) AS Total_Churned_Customers FROM final_project
WHERE Churn = "Yes";

#churn rate
SELECT
ROUND(
COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project;

#avg monthly charges
SELECT 
ROUND(
AVG(`Monthly Charges`),2)
AS Avg_Monthly_Charges
FROM final_project;
 
#avg tenure
SELECT ROUND(AVG(`Tenure(in Months)`),2) AS Avg_Tenure FROM final_project;

#customer count by gender
SELECT Gender, COUNT(*) AS Total_Customers FROM final_project
GROUP BY Gender;

#churn rate by gender
SELECT Gender,
ROUND(
COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY Gender; 

#senior citizen distribution
SELECT `Senior Citizen`, COUNT(*) AS Total_Customers
FROM final_project
GROUP BY `Senior Citizen`;

#churn rate among senior citizens
SELECT `Senior Citizen`,
ROUND(
COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY `Senior Citizen`;

#customers by contract type
SELECT `Contract`, COUNT(*) AS Total_Customers
FROM final_project
GROUP BY `Contract`;

#churn rate by contract type
SELECT `Contract`, 
ROUND(
COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY `Contract`;

#Highest Churn Contract Type
SELECT `Contract`, COUNT(Churn) AS Churned_Customers FROM final_project
WHERE Churn = "Yes"
GROUP BY `Contract`
ORDER BY Churned_Customers DESC;

#Customers by Payment Method
SELECT `Payment Method`, COUNT(*) AS Total_Customers FROM final_project
GROUP BY `Payment Method`;

#Churn Rate by Payment Method
SELECT `Payment Method`,
ROUND(
COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY `Payment Method`;

#Customers by Internet Service
SELECT `Internet Service`, COUNT(*) AS Total_Customers FROM final_project
GROUP BY `Internet Service`
ORDER BY Total_Customers DESC;

#Churn Rate by Internet Service
SELECT `Internet Service`,
ROUND(
COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY `Internet Service`
ORDER BY Churn_Rate DESC;

#Average Tenure of Churned Customers
SELECT ROUND(AVG(`Tenure(in Months)`),2) AS Avg_Tenure FROM final_project
WHERE Churn = "Yes";

#Average Tenure of Retained Customers
SELECT ROUND(AVG(`Tenure(in Months)`),2) AS Avg_Tenure FROM final_project
WHERE Churn = "No";

#Tenure Group Analysis
#I already made this Tenure Group in python and the table imported here has this column but this is how I should build if not made in python
SELECT 
CASE
WHEN `Tenure(in Months)` <= 12 THEN "0-1 year"
WHEN `Tenure(in Months)` BETWEEN 13 AND 24 THEN "1-2 years"
WHEN `Tenure(in Months)` BETWEEN 25 AND 48 THEN "2-4 years"
WHEN `Tenure(in Months)` BETWEEN 49 AND 72 THEN "4-6 years"
END AS Tenure_Group,
COUNT(*) FROM final_project
GROUP BY Tenure_Group
ORDER BY Tenure_Group;

#Churn Rate by Tenure Group
-- SELECT
-- CASE
-- WHEN `Tenure(in Months)` <= 12 THEN "0-1 year"
-- WHEN `Tenure(in Months)` BETWEEN 13 AND 24 THEN "1-2 years"
-- WHEN `Tenure(in Months)` BETWEEN 25 AND 48 THEN "2-4 years"
-- WHEN `Tenure(in Months)` BETWEEN 49 AND 72 THEN "4-6 years"
-- END AS Tenure_Group,
SELECT `Tenure Group`, 
ROUND(COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY `Tenure Group`
ORDER BY `Tenure Group`;

#Total revenue
SELECT ROUND(SUM(`Total Charges`),2) AS Total_Revenue FROM final_project;

#Revenue Lost Due to Churn
SELECT ROUND(SUM(`Total Charges`),2) AS Revenue_Lost FROM final_project
WHERE Churn = "Yes";

#Average Monthly Charges by Churn Status
SELECT Churn, ROUND(AVG(`Monthly Charges`),2) AS Avg_Monthly_Charges FROM final_project
GROUP BY Churn;

#Churn Rate by Tech Support
SELECT `Tech Support`, 
ROUND(COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY `Tech Support`;

#Churn Rate by Online Security
SELECT `Online Security`, 
ROUND(COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY `Online Security`;

#Churn Rate by Streaming TV
SELECT `Streaming TV`, 
ROUND(COUNT(CASE WHEN Churn = "Yes" THEN 1 END)*100/
COUNT(*),2)
AS Churn_Rate
FROM final_project
GROUP BY `Streaming TV`;

#Top 5 Highest Spending Customers
SELECT * FROM final_project
ORDER BY `Total Charges` DESC
LIMIT 5;

#Rank Customers by Revenue
SELECT `Customer ID`, `Total Charges`,
RANK() OVER(ORDER BY `Total Charges` DESC) AS Revenue_Rank
FROM final_project;

#Contract Type Contributing Most Revenue
SELECT `Contract`, ROUND(SUM(`Total Charges`),2) AS Revenue FROM final_project
GROUP BY `Contract`
ORDER BY Revenue DESC;

#Customer Segment with Highest Churn
SELECT `Contract`, `Internet Service`, COUNT(Churn) AS Customer_churned FROM final_project
WHERE Churn = "Yes"
GROUP BY `Contract`, `Internet Service`
ORDER BY Customer_churned DESC;