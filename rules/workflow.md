# Daily Workflow

## Tool Selection Priority

1. **Skills first** — load before doing the related work
2. **Commands second** — /commit, /review-pull-request, /implement-issue, /deep-research, etc.
3. **Agents for research** — Explore agents for codebase questions, Plan agents for architecture
4. **Direct tools last** — Read, Edit, Bash for simple operations

### Auto-Load Skills

These skills should be loaded automatically when context is detected:

| Context                     | Skill                     | Trigger                           |
| --------------------------- | ------------------------- | --------------------------------- |
| `vcs=git` in hook output    | `using-git`               | Every prompt in git repos         |
| `ci=github-actions` in hook | `ci-monitor`              | After push, monitor CI runs       |
| Working in `~/.claude/`     | `maintaining-claude-code` | When modifying skills/rules/hooks |
| SQL queries in conversation | `sql-optimizer`           | When writing or reviewing SQL     |

## Agent Delegation

For complex tasks, proactively delegate to specialized agents rather than doing everything in the main context:

- **Multi-file changes (>3 files)**: Use agents to parallelize independent work streams
- **Code changes + tests**: Spawn a `test-writer` agent for tests while working on implementation
- **SQL queries >10 lines**: Route through `sql-optimizer` agent
- **Any code change >50 lines**: Run `code-reviewer` agent on the result before presenting
- **Data questions**: Use `data-query-analyzer` to explore schemas and run queries
- **Documentation lookups**: Use `docs-researcher` agent for web/doc research

When in doubt about complexity, use agents. The cost of an unnecessary agent is low; the cost of a bloated main context is high.

## Task Decomposition

Before starting multi-step work:
1. Break the task into independent sub-tasks
2. Identify which can run in parallel via agents
3. Execute parallel work simultaneously, then synthesize results

## Core Principles

- Prefer simple, clean, maintainable solutions over clever or complex ones
- Make the smallest reasonable changes to achieve the desired outcome
- Handle errors at the appropriate abstraction level
- Use temporary files for commit messages

## Slash Commands

- When you type `/command`, the system expands it into instructions
- The "is running..." message means START of work, not completion
- Execute the expanded prompt; never claim "Done!" without doing the work
