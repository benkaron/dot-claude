---
name: linear-cli
description: Query, create, and manage Linear issues from the command line. Use when checking assigned work, viewing issue details, creating new issues, or updating issue status.
---

# Linear CLI

Query, create, and update Linear issues without leaving the terminal.

## ⚠️ Common Mistakes to Avoid

- Use `--status` NOT `--state` for updating issue status
- Use `linear-cli teams` NOT `linear-cli teams list` to list teams
- Use `linear-cli create` NOT `linear-cli issue create` to create issues
- Use `linear-cli issue <ID>` to view a single issue (NOT `linear-cli issue <ID> --team`)

## Quick Examples

```bash
# Check your assigned work
linear-cli my-work

# View issue details
linear-cli issue ENG-456

# Create a new issue
linear-cli create --title "Production bug" --priority 1 --team ENG

# Update status (use --status, NOT --state!)
linear-cli update ENG-456 --status "Done"
linear-cli update ENG-456 --status "Todo"  # Common statuses: Todo, In Progress, Done
linear-cli update ENG-456 --assignee me    # Assign to yourself
linear-cli comment ENG-456 "Shipped in v2.1.0"
```

## Key Commands & Correct Usage

### Creating Issues
```bash
linear-cli create --team ENG --title "Fix bug"  # CORRECT
# NOT: linear-cli issue create --team ENG        # WRONG!
```

### Updating Issues  
```bash
linear-cli update ENG-123 --status "Todo"       # CORRECT (use --status)
# NOT: linear-cli update ENG-123 --state "Todo"  # WRONG (no --state flag!)
```

### Listing Teams
```bash
linear-cli teams                                 # CORRECT
# NOT: linear-cli teams list                     # WRONG!
```

## Key Flags

- `--team ENG` - Specify or filter by team (for create/issues commands)
- `--status "In Progress"` - Set or filter by status (NOT --state!)
- `--priority 1` - Set priority (1-4, 1 is highest)
- `--assignee me` - Assign to yourself (or use username)
- `--description` - Add issue description

## More Info

See REFERENCE.md for complete flag documentation, advanced examples, and workflow patterns. Use `linear-cli --help` or `linear-cli <command> --help` for all options.

## Authentication

```bash
linear-cli login    # OAuth login (stores credentials)
linear-cli logout   # Clear stored credentials
linear-cli status   # Verify connection
```
