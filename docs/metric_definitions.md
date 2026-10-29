# Metric Definitions

Documented starter definitions. Confirm business rules with stakeholders before publishing.

## Delivered item revenue after discounts
At order-item grain:
`quantity * unit_price * (1 - discount_pct / 100)`

Monthly delivered revenue is the sum of this expression for order items belonging to orders whose `order_status = 'Delivered'`.

## Active customer by month
A customer with at least one order in a calendar month. Count each customer once per month.

## Month-over-month revenue change
`current_month_revenue - previous_month_revenue`

## Month-over-month percentage change
`(current_month_revenue - previous_month_revenue) / previous_month_revenue * 100`
Use `NULLIF(previous_month_revenue, 0)` to prevent division by zero.

## Cohort retention
Active customers from a signup cohort in a given activity month divided by the original cohort size, multiplied by 100. Decide whether activity means any order or delivered orders before publishing results.

## Payment reconciliation
Payment totals and item revenue are different measures. Filter payment statuses according to an agreed business definition. Aggregate payments and order-item revenue separately before joining them to order-level reports to avoid fan-out.
