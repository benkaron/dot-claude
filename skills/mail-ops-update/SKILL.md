---
name: mail-ops-update
description: Updates Stable's mail processing operations numbers from Gusto exports and deploys to production. Use when updating ops numbers, processing Gusto exports, deploying mail metrics, or running the weekly ops update.
disable-model-invocation: true
---

# Mail Ops Update Skill

This skill helps update mail processing operations numbers when receiving new Gusto exports, streamlining the weekly update process for Stable's processing centers (NYC and DFW1).

## Overview

Updates employee hours and mail metrics data from Gusto exports for reporting in Metabase. This process feeds critical operational dashboards for NYC and DFW1 processing centers.

## Quick Update Process (5 minutes)

### 1. Export from Gusto

1. Log into Gusto
2. Navigate to **Reports → Time Tracking**
3. Export as CSV (saves as `mistro-inc-time-tracking-hours-YYYY-MM-DD.csv`)
4. Save to Downloads folder

### 2. Parse the Export

```bash
cd ~/sbox/git/stable-analytics-dbt

# Auto-detect files in Downloads (recommended)
python scripts/parse_gusto_export.py

# Or specify file directly
python scripts/parse_gusto_export.py ~/Downloads/mistro-inc-time-tracking-hours-2026-03-15.csv
```

This updates:
- `seeds/gusto_hours_2026.csv` - Parsed hours data
- `seeds/gusto_hours_2026_managers.csv` - Employee-manager relationships

### 3. Add Temp Worker Hours (if applicable)

Edit `seeds/temp_worker_hours.csv` if you have temp worker aggregates:

```csv
NYC_TEMP AGGREGATE,03/15/26,74.29,74.29,0,0,0,Approved,,Temp Worker,Stable NYC,16d7f2b7-8522-4e03-af98-c345a315f1ab
DFW1_TEMP AGGREGATE,03/15/26,238.09,238.09,0,0,0,Approved,,Temp Worker,Stable DFW1,a86f6ee5-22e9-4a13-96d7-2e6e019f7ac0
```

### 4. Deploy to Production (CRITICAL - WITHOUT THIS, METABASE WON'T UPDATE!)

```bash
# Make sure you're on Tailscale VPN!

# THIS STEP IS REQUIRED - it actually updates the database tables
# Without this, you've only updated CSV files, not the production data!
dbt seed --target prod && dbt run --target prod --select +mart_employee_hours+
```

## Automated Update Script

For a fully automated update, run this one-liner:

```bash
cd ~/sbox/git/stable-analytics-dbt && \
python scripts/parse_gusto_export.py && \
dbt seed --target prod && \
dbt run --target prod --select +mart_employee_hours+ && \
echo "✅ Mail ops numbers updated successfully!"
```

## Key Tables Updated

- **`mart_employee_hours`** - Daily employee hours by processing center
- **`mart_employee_fte_hours`** - FTE calculations for capacity planning
- **`mart_mail_metrics`** - Daily mail processing productivity metrics

## Processing Center Assignment Logic

Employees are assigned to centers based on their manager:
- **Eddie Reyes** → Stable NYC
- **Guillermo Calderon** → Stable DFW1
- Contractors and temps are manually assigned

## Environment Requirements

Before running updates, ensure:

1. **Tailscale VPN** is connected
1. **Environment variables** are set:

```bash
export REDSHIFT_HOST=your-cluster.redshift.amazonaws.com
export REDSHIFT_USER=your_username
export REDSHIFT_PASSWORD=your_password
```

1. **dbt profile** is configured in `~/.dbt/profiles.yml`

## Troubleshooting

### Parse Issues

- **Missing employees**: Check if they're contractors (handled differently)
- **Wrong processing center**: Update `manual_manager_assignments.csv`
- **Date format issues**: Ensure Gusto export uses MM/DD/YY format

### Deployment Issues

- **Connection failed**: Check Tailscale VPN is active
- **Auth failed**: Verify environment variables are set
- **Model errors**: Run `dbt debug` to diagnose

### Quick Verification

After updating, verify in Metabase:
1. Check the "Processing Center Hours" dashboard
2. Confirm latest date appears
3. Verify NYC and DFW1 totals look reasonable

## Important Notes

- **Weekly cadence**: Updates typically run on Mondays for the previous week
- **2026 data only**: Don't modify 2025 seed files (historical data)
- **Manager hours**: Auto-generated as 8 hours per weekday
- **Temp workers**: Aggregated monthly, not daily entries

## Related Commands

```bash
# Test in dev environment first
dbt run --select mart_employee_hours

# View current data
dbt show --select mart_employee_hours --limit 10

# Run tests
dbt test --select mart_employee_hours
```

## Support

- Slack: #data-engineering
- Repository: `~/sbox/git/stable-analytics-dbt`
- README: Full documentation in repo README.md
