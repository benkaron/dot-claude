# Linear CLI Reference

Workflow patterns and examples. For flags and options, use `linear-cli <command> --help`.

## ⚠️ IMPORTANT: Avoid These Common Errors

| ❌ WRONG | ✅ CORRECT | Notes |
|----------|------------|-------|
| `linear-cli issue create` | `linear-cli create` | No 'issue' subcommand for create |
| `linear-cli update ID --state "Todo"` | `linear-cli update ID --status "Todo"` | Use --status, not --state |
| `linear-cli teams list` | `linear-cli teams` | Teams command has no 'list' argument |
| `linear-cli issue ID --team ENG` | `linear-cli issue ID` | Issue command doesn't take --team |

## Common Workflows

### Daily Standup

```bash
linear-cli my-work
linear-cli issue ENG-456
linear-cli comments ENG-456
```

### Starting a Task

```bash
# Create issue (must specify --team for creation)
linear-cli create --title "New feature" --team ENG
# Note the ID from output (e.g., ENG-789), then:

# Update status (use --status, NOT --state)
linear-cli update ENG-789 --status "In Progress" --assignee me
```

### Closing Work

```bash
linear-cli update ENG-456 --status "Done"
linear-cli comment ENG-456 "Shipped in v2.1.0"
```

### Filtering Issues

```bash
linear-cli issues --team ENG
linear-cli issues --status "In Progress"
linear-cli issues --assignee me
```

### Search

```bash
linear-cli search "authentication"
linear-cli search "bug" | grep "priority: 1"
```

## Bulk Operations

```bash
# Create multiple issues
for title in "Fix login" "Add docs" "Refactor API"; do
  linear-cli create --title "$title" --team ENG
done

# Update multiple issues
for id in ENG-100 ENG-101 ENG-102; do
  linear-cli update "$id" --status "In Progress"
done
```

## Status Values

Common statuses (your instance may differ):

- Backlog
- Todo
- In Progress
- In Review
- Done
- Cancelled

## Priority Levels

- `1` - Urgent
- `2` - High
- `3` - Normal
- `4` - Low
