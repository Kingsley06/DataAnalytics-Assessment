-- Question 2: Transaction Frequency Analysis
-- This query calculates the average number of transactions per month for each customer
-- and classifies them into Low, Medium, or High Frequency segments.

SELECT 
    CASE 
        WHEN monthly_avg >= 10 THEN 'High Frequency'
        WHEN monthly_avg BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    -- Calculate average transactions per month within each frequency group
    ROUND(AVG(monthly_avg), 2) AS avg_transactions_per_month
FROM (
    SELECT 
        s.owner_id,
        -- Calculate average monthly transactions per customer
        COUNT(s.id) / GREATEST(TIMESTAMPDIFF(MONTH, MIN(s.created_on), MAX(s.created_on)), 1) AS monthly_avg
    FROM savings_savingsaccount s
    GROUP BY s.owner_id
) AS subquery
GROUP BY frequency_category;
