---
name: planning-and-requirements
description: Convert specifications to requirements, break down requirements into tasks, and create comprehensive project plans. Use when planning projects, creating requirements, breaking down features, or organizing work.
argument-hint: "[spec|requirements|tasks] [input]"
---

# Planning and Requirements

Transform specs → requirements → tasks → tickets.

## Spec to Requirements

1. **Read spec** for goals, constraints, scope
2. **Extract requirements:**

```markdown
## FR1: Feature Name
- Description: Clear, testable statement
- Acceptance: [ ] Specific conditions
- Priority: P0-P5
- Effort: XS/S/M/L/XL
```

3. **Document:**
```markdown
# Requirements

## Functional
[List with IDs, acceptance criteria]

## Non-Functional  
[Performance, security, scalability]

## Out of Scope
[Explicitly excluded]
```

## Requirements to Tasks

```markdown
# REQ-001 Tasks

## Backend
- [ ] Data model (4h)
- [ ] API endpoints (8h)
- [ ] Tests (4h)

## Frontend
- [ ] UI components (6h)
- [ ] Integration (4h)
```

**Sizing:** XS(<2h), S(2-4h), M(1d), L(2-3d), XL(3-5d)

## Create Tickets

```bash
# GitHub
gh issue create --title "Task" --body "Description" --label "type"

# Linear
linear-cli issue create --title "Task" --estimate 3
```

## Sprint Planning

```markdown
## Sprint 1: Foundation
- TASK-001: Setup (M)
- TASK-002: Database (L)
- TASK-003: API base (M)

## Sprint 2: Features
- TASK-004: Auth (L)
- TASK-005: Core logic (XL)
```

## Quick Templates

**Requirement:** ID | Type | Description | Acceptance | Priority | Effort
**Task:** ID | Requirement | Description | Hours | Dependencies
**Sprint:** Goal | Tasks | Total effort

See REFERENCE.md for detailed templates, examples, and automation scripts.