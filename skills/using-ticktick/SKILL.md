---
name: using-ticktick
description: Manage tasks, projects, and lists in TickTick via MCP. Use when creating tasks, checking todos, querying what's due, completing tasks, managing projects/lists, any task management workflow, or adding Airbnb guest reminder tasks.
---

# TickTick MCP

Manage tasks and projects in TickTick without leaving the terminal. The MCP is configured globally — available in all sessions.

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

When asked to add Airbnb tasks/reminders, **always run the script directly** — do NOT create these tasks via the MCP. The script is interactive (it prompts for input), so just run it via Bash and the user will interact with the prompts:

```bash
python3 ~/projects/airbnb-ticktick/main.py
```

Do NOT tell the user to run it themselves. Just execute it. The user will answer the prompts (guest name, check-in/checkout dates, early/late options).

The script creates 5 timed reminder tasks with pre-filled message templates:

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
