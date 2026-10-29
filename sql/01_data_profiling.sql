SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION all

SELECT 'products', COUNT(*) FROM products
 union all
SELECT 'orders', COUNT(*) FROM orders
union all
SELECT 'order_items', COUNT(*) FROM order_items
union all
SELECT 'payments', COUNT(*) FROM payments;