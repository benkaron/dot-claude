---
name: using-ticktick
description: Manage tasks, projects, and lists in TickTick via MCP. Use when creating tasks, checking todos, querying what's due, completing tasks, managing projects/lists, any task management workflow, or adding Airbnb guest reminder tasks.
---

# TickTick MCP

Manage tasks and projects in TickTick without leaving the terminal. The MCP is configured globally — available in all sessions.

## CRITICAL: Confirmation Required

**ALWAYS ask the user for explicit confirmation before:**

- Creating tasks (`create_task`, `batch_add_tasks`)
- Completing tasks (`complete_task`, `complete_tasks_in_project`)
- Updating tasks (`update_task`, `batch_update_tasks`)
- Moving tasks (`move_task`)
- Creating or updating projects (`create_project`, `update_project`)

These actions modify the user's real task list and cannot be easily undone. Show what you're about to do and wait for a "yes" before executing. Reading/querying is always safe.

**Timezone**: Default to **Eastern Time (America/New_York)** for all task dates and reminders. If the user needs a different timezone, ask — but assume ET unless told otherwise.

## Querying Tasks

```
# Quick time-based queries
list_undone_tasks_by_time_query  # today, tomorrow, next7day, last24hour
list_undone_tasks_by_date        # custom date range (up to 14 days)
list_completed_tasks_by_date     # completed in a date range

# Search and filter
search / search_task             # keyword search across all tasks
filter_tasks                     # by priority, tags, status, project, kind, date range

# Get specific task
get_task_by_id / get_task_in_project / fetch
```

## Managing Tasks

```
# Single task
create_task       # priority, tags, checklists, reminders, due date
update_task       # update any field
complete_task     # mark done

# Bulk operations
batch_add_tasks              # create multiple at once
batch_update_tasks           # bulk update
complete_tasks_in_project    # bulk complete (up to 20)
move_task                    # move between projects/lists
```

## Projects (Lists)

```
list_projects                    # all projects/lists
get_project_by_id                # project details
get_project_with_undone_tasks    # project + its open tasks
create_project                   # new list
update_project                   # rename, recolor, change view, close
```

## Other

```
get_user_preference    # timezone and settings
```

## Airbnb Guest Reminders

When asked to add Airbnb tasks/reminders, **always use the script** — do NOT create these tasks via the MCP.

The script supports CLI arguments (for use from Claude) and interactive mode (for manual use):

```bash
# CLI mode — ask the user for guest details first, then run:
python3 ~/projects/airbnb-ticktick/main.py \
  --name "Guest Name" \
  --checkin MM/DD/YYYY \
  --checkout MM/DD/YYYY \
  --yes

# With custom check-in/checkout times:
python3 ~/projects/airbnb-ticktick/main.py \
  --name "Guest Name" \
  --checkin MM/DD/YYYY \
  --checkout MM/DD/YYYY \
  --checkin-time "2 PM" \
  --checkout-time "12 PM" \
  --yes

# Interactive mode (user runs manually):
# ! python3 ~/projects/airbnb-ticktick/main.py
```

**Workflow**: Ask the user for guest name, check-in date, checkout date, and whether they have early check-in or late checkout. Then run the script with `--yes` to skip the confirmation prompt.

**Defaults (all times Eastern):**
- Check-in time: **4 PM ET** (only pass `--checkin-time` if the guest has early check-in)
- Checkout time: **10 AM ET** (only pass `--checkout-time` if the guest has late checkout)

When confirming with the user, show: guest name, dates, and whether times are default or custom. Always specify "ET" for times.

The script creates 5 timed reminder tasks (all Eastern Time) with pre-filled message templates:

1. Car info request (4 days before check-in, 10 AM ET)
2. Check-in instructions (1 day before, 10 AM ET)
3. Welcome message (day of check-in, 3 PM ET)
4. Checkout message (1 day before checkout, 5:30 PM ET)
5. Review request (day of checkout, 11 AM ET)

Requires `TICKTICK_CLIENT_ID` and `TICKTICK_CLIENT_SECRET` in `~/.secrets.zsh`.

## Patterns

- Use `list_undone_tasks_by_time_query` with "today" for daily standups
- Use `filter_tasks` for targeted queries (e.g., high-priority items in a specific project)
- Use `batch_add_tasks` when breaking down work into multiple tasks
- Always use `list_projects` first if you need a project ID
