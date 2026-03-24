# Hardcore Code Review Reference

## Review Checklist

### 🚨 Critical Issues (Must Fix)

#### Memory & Resources

- [ ] Memory leaks (unreleased resources, circular references)
- [ ] File handles not closed properly
- [ ] Database connections not released
- [ ] Event listeners not removed
- [ ] Timers/intervals not cleared

#### Security

- [ ] SQL injection vulnerabilities
- [ ] XSS attack vectors
- [ ] Unvalidated user input
- [ ] Hardcoded credentials
- [ ] Insecure random number generation
- [ ] Path traversal vulnerabilities

#### Concurrency

- [ ] Race conditions
- [ ] Deadlock potential
- [ ] Improper mutex usage
- [ ] Shared state mutations
- [ ] Missing synchronization

### ⚠️ Serious Concerns

#### Performance

- [ ] O(n²) or worse algorithms
- [ ] Unnecessary database queries (N+1 problem)
- [ ] Missing indexes on queried columns
- [ ] Inefficient data structures
- [ ] Blocking I/O in async contexts
- [ ] Memory-intensive operations

#### Error Handling

- [ ] Silent failures
- [ ] Missing try-catch blocks
- [ ] Unhandled promise rejections
- [ ] Inadequate logging
- [ ] No retry logic for network calls
- [ ] Missing timeout handling

#### Architecture

- [ ] Tight coupling between modules
- [ ] Circular dependencies
- [ ] God objects/functions
- [ ] Missing abstraction layers
- [ ] Direct database access from controllers

### 🔧 Code Quality Issues

#### Best Practices

- [ ] Code duplication (DRY violations)
- [ ] Magic numbers/strings
- [ ] Inconsistent naming conventions
- [ ] Missing type hints/annotations
- [ ] No input validation
- [ ] Missing documentation

#### Testing

- [ ] No tests for critical paths
- [ ] Missing edge case coverage
- [ ] No negative test cases
- [ ] Brittle tests with hardcoded values
- [ ] Missing mocks for external services

#### Maintainability

- [ ] Functions > 50 lines
- [ ] Deeply nested code (> 3 levels)
- [ ] Complex conditionals
- [ ] Missing constants for configuration
- [ ] No error recovery mechanisms

## Common Patterns to Flag

### JavaScript/TypeScript

```javascript
// BAD: Memory leak
componentDidMount() {
  window.addEventListener('resize', this.handleResize);
  // Missing removeEventListener in componentWillUnmount
}

// BAD: Race condition
let processing = false;
async function process() {
  if (processing) return;
  processing = true;
  // Race condition between check and set
  await doWork();
  processing = false;
}

// BAD: N+1 query problem
const users = await getUsers();
for (const user of users) {
  user.posts = await getPosts(user.id); // N queries
}
```

### Python

```python
# BAD: Mutable default argument
def process(items=[]):  # Shared between calls!
    items.append('processed')
    return items

# BAD: Resource leak
def read_file(path):
    f = open(path)  # Never closed
    return f.read()

# BAD: Broad exception handling
try:
    complex_operation()
except:  # Catches everything including SystemExit
    pass  # Silent failure
```

### SQL

```sql
-- BAD: SQL injection vulnerability
query = f"SELECT * FROM users WHERE name = '{user_input}'"

-- BAD: Missing index
SELECT * FROM orders WHERE created_at > '2024-01-01'
-- No index on created_at for large table

-- BAD: Cartesian product
SELECT * FROM users, orders  -- Missing JOIN condition
```

## Review Response Template

```markdown
## 🚨 CRITICAL ISSUES

### 1. [Issue Title]
**Location**: `file.js:45-52`
**Problem**: Detailed description of the issue
**Impact**: What will break in production
**Fix**:
\```javascript
// Corrected code
\```

## ⚠️ SERIOUS CONCERNS

### 1. [Concern Title]
**Location**: `file.py:120`
**Problem**: Description
**Risk**: What could go wrong
**Recommendation**: Specific fix

## 🔧 CODE QUALITY ISSUES

### 1. [Quality Issue]
**Pattern**: DRY violation / Magic number / etc.
**Locations**: Multiple occurrences
**Refactor**: Suggested improvement

## 📊 METRICS

- **Technical Debt Score**: 7/10 (high)
- **Maintainability**: 4/10
- **Performance**: 5/10
- **Robustness**: 3/10
- **Test Coverage**: Estimated 20%

## 🎯 VERDICT

**NOT READY FOR PRODUCTION**

This code has critical memory management issues and lacks proper error handling. The N+1 query problem will cause performance degradation at scale. Must address all critical issues before deployment.

**Required Actions**:
1. Fix memory leaks in EventManager
2. Add proper error handling to API endpoints
3. Optimize database queries
4. Add unit tests for critical paths
5. Remove hardcoded configuration values
```

## Review Philosophy

> "Code that works today but breaks tomorrow is technical debt. Code that breaks at 3 AM is a career-limiting move."

- **Be Direct**: Don't soften criticism - clarity prevents incidents
- **Be Specific**: Vague feedback helps no one
- **Be Constructive**: Always provide the fix, not just the problem
- **Be Thorough**: The bug you miss is the one that pages you

## Red Flags Requiring Immediate Escalation

1. **Credentials in code**: Any hardcoded passwords, API keys, or secrets
2. **Data destruction**: Code that could permanently delete or corrupt data
3. **Security holes**: Authentication bypasses, privilege escalation
4. **Legal issues**: License violations, privacy law violations
5. **Architectural disasters**: Decisions that will require complete rewrites
