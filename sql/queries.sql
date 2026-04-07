-- =========================
-- Total Customers
-- =========================
SELECT COUNT(*) AS total_customers FROM churn_data;

-- =========================
-- Churn Distribution
-- =========================
SELECT `Churn Label`, COUNT(*)
FROM churn_data
GROUP BY `Churn Label`;

-- =========================
-- Churn Percentage
-- =========================
SELECT 
    `Churn Label`,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM churn_data) AS percentage
FROM churn_data
GROUP BY `Churn Label`;

-- =========================
-- Gender-wise Churn
-- =========================
SELECT Gender, `Churn Label`, COUNT(*)
FROM churn_data
GROUP BY Gender, `Churn Label`;

-- =========================
-- Avg Monthly Charges
-- =========================
SELECT `Churn Label`, AVG(`Monthly Charges`)
FROM churn_data
GROUP BY `Churn Label`;

-- =========================
-- Avg Tenure
-- =========================
SELECT `Churn Label`, AVG(`Tenure Months`)
FROM churn_data
GROUP BY `Churn Label`;

-- =========================
-- Contract Type Analysis
-- =========================
SELECT `Contract`, `Churn Label`, COUNT(*)
FROM churn_data
GROUP BY `Contract`, `Churn Label`;

-- =========================
-- Internet Service Analysis
-- =========================
SELECT `Internet Service`, `Churn Label`, COUNT(*)
FROM churn_data
GROUP BY `Internet Service`, `Churn Label`;

-- =========================
-- High Value Customers
-- =========================
SELECT CustomerID, `Monthly Charges`
FROM churn_data
ORDER BY `Monthly Charges` DESC
LIMIT 10;

-- =========================
-- Filtering Example
-- =========================
SELECT *
FROM churn_data
WHERE `Churn Label` = 'Yes';

-- =========================
-- CASE Example
-- =========================
SELECT 
    CustomerID,
    `Monthly Charges`,
    CASE 
        WHEN `Monthly Charges` > 70 THEN 'High'
        ELSE 'Low'
    END AS spending_category
FROM churn_data;