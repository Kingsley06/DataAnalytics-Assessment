# DataAnalytics-Assessment
Submission for Data Analyst SQL Assessment
# Data Analyst Assessment

## 📖 Overview  
This repository contains solutions to the Data Analyst SQL Assessment. Each SQL file answers a specific question, including well-commented code and optimized queries to handle large datasets efficiently.

---

## 📂 Files  
- `Question1.sql`: High-Value Customers with Multiple Products  
- `Question2.sql`: Transaction Frequency Analysis  
- `Question3.sql`: Account Inactivity Alert  
- `Question4.sql`: Customer Lifetime Value (CLV) Estimation  

---

## ✅ **Per-Question Explanations**

### Question 1: High-Value Customers with Multiple Products  
- **Objective**: Identify customers who own at least one savings plan and one investment plan, and calculate their total deposits.  
- **Approach**:  
    - Used `LEFT JOIN` to connect customers with their plans and deposits.  
    - Utilized `CASE WHEN` to count savings and investment products separately.  
    - Converted `confirmed_amount` from kobo to Naira.  
    - Filtered customers meeting both product conditions and ordered by deposit value.  

---

### Question 2: Transaction Frequency Analysis  
- **Objective**: Classify customers based on their average monthly transaction frequency into Low, Medium, or High Frequency groups.  
- **Approach**:  
    - Calculated average monthly transactions using `TIMESTAMPDIFF` and `GREATEST` to avoid division by zero.  
    - Categorized customers using a `CASE` statement based on their calculated monthly averages.  
    - Aggregated results to show how many customers fall into each category.

---

### Question 3: Account Inactivity Alert  
- **Objective**: Identify active accounts with no transactions in the last 365 days.  
- **Approach**:  
    - Used a CTE (`WITH inactive_owners AS (...)`) to pre-filter inactive account owners.  
    - Performed an efficient `JOIN` to extract details of inactive plans.  
    - Calculated `inactivity_days` using `DATEDIFF` and presented the latest transaction date.

---

### Question 4: Customer Lifetime Value (CLV) Estimation  
- **Objective**: Estimate Customer Lifetime Value using a simplified CLV formula based on transaction volume and tenure.  
- **Approach**:  
    - Calculated tenure in months with `TIMESTAMPDIFF`.  
    - Used `GREATEST` to handle customers with less than one month tenure.  
    - Applied the CLV formula directly within the query using the given profit margin (0.1%).  
    - Converted amounts from kobo to Naira and displayed the final value rounded to 2 decimal places.

---

## 🚧 **Challenges Encountered & Resolutions**

- **Handling Large Datasets**:  
  - Queries initially timed out due to heavy joins on large datasets.  
  - Solution: Used CTEs and filtered subqueries to reduce the number of rows processed before performing expensive operations.

- **MySQL Limitations (IN with LIMIT)**:  
  - Faced errors when using `LIMIT` within an `IN` clause.  
  - Solution: Replaced `IN (SELECT...) LIMIT` with a CTE and `JOIN` approach, which improved performance and compatibility.

- **Division by Zero in CLV Calculation**:  
  - For new customers, tenure was less than 1 month, leading to division errors.  
  - Solution: Used `GREATEST(..., 1)` to ensure a minimum divisor of 1.

---

## 👤 **Author**
- **Name**: *Ayozie Kingsley*  

---

Thank you for reviewing this submission. Please feel free to reach out for any clarifications or further discussions.
