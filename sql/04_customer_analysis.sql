-- Ticket: SQL-004
-- TODO: Customer analysis:
-- - Customers with no delivered orders (NOT EXISTS).
-- - Customers with delivered orders (EXISTS).
-- - Products never ordered (NOT EXISTS).
-- - Use clear aliases and deterministic sorting.

-- SQL-004: Task 1 - Customer purchase summary

WITH customer_orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100.0)
        ) AS order_revenue
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.order_id, o.customer_id
)
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(co.order_id) AS delivered_orders,
    ROUND(COALESCE(SUM(co.order_revenue), 0), 2) AS total_revenue,
    ROUND(AVG(co.order_revenue), 2) AS average_order_value
FROM customers AS c
LEFT JOIN customer_orders AS co
    ON c.customer_id = co.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;
