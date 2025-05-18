-- Question 4: Customer Lifetime Value (CLV) Estimation
-- This query estimates CLV for each customer based on their tenure and transaction behavior.
-- The profit per transaction is assumed to be 0.1% of transaction value.

SELECT 
    uc.id AS customer_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    -- Calculate customer tenure in months
    TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()) AS tenure_months,
    -- Total number of transactions made by the customer
    COUNT(ss.id) AS total_transactions,
    -- Calculate CLV using the formula:
    -- CLV = (Total Transactions / Tenure) * 12 * Average Profit per Transaction
    ROUND(
        (COUNT(ss.id) / 
        GREATEST(TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()), 1)) 
        * 12 * (AVG(ss.confirmed_amount) * 0.001) / 100, 2
    ) AS estimated_clv
FROM users_customuser uc
LEFT JOIN savings_savingsaccount ss ON uc.id = ss.owner_id
GROUP BY uc.id, uc.first_name, uc.last_name, uc.date_joined
ORDER BY estimated_clv DESC;
