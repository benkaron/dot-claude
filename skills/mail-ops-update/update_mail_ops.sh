#!/bin/bash
# Mail Ops Update Script
# Updates Stable's mail processing operations numbers from Gusto exports

set -e  # Exit on any error

echo "📊 Mail Ops Update Script"
echo "========================="
echo ""

# Check if we're on Tailscale
if ! tailscale status &>/dev/null; then
    echo "❌ Error: Tailscale VPN is not connected"
    echo "Please connect to Tailscale first: tailscale up"
    exit 1
fi

# Check environment variables
if [ -z "$REDSHIFT_HOST" ] || [ -z "$REDSHIFT_USER" ] || [ -z "$REDSHIFT_PASSWORD" ]; then
    echo "❌ Error: Redshift environment variables not set"
    echo "Please set REDSHIFT_HOST, REDSHIFT_USER, and REDSHIFT_PASSWORD"
    exit 1
fi

# Navigate to dbt project
cd ~/sbox/git/stable-analytics-dbt || {
    echo "❌ Error: Could not find stable-analytics-dbt repository"
    echo "Expected location: ~/sbox/git/stable-analytics-dbt"
    exit 1
}

echo "✅ Prerequisites checked"
echo ""

# Step 1: Parse Gusto exports
echo "📁 Step 1: Looking for Gusto exports in Downloads..."
if python scripts/parse_gusto_export.py; then
    echo "✅ Gusto exports parsed successfully"
else
    echo "❌ Error parsing Gusto exports"
    echo "Make sure you've exported the Time Tracking report from Gusto"
    exit 1
fi
echo ""

# Step 2: Check if temp hours need updating
echo "📝 Step 2: Checking temp worker hours..."
echo "Current temp worker entries:"
tail -5 seeds/temp_worker_hours.csv
echo ""
read -p "Do you need to add/update temp worker hours? (y/N): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Opening temp_worker_hours.csv for editing..."
    ${EDITOR:-nano} seeds/temp_worker_hours.csv
    echo "✅ Temp worker hours updated"
fi
echo ""

# Step 3: Deploy to production
echo "🚀 Step 3: Deploying to production..."
echo "This will:"
echo "  1. Load updated seed data (dbt seed)"
echo "  2. Rebuild all dependent models (dbt run)"
echo ""
read -p "Continue with deployment? (y/N): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Loading seeds..."
    if dbt seed --target prod; then
        echo "✅ Seeds loaded"
    else
        echo "❌ Error loading seeds"
        exit 1
    fi
    
    echo ""
    echo "Rebuilding models..."
    if dbt run --target prod --select +mart_employee_hours+; then
        echo "✅ Models rebuilt"
    else
        echo "❌ Error rebuilding models"
        exit 1
    fi
else
    echo "⏸️  Deployment cancelled"
    exit 0
fi

echo ""
echo "🎉 Mail ops numbers updated successfully!"
echo ""
echo "Next steps:"
echo "  1. Check Metabase 'Processing Center Hours' dashboard"
echo "  2. Verify the latest date appears correctly"
echo "  3. Confirm NYC and DFW1 totals look reasonable"
echo ""
echo "Dashboard: https://metabase.yourdomain.com/dashboard/XX"