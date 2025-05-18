-- Question 3: Account Inactivity Alert
-- This query identifies plans with no inflow transactions for over one year (365 days).
-- It includes both savings and investment plans, along with inactivity details.

WITH inactive_owners AS (
    SELECT owner_id
    FROM savings_savingsaccount 
    GROUP BY owner_id 
    HAVING 
        -- Select owners who have no transactions or last transaction was over a year ago
        MAX(created_on) IS NULL 
        OR MAX(created_on) < CURDATE() - INTERVAL 365 DAY
)
SELECT 
    p.id AS plan_id,
    p.owner_id,
    -- Determine the type of plan
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type,
    -- Get the most recent transaction date for the plan
    MAX(s.created_on) AS last_transaction_date,
    -- Calculate inactivity in days
    DATEDIFF(CURDATE(), MAX(s.created_on)) AS inactivity_days
FROM plans_plan p
JOIN inactive_owners io ON p.owner_id = io.owner_id
LEFT JOIN savings_savingsaccount s ON p.owner_id = s.owner_id
GROUP BY p.id, p.owner_id, p.is_regular_savings, p.is_a_fund;
