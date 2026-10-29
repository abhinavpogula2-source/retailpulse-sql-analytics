# RetailPulse SQL Analytics

Industry-style MySQL analytics portfolio project for retail revenue, customer behavior, data quality, and reporting.

## Stack
- MySQL 8.0+
- MySQL Workbench
- Git and GitHub

## Project status
This repository is a starter scaffold. SQL files contain TODOs for implementation; results should be produced from your local `retail_analytics` database rather than fabricated.

## Structure
- `docs/`: business requirements, data dictionary, metric definitions
- `sql/`: environment checks, profiling, quality checks, analytics
- `sql/tests/`: validation queries
- `reviews/`: code-review template

## Getting started
1. Open MySQL Workbench and connect to your local MySQL instance.
2. Select the database:
   ```sql
   USE retail_analytics;
   ```
3. Run `sql/00_environment_check.sql`.
4. Complete `sql/01_data_profiling.sql`.
5. Commit changes on a feature branch and submit a pull request for review.

## Safety
- Do not commit passwords, access tokens, `.env` files, or production/customer-sensitive exports.
- Do not run destructive statements against source tables for this learning project.
- Verify all row counts and metrics against the actual database.

## Git workflow
```bash
git switch -c feature/sql-001-profiling
git status
git add sql/01_data_profiling.sql
git commit -m "feat: add source table profiling"
git push -u origin feature/sql-001-profiling
```
Then open a pull request on GitHub from `feature/sql-001-profiling` to `main`.
