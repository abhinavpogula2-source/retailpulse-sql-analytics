# Data Dictionary

Expected source tables in the existing `retail_analytics` database:

## customers
- `customer_id`: customer identifier
- `first_name`, `last_name`: customer name fields
- `email`: unique email
- `city`, `state`: customer location
- `signup_date`: signup date
- `created_at`: record creation timestamp

## products
- `product_id`: product identifier
- `product_name`: product name
- `category`: product category
- `unit_price`: listed unit price
- `stock_quantity`: inventory quantity
- `is_active`: active/inactive indicator
- `created_at`: record creation timestamp

## orders
- `order_id`: order identifier
- `customer_id`: customer foreign key
- `order_date`: order date/time
- `order_status`: order status
- `shipping_city`: shipping destination city
- `created_at`: record creation timestamp

## order_items
- `order_item_id`: order line identifier
- `order_id`: order foreign key
- `product_id`: product foreign key
- `quantity`: units ordered
- `unit_price`: item unit price at order time
- `discount_pct`: discount percentage
- Unique constraint expected on `(order_id, product_id)`

## payments
- `payment_id`: payment identifier
- `order_id`: order foreign key
- `payment_date`: payment date/time
- `payment_method`: payment method
- `payment_amount`: amount recorded for the payment
- `payment_status`: payment status
- `transaction_reference`: unique transaction reference

> Confirm these definitions with `DESCRIBE` and database metadata before treating them as authoritative. Schema names can vary between environments.
