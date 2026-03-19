# Skill Builder Reference

## Skill Anatomy

```
skills/
└── skill-name/
    ├── SKILL.md       # Discovery & metadata (required)
    └── REFERENCE.md   # Detailed documentation (optional)
```

## SKILL.md Structure

```markdown
---
name: skill-name
description: One-line description for discovery. Include trigger phrases and use cases.
---

# Skill Name

Brief explanation of what this skill provides.

## When to Use

- Specific scenario 1
- Specific scenario 2
- Specific scenario 3

## What It Provides

- Key capability 1
- Key capability 2
- Key capability 3

## Auto-Load Triggers

- "trigger phrase 1"
- "trigger phrase 2"
- "trigger phrase 3"
```

## Writing Effective Descriptions

### Good Description
```yaml
description: Search GitHub for proven solutions, popular libraries, and real-world examples before implementing. Auto-load when asked "how do I", "what's the best way", "which library", or any implementation question.
```

**Why it works:**
- States the action (search GitHub)
- Explains the value (proven solutions)
- Lists concrete triggers
- Clear use case

### Bad Description
```yaml
description: Helps with GitHub stuff
```

**Why it fails:**
- Too vague
- No clear triggers
- Doesn't explain value
- Won't auto-load reliably

## Trigger Phrase Best Practices

### Effective Triggers
- Match natural language patterns
- Cover variations users might say
- Include both specific and general phrases
- Test with real queries

### Examples
```yaml
# Code review skill
- "review this code"
- "check for issues"
- "find problems"
- "code review"
- "is this production ready"

# Debugging skill
- "debug this"
- "why isn't this working"
- "find the bug"
- "trace the error"
- "what's wrong with"
```

## Skill Categories

### Workflow Skills
Automate common development workflows
- Git operations
- CI/CD pipelines
- Deployment processes
- Code review

### Knowledge Skills
Provide domain expertise
- Framework best practices
- Language patterns
- Architecture guidance
- Security standards

### Tool Skills
Integrate with specific tools
- Database queries
- API interactions
- CLI commands
- Service configurations

### Project Skills
Project-specific conventions
- Coding standards
- Testing patterns
- Build processes
- Documentation formats

## Skill Testing Checklist

### Discovery Testing
- [ ] Ask questions using trigger phrases
- [ ] Verify skill loads automatically
- [ ] Check description appears in search
- [ ] Test edge cases and variations

### Content Testing
- [ ] Information is accurate
- [ ] Examples work correctly
- [ ] Commands are valid
- [ ] References are current

### User Experience
- [ ] Clear when to use
- [ ] Progressive disclosure works
- [ ] No information overload
- [ ] Actionable guidance

## Common Patterns

### Command Reference Skill
```markdown
---
name: docker-commands
description: Essential Docker commands for development. Auto-load when working with containers, Docker Compose, or asking about Docker operations.
---

# Docker Commands

Quick reference for common Docker operations.

## When to Use
- Building and running containers
- Managing Docker images
- Debugging container issues
- Docker Compose operations
```

### Integration Skill
```markdown
---
name: api-integration
description: Integrate with Company API including authentication, rate limiting, and best practices. Auto-load when working with API endpoints or asking about API integration.
---

# Company API Integration

Guidelines and patterns for working with our API.

## When to Use
- Setting up API authentication
- Making API requests
- Handling rate limits
- Error handling patterns
```

### Debugging Skill
```markdown
---
name: performance-profiling
description: Profile and optimize application performance. Auto-load when investigating slowness, memory issues, or optimization opportunities.
---

# Performance Profiling

Tools and techniques for finding performance bottlenecks.

## When to Use
- Application is running slowly
- High memory usage
- CPU spikes
- Optimization needed
```

## Skill Migration Guide

### From Commands to Skills
Commands are one-shot prompts. Convert to skills when:
- Information is reusable
- Multiple related topics
- Need progressive disclosure

### From Rules to Skills
Rules are always loaded. Convert to skills when:
- Only needed occasionally
- Specific to certain workflows
- Too detailed for rules

### From Inline Knowledge to Skills
Extract to skills when:
- Repeatedly providing same information
- Knowledge has structure
- Others could benefit

## Skill Validation

### Run this check:
```bash
# Verify skill structure
ls -la skills/*/
find skills -name "SKILL.md" | xargs head -n 10

# Test description quality
grep "^description:" skills/*/SKILL.md

# Check for trigger phrases
grep -h "Auto-Load Triggers" skills/*/SKILL.md -A 5
```

### Quality Metrics
- **Discoverability**: Can users find it?
- **Activation**: Does it load when needed?
- **Usefulness**: Does it solve real problems?
- **Completeness**: Is information sufficient?
- **Maintenance**: Is it easy to update?

## Examples of Great Skills

### 1. Git Workflow (Process Automation)
- Clear workflow steps
- Common variations covered
- Troubleshooting included
- Command references

### 2. API Documentation (Knowledge Base)
- Authentication details
- Endpoint references
- Example requests
- Error handling

### 3. Testing Patterns (Best Practices)
- Framework-specific guidance
- Example test cases
- Mocking strategies
- Coverage goals

## Skill Builder Workflow

1. **Identify Need**
   - Repeated questions
   - Complex workflows
   - Domain knowledge

2. **Design Structure**
   - Choose name
   - Write description
   - List triggers
   - Plan content

3. **Create Files**
   ```bash
   mkdir -p skills/new-skill
   touch skills/new-skill/SKILL.md
   touch skills/new-skill/REFERENCE.md
   ```

4. **Write Content**
   - SKILL.md for discovery
   - REFERENCE.md for details
   - Examples and commands

5. **Test & Iterate**
   - Try trigger phrases
   - Verify auto-load
   - Get feedback
   - Refine content