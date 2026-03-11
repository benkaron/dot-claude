# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This repository contains SQL scripts for managing AWS Redshift database objects and data analysis tools for comparing MRR (Monthly Recurring Revenue) data between Stripe and Redshift.

### Directory Structure

- `functions/` - Redshift SQL functions for calculations (SLA, hours, backlog counting)
- `views/` - Redshift SQL views for business metrics and data transformations
- `tables/` - Table creation scripts for Redshift
- `historical_data_upserts/` - SQL scripts for hourly data updates via cron
- `scripts/` - Shell scripts for database operations
- `data_analysis/` - Python scripts and Jupyter notebooks for data analysis

### Data Pipeline

The repository implements a scheduled data pipeline:
1. Functions are deployed first (dependencies for views)
2. Views are deployed second (some views depend on others like MRR history)
3. Historical data upserts run hourly via AWS Lambda + EventBridge
4. The main materialized view `view_mrr_by_customer_by_day` is critical for the Business Metrics dashboard

### View Dependencies

- Ensure the `view_mrr_by_customer_by_day` has an example dependent view associated with it to demonstrate view interdependencies and testing strategies

## Commands

### SQL Deployment
SQL objects are automatically deployed via GitHub Actions on merge to master and scheduled cron (twice daily at 8:30 and 20:30 UTC).

Manual deployment requires:
- PostgreSQL client (`psql`)
- Tailscale VPN connection
- Environment variables: `REDSHIFT_ENDPOINT`, `REDSHIFT_USERNAME`, `REDSHIFT_PASSWORD`, `REDSHIFT_PORT`

### Data Analysis
For MRR comparison analysis:
```bash
python data_analysis/mrr_comparison_stripe_redshift.py --stripe-file path/to/stripe.csv --redshift-query "SELECT * FROM view_mrr_by_customer_by_month"
```

Required environment variables:
- `REDSHIFT_USERNAME`
- `REDSHIFT_PASSWORD` 
- `REDSHIFT_HOST`
- `REDSHIFT_DATABASE`

### View Creation Guidelines
- Use `CREATE OR REPLACE VIEW view_[name] AS` syntax
- Include `WITH NO SCHEMA BINDING` at the end to prevent Airbyte sync failures
- Test views manually in TablePlus before submitting PR
- Views with `view_` prefix are automatically organized in Redshift

### Dependencies
- Python: pandas, numpy, psycopg2
- PostgreSQL client for SQL execution
- Tailscale for VPN access to Redshift
- AWS credentials for GitHub Actions deployment