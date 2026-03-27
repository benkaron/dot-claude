---
name: troubleshooting-stablemcp
description: Diagnose and fix StableMCP connection issues for Redshift, MySQL, and OpenSearch. Use when MCP servers fail to connect, queries timeout, credentials aren't working, or StableMCP shows errors on startup.
---

# Troubleshooting StableMCP

Diagnose connection failures, timeouts, and credential issues with StableMCP servers.

## How StableMCP Works in Claude Code

Understanding the architecture is key to diagnosing issues:

1. **Registration**: MCP servers are registered in `~/.claude.json` under a project's `mcpServers` key (project-scoped) or at the top-level `mcpServers` key (user-scoped)
2. **Spawning**: When Claude Code starts in a project with MCP servers configured, it spawns each server as a **long-lived child process** using the `command` + `args` from config
3. **Working directory**: StableMCP servers use `--directory /Users/benkaron/sbox/git/stable-mcp`, so they always run from the stable-mcp repo regardless of which project you're in
4. **Communication**: Servers talk to Claude Code over stdio using the MCP protocol. They stay running for the entire session

### Credential Loading Chain

This is the most common source of issues:

1. Shell starts → `~/.zshrc` sources `~/.secrets.zsh` → shell env vars are set
2. Claude Code inherits those shell env vars
3. Claude Code spawns StableMCP → child process inherits ALL parent env vars
4. StableMCP's `env_utils.py` calls `load_dotenv()` which reads `stable-mcp/.env`
5. **CRITICAL**: `load_dotenv()` does NOT override existing env vars by default

This means: **shell env vars from `~/.secrets.zsh` take precedence over `stable-mcp/.env`**

If you set `REDSHIFT_HOST` or `REDSHIFT_PASSWORD` in `~/.secrets.zsh`, those will silently override the `.env` values, potentially creating mismatched credentials (e.g., analytics username from `.env` + admin password from shell = auth failure/timeout).

### Where Credentials Should Live

| Source | Purpose | Overrides .env? |
| --- | --- | --- |
| `stable-mcp/.env` | Primary credential source for all StableMCP servers | N/A (base) |
| `~/.secrets.zsh` | API keys, tokens — **avoid REDSHIFT_/MYSQL_/OPENSEARCH_ vars here** | Yes |
| MCP config `"env"` block | Per-server env vars in `.claude.json` | Yes |

### Server Config Location

StableMCP servers are configured per-project in `~/.claude.json`:

```
projects > /Users/benkaron/sbox/git/redshift-sql > mcpServers > StableMCP - Redshift
```

The Redshift server expects these env vars (all from `stable-mcp/.env`):
- `REDSHIFT_HOST` (required)
- `REDSHIFT_PORT` (required)
- `REDSHIFT_DATABASE` (required)
- `REDSHIFT_USER` (required)
- `REDSHIFT_PASSWORD` (required)
- `REDSHIFT_CLUSTER_IDENTIFIER` (required)
- `REDSHIFT_REGION` (required)
- `REDSHIFT_MIN_POOL_SIZE` (optional, default: 1)
- `REDSHIFT_MAX_POOL_SIZE` (optional, default: 10)

## Diagnostic Checklist

When StableMCP is failing, work through these steps:

### 1. Check Server Health

```bash
claude mcp list
```

Look for `✗ Failed to connect` or `! Needs authentication`.

### 2. Check for Env Var Conflicts

```bash
# See what your shell is exporting (values masked)
printenv | grep -iE 'REDSHIFT_|MYSQL_|OPENSEARCH_' | sed 's/=.*/=***/'

# Compare against what .env provides (variable names only)
grep -oP '^[A-Z_]+(?==)' ~/sbox/git/stable-mcp/.env
```

If both your shell and `.env` define the same variable, the shell wins. This is the #1 cause of mysterious connection issues.

### 3. Check for Mismatched Credentials

Common symptom: timeouts or auth failures after changing creds in `~/.secrets.zsh`.

The failure mode is subtle — `load_dotenv()` loads SOME vars from `.env` (the ones not in your shell) and SKIPS others (the ones already set). You end up with a Frankenstein config: half from `.env`, half from your shell.

**Fix**: Remove all `REDSHIFT_*`, `MYSQL_*`, and `OPENSEARCH_*` vars from `~/.secrets.zsh`. Let `stable-mcp/.env` be the single source of truth.

### 4. Restart After Credential Changes

MCP servers are long-lived processes. After changing creds:
- Changing `~/.secrets.zsh` → restart your terminal AND Claude Code
- Changing `stable-mcp/.env` → restart Claude Code (new session)

### 5. Test Connection Directly

```bash
# Load the .env and test Redshift connectivity
cd ~/sbox/git/stable-mcp && source .env
psql "host=$REDSHIFT_HOST port=$REDSHIFT_PORT dbname=$REDSHIFT_DATABASE user=$REDSHIFT_USER sslmode=require" -c "SELECT 1"
```

### 6. Check Connection Pool

StableMCP uses an async connection pool (psycopg_pool). Pool-related timeouts:
- **Pool acquisition timeout**: 30s (psycopg_pool default) — waiting for a free connection
- **Connection timeout**: 10s (hardcoded in config.py) — initial TCP connect
- **No statement timeout**: Queries can run indefinitely once connected

If you see timeouts after initial success, you may be exhausting the pool (max 10 connections).

## Common Issues

| Symptom | Likely Cause | Fix |
| --- | --- | --- |
| Timeout on startup | Mismatched host/password from env conflict | Remove REDSHIFT_* from ~/.secrets.zsh |
| "Required environment variable X is not set" | Missing var in .env, not set in shell either | Add to stable-mcp/.env |
| Works in one project, not another | Different MCP configs per project in .claude.json | Check both project entries |
| Was working, suddenly stopped | Changed ~/.secrets.zsh, overriding .env | Audit shell env vars vs .env |
| "Failed to connect" in mcp list | Server process crashed on startup | Check stderr, likely missing deps or bad creds |
