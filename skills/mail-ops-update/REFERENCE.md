# Mail Ops Update - Quick Reference

## 🚀 Quick Update (Most Common)

```bash
# Run the automated script
~/.claude/skills/mail-ops-update/update_mail_ops.sh
```

## 📋 Manual Steps

### 1. Export from Gusto

- **URL**: gusto.com
- **Path**: Reports → Time Tracking → Export CSV
- **File**: Downloads to `mistro-inc-time-tracking-hours-YYYY-MM-DD.csv`

### 2. Parse Export

```bash
cd ~/sbox/git/stable-analytics-dbt
python scripts/parse_gusto_export.py
```

### 3. Deploy

```bash
dbt seed --target prod && dbt run --target prod --select +mart_employee_hours+
```

## 🔧 Common Scenarios

### Adding Temp Worker Hours

```bash
# Edit the CSV directly
nano ~/sbox/git/stable-analytics-dbt/seeds/temp_worker_hours.csv

# Add lines like:
# NYC_TEMP AGGREGATE,03/18/26,74.29,74.29,0,0,0,Approved,,Temp Worker,Stable NYC,<uuid>
# DFW1_TEMP AGGREGATE,03/18/26,238.09,238.09,0,0,0,Approved,,Temp Worker,Stable DFW1,<uuid>
```

### Processing Multiple Weeks

```bash
# Download all Gusto exports first, then:
cd ~/sbox/git/stable-analytics-dbt
python scripts/parse_gusto_export.py ~/Downloads/mistro-inc-*.csv
dbt seed --target prod && dbt run --target prod --select +mart_employee_hours+
```

### Fixing Wrong Processing Center

```bash
# Edit manual assignments
nano ~/sbox/git/stable-analytics-dbt/seeds/manual_manager_assignments.csv

# Add employee override:
# employee_name,processing_center
# John Doe,Stable NYC
```

### Testing Before Deploy

```bash
# Run in your dev schema first
cd ~/sbox/git/stable-analytics-dbt
dbt run --select mart_employee_hours  # Uses dev by default
dbt show --select mart_employee_hours --limit 20  # Preview data
```

## 🐛 Troubleshooting

### "Tailscale not connected"

```bash
tailscale up
# Wait for connection
tailscale status
```

### "Password authentication failed"

```bash
# Set environment variables
export REDSHIFT_HOST=<your-cluster>.redshift.amazonaws.com
export REDSHIFT_USER=<your-username>
export REDSHIFT_PASSWORD=<your-password>
```

### "No files found"

```bash
# Check Downloads folder
ls -la ~/Downloads/mistro-inc-*.csv

# Manually specify file
python scripts/parse_gusto_export.py ~/Downloads/<exact-filename>.csv
```

### "Model not found" warnings

```bash
# These are safe to ignore if seeds and marts run successfully
# Only marts are used by Metabase
```

## 📊 Verification Queries

After updating, you can verify directly in Redshift:

```sql
-- Check latest date in employee hours
SELECT MAX(date) as latest_date, processing_center
FROM public.mart_employee_hours
GROUP BY processing_center;

-- Check total hours by center for latest week
SELECT
    processing_center,
    DATE_TRUNC('week', date) as week,
    SUM(total_hours) as total_hours
FROM public.mart_employee_hours
WHERE date >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY 1, 2
ORDER BY 1, 2;

-- Check if temp workers are included
SELECT DISTINCT first_name, last_name, processing_center
FROM public.mart_employee_hours
WHERE first_name = 'Temp Worker'
  AND date >= CURRENT_DATE - INTERVAL '30 days';
```

## 🎯 Key Points

- **Frequency**: Weekly, typically Monday mornings
- **Time Required**: ~5 minutes
- **Critical**: Must be on Tailscale VPN
- **Data Year**: Only update 2026 files, never 2025
- **Processing Centers**: NYC (Eddie Reyes), DFW1 (Guillermo Calderon)

## 📱 Contacts

- **Data Issues**: #data-engineering on Slack
- **Gusto Access**: HR team
- **Metabase Access**: Analytics team
- **Repository**: `~/sbox/git/stable-analytics-dbt`
