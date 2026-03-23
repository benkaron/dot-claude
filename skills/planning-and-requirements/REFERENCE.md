# Planning and Requirements Reference

## Full Requirement Template

```markdown
**ID:** REQ-001
**Type:** Functional/Non-Functional
**Description:** Clear, testable statement of what the system shall do
**Rationale:** Why this requirement exists
**Acceptance Criteria:**
- [ ] Specific, measurable condition 1
- [ ] Specific, measurable condition 2
- [ ] Edge case handling
**Dependencies:** REQ-002, REQ-003
**Priority:** P0 (Critical)
**Effort:** L (2-3 days)
**Risks:** Performance at scale
**Notes:** Consider caching strategy
```

## Task Template

```markdown
**ID:** TASK-001
**Requirement:** REQ-001
**Description:** Specific implementation step
**Type:** Backend/Frontend/Infrastructure/Documentation
**Dependencies:** TASK-002 must complete first
**Estimated Hours:** 8
**Assignee:** Team/Person
**Definition of Done:**
- [ ] Code complete
- [ ] Unit tests passing (>80% coverage)
- [ ] Integration tests passing
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] Deployed to staging
```

## Priority Matrix

| Priority | Urgency | Importance | Example |
|----------|---------|------------|---------|
| P0 | Urgent | Critical | Production down |
| P1 | Not Urgent | Critical | Core feature |
| P2 | Urgent | Important | Customer request |
| P3 | Not Urgent | Important | Performance improvement |
| P4 | Urgent | Nice to have | Quick win |
| P5 | Not Urgent | Nice to have | Future enhancement |

## Effort Sizing Guide

| Size | Hours | Days | Guidance |
|------|-------|------|----------|
| XS | <2 | 0.25 | Simple change, no testing |
| S | 2-4 | 0.5 | Small feature, basic testing |
| M | 4-8 | 1 | Standard feature with tests |
| L | 8-16 | 2-3 | Complex feature, multiple components |
| XL | 16-32 | 3-5 | Major feature, architecture changes |
| XXL | >32 | >5 | Break down into smaller tasks |

## Automation Scripts

### Parse Spec to Requirements

```python
#!/usr/bin/env python3
import re
import yaml

def parse_spec(spec_file):
    with open(spec_file) as f:
        content = f.read()
    
    # Extract sections
    functional = re.findall(r'## Functional.*?\n(.*?)(?=##|\Z)', content, re.DOTALL)
    nonfunctional = re.findall(r'## Non-Functional.*?\n(.*?)(?=##|\Z)', content, re.DOTALL)
    
    requirements = []
    req_id = 1
    
    for section in functional:
        for line in section.split('\n'):
            if line.strip().startswith('-'):
                requirements.append({
                    'id': f'REQ-{req_id:03d}',
                    'type': 'Functional',
                    'description': line.strip('- '),
                    'priority': 'P2',
                    'effort': 'M'
                })
                req_id += 1
    
    return requirements

# Usage
reqs = parse_spec('spec.md')
with open('requirements.yml', 'w') as f:
    yaml.dump(reqs, f)
```

### Batch Create GitHub Issues

```bash
#!/bin/bash
# create-issues.sh

# Read tasks from YAML or JSON
tasks=$(yq eval '.tasks[]' tasks.yml)

for task in $tasks; do
    title=$(echo "$task" | yq eval '.title' -)
    body=$(echo "$task" | yq eval '.description' -)
    labels=$(echo "$task" | yq eval '.labels | join(",")' -)
    milestone=$(echo "$task" | yq eval '.sprint' -)
    
    gh issue create \
        --title "$title" \
        --body "$body" \
        --label "$labels" \
        --milestone "$milestone"
done
```

### Generate Sprint Plan

```python
#!/usr/bin/env python3
def generate_sprint_plan(tasks, velocity=40):
    """Generate sprints based on team velocity"""
    sprints = []
    current_sprint = {'tasks': [], 'hours': 0}
    
    for task in sorted(tasks, key=lambda x: x['priority']):
        if current_sprint['hours'] + task['hours'] <= velocity:
            current_sprint['tasks'].append(task)
            current_sprint['hours'] += task['hours']
        else:
            sprints.append(current_sprint)
            current_sprint = {'tasks': [task], 'hours': task['hours']}
    
    if current_sprint['tasks']:
        sprints.append(current_sprint)
    
    return sprints
```

## Example Documents

### Complete Requirements Doc

```markdown
# Project X Requirements

## Executive Summary
Building a user authentication system with OAuth2 support.

## Functional Requirements

### FR1: User Registration
**Description:** Users can create accounts with email/password
**Acceptance Criteria:**
- [ ] Email validation
- [ ] Password strength requirements (8+ chars, 1 upper, 1 number)
- [ ] Confirmation email sent
- [ ] Duplicate email prevention
**Priority:** P0
**Effort:** L

### FR2: OAuth2 Integration
**Description:** Support Google and GitHub OAuth
**Acceptance Criteria:**
- [ ] Google OAuth flow works
- [ ] GitHub OAuth flow works
- [ ] Account linking for existing users
**Priority:** P1
**Effort:** XL

## Non-Functional Requirements

### NFR1: Performance
- Page load < 2s (P95)
- API response < 200ms (P95)
- Support 1000 concurrent users

### NFR2: Security
- OWASP Top 10 compliance
- Rate limiting on auth endpoints
- Secure session management

## Constraints
- Must use existing user database
- Compatible with React frontend
- Deploy to AWS

## Dependencies
- Database team for schema changes
- Security team for review
- DevOps for deployment pipeline

## Out of Scope
- Password recovery (Phase 2)
- Two-factor auth (Phase 2)
- Admin panel (Phase 3)
```

### Task Breakdown Example

```markdown
# Task Breakdown: FR1 User Registration

## Backend (16h total)
- TASK-001: Database schema for users (2h)
- TASK-002: User model and validation (4h)
- TASK-003: Registration API endpoint (4h)
- TASK-004: Email service integration (4h)
- TASK-005: Unit tests (2h)

## Frontend (12h total)
- TASK-006: Registration form UI (4h)
- TASK-007: Form validation (2h)
- TASK-008: API integration (2h)
- TASK-009: Error handling (2h)
- TASK-010: E2E tests (2h)

## Infrastructure (4h total)
- TASK-011: Email service setup (2h)
- TASK-012: Database migrations (2h)

Total: 32h (4 days)
```

## Tips

### Requirements Writing
- Use "shall" for mandatory requirements
- Use "should" for recommended features
- Use "may" for optional features
- Make requirements testable
- One requirement per statement
- Avoid implementation details

### Task Estimation
- Include all activities (code, test, review, deploy)
- Add 20% buffer for unknowns
- Consider dependencies
- Account for meetings and context switching
- Break down anything over 2 days

### Sprint Planning
- Keep 20% capacity for bugs/support
- Balance frontend/backend work
- Consider team skills and availability
- Have stretch goals ready
- Plan for code review time