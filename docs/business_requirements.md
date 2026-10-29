# Business Requirements — RetailPulse

## Business context
RetailPulse is a fictional e-commerce retailer. Teams need consistent, auditable SQL reporting for sales, customer activity, and data quality.

## Goals
1. Produce a documented monthly delivered-revenue metric.
2. Identify high-performing products and categories.
3. Analyze customer ordering behavior and inactivity.
4. Track monthly revenue trends using window functions.
5. Build cohort activity and retention reports.
6. Validate data quality and prevent join fan-out/double counting.

## Functional requirements
- Queries must use explicit column lists rather than `SELECT *` in production-style reports.
- Business filters and metric assumptions must be documented.
- Aggregations must be at the correct grain.
- Queries joining order items and payments must pre-aggregate each side when necessary to prevent double counting.
- Analytics queries must use deterministic ordering where ties matter.
- Results must be tested against the actual database.

## Non-functional requirements
- SQL should be readable and consistently formatted.
- Source tables must not be modified by profiling/reporting queries.
- Each ticket should be committed separately on a feature branch.
- Pull requests should include purpose, testing performed, and assumptions.
