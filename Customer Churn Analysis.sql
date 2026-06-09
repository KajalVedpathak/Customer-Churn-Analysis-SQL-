CREATE DATABASE churn_analysis;
USE churn_analysis;

CREATE TABLE telco_churn (
    customer_id VARCHAR(50),
    gender VARCHAR(10),
    senior_citizen INT,
    partner VARCHAR(10),
    dependents VARCHAR(10),
    tenure INT,
    phone_service VARCHAR(10),
    multiple_lines VARCHAR(20),
    internet_service VARCHAR(20),
    online_security VARCHAR(20),
    online_backup VARCHAR(20),
    device_protection VARCHAR(20),
    tech_support VARCHAR(20),
    streaming_tv VARCHAR(20),
    streaming_movies VARCHAR(20),
    contract VARCHAR(20),
    paperless_billing VARCHAR(10),
    payment_method VARCHAR(50),
    monthly_charges FLOAT,
    total_charges FLOAT,
    churn VARCHAR(10)
);

SELECT * FROM telco_churn LIMIT 10;
---Total Customers----
SELECT COUNT(*) AS total_customers 
FROM telco_churn;
 
 SELECT * 
FROM telco_churn
WHERE total_charges IS NULL;

SELECT COUNT(*) FROM telco_churn;

----Unique Customers (check duplicates)----
SELECT COUNT(DISTINCT customer_id) 
FROM telco_churn;

----Churn Distribution----
SELECT churn, COUNT(*) 
FROM telco_churn
GROUP BY churn;

----Churn Rate-----
SELECT 
    COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM telco_churn;

SELECT 
    ROUND(
        COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*), 
    2) AS churn_rate_percentage
FROM telco_churn;

----Churnby Contract----
SELECT 
    contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM telco_churn
GROUP BY contract;

SELECT 
    contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(
        SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    2) AS churn_rate
FROM telco_churn
GROUP BY contract;

----Churn by Tenure----
SELECT 
    CASE 
        WHEN tenure < 12 THEN '0-1 Year'
        WHEN tenure < 24 THEN '1-2 Years'
        ELSE '2+ Years'
    END AS tenure_group,
    COUNT(*) AS total,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM telco_churn
GROUP BY tenure_group;

SELECT 
    CASE 
        WHEN tenure < 12 THEN '0-1 Year'
        WHEN tenure < 24 THEN '1-2 Years'
        ELSE '2+ Years'
    END AS tenure_group,
    COUNT(*) AS total,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(
        SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    2) AS churn_rate
FROM telco_churn
GROUP BY tenure_group;

------Churn by Payment Method------
SELECT 
    payment_method,
    COUNT(*) AS total,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM telco_churn
GROUP BY payment_method;


--- Revenue loss----

DESC telco_churn;

SELECT 
    SUM(total_charges) AS revenue_lost
FROM telco_churn
WHERE churn='Yes';

----High Risk Customers----
SELECT 
    customer_id,
    tenure,
    monthly_charges
FROM telco_churn
WHERE churn='Yes'
AND tenure < 12;


-----------------------I performed churn analysis on telecom data using SQL. I calculated churn rate, 
segmented customers by tenure and contract type, identified high-risk customers,
and estimated revenue loss. This helped in understanding key factors driving customer churn.---------




