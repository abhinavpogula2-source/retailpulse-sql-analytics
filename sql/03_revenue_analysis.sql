-- Ticket: SQL-003
-- TODO: Monthly delivered revenue after discounts.
-- Formula: quantity * unit_price * (1 - discount_pct / 100)
-- Requirements:
-- - Filter orders to order_status = 'Delivered'.
-- - Group by calendar month.
-- - Use explicit column names and chronological ordering.
-- - Document the metric definition and grain.
select * from orders;
select * from order_items;
select * from payments;
select 
   date_format(o.order_date,'%Y-%m') as month_sale,
  round( sum(oi.unit_price*oi.quantity*(1-oi.discount_pct/100)),0) as total_revenue
from orders o inner join order_items oi on o.order_id=oi.order_id
group by o.order_date;

-- SQL-003: Task 2 - Compare order revenue with payments

WITH order_revenue AS (
    SELECT
        order_id,
        SUM(
            quantity * unit_price
            * (1 - discount_pct / 100.0)
        ) AS net_revenue
    FROM order_items
    GROUP BY order_id
),
payment_totals AS (
    SELECT
        order_id,
        SUM(
            CASE
                WHEN payment_status = 'Completed'
                THEN payment_amount
                ELSE 0
            END
        ) AS completed_payment_amount
    FROM payments
    GROUP BY order_id
)
SELECT
    o.order_id,
    ROUND(COALESCE(r.net_revenue, 0), 2) AS net_revenue,
    ROUND(COALESCE(p.completed_payment_amount, 0), 2)
        AS completed_payment_amount,
    ROUND(
        COALESCE(r.net_revenue, 0)
        - COALESCE(p.completed_payment_amount, 0),
        2
    ) AS revenue_payment_difference
FROM orders AS o
LEFT JOIN order_revenue AS r
    ON o.order_id = r.order_id
LEFT JOIN payment_totals AS p
    ON o.order_id = p.order_id
ORDER BY o.order_id;

-- SQL-003: Task 3 - Rank products by net revenue

WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100.0)
        ) AS net_revenue
    FROM products AS p
    INNER JOIN order_items AS oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
)
SELECT
    product_id,
    product_name,
    category,
    ROUND(net_revenue, 2) AS net_revenue,
    DENSE_RANK() OVER (
        ORDER BY net_revenue DESC
    ) AS revenue_rank
FROM product_revenue
ORDER BY revenue_rank, product_name;

-- SQL-003: Task 4 - Monthly delivered-order revenue

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100.0)
        ),
        2
    ) AS net_revenue
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;

-- SQL-003: Task 5 - Inspect payment statuses

SELECT
    payment_status,
    COUNT(*) AS payment_records,
    ROUND(SUM(payment_amount), 2) AS total_payment_amount
FROM payments
GROUP BY payment_status
ORDER BY payment_status;

-- SQL-003: Task 5 - Validate item-level revenue totals

SELECT
    oi.order_id,
    COUNT(*) AS order_item_rows,
    SUM(oi.quantity) AS total_units,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100.0)
        ),
        2
    ) AS independently_calculated_revenue
FROM order_items AS oi
GROUP BY oi.order_id
ORDER BY oi.order_id;







   
   
    
    
