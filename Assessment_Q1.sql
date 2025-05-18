-- Question 1: High-Value Customers with Multiple Products
-- This query identifies customers who have at least one savings and one investment plan
-- and calculates their total deposits, sorted by highest deposits.

SELECT 
    uc.id AS owner_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits
FROM users_customuser uc
LEFT JOIN plans_plan p ON uc.id = p.owner_id
LEFT JOIN savings_savingsaccount s ON uc.id = s.owner_id
GROUP BY uc.id, uc.first_name, uc.last_name
HAVING 
    savings_count >= 1 AND investment_count >= 1
ORDER BY total_deposits DESC;
