
-- Ticket: SQL-002
-- Purpose: Audit customer data quality
-- Rule: Read-only checks; do not modify source data

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)
        AS missing_customer_ids,
    SUM(CASE WHEN first_name IS NULL
                   OR TRIM(first_name) = ''
             THEN 1 ELSE 0 END) AS missing_first_names,
    SUM(CASE WHEN email IS NULL
                   OR TRIM(email) = ''
             THEN 1 ELSE 0 END) AS missing_emails,
    SUM(CASE WHEN signup_date IS NULL
             THEN 1 ELSE 0 END) AS missing_signup_dates
FROM customers;
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;
SELECT
    LOWER(TRIM(email)) AS normalized_email,
    COUNT(*) AS occurrences
FROM customers
WHERE email IS NOT NULL
  AND TRIM(email) <> ''
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;
SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END)
        AS missing_order_dates
FROM orders;
