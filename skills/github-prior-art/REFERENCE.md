# GitHub Prior Art Research Guide

## Research Workflow

### 1. Initial Discovery

Search GitHub for relevant solutions:
- **Keywords**: Problem domain + language/framework
- **Filters**: Stars > 100, recently updated
- **Topics**: Browse GitHub topics for the problem space

### 2. Evaluation Criteria

#### Repository Health
- ⭐ **Stars**: Indicates community adoption
- 🍴 **Forks**: Shows active usage
- 🐛 **Issues**: Check open vs closed ratio
- 📅 **Last Commit**: Ensure active maintenance
- 📦 **Releases**: Look for stable versions
- 📚 **Documentation**: Quality indicates maturity

#### Code Quality Signals
- Test coverage
- CI/CD pipelines
- Code review process
- Contributing guidelines
- Security policies

### 3. Search Strategies

#### For Libraries/Tools
```
language:javascript stars:>1000 "react hooks"
language:python stars:>500 "data validation"
language:rust stars:>100 "async http client"
```

#### For Implementation Examples
```
filename:README.md "how to" [specific feature]
path:examples [technology] [use case]
extension:md "tutorial" [concept]
```

#### For Best Practices
```
"best practices" [technology] stars:>50
"style guide" [language] org:google
"design patterns" [framework] in:readme
```

### 4. Comparison Framework

When evaluating multiple solutions:

| Criteria | Option A | Option B | Option C |
|----------|----------|----------|----------|
| Stars | 15k | 8k | 22k |
| Last Update | 2 days | 1 month | 1 week |
| Issues | 45/1200 | 120/800 | 30/2000 |
| Documentation | Excellent | Good | Fair |
| Learning Curve | Moderate | Simple | Complex |
| Performance | Fast | Moderate | Very Fast |
| Bundle Size | 45kb | 12kb | 89kb |
| TypeScript | ✅ | ⚠️ | ✅ |
| Test Coverage | 94% | 78% | 88% |

### 5. Red Flags to Avoid

- 🚩 No activity in 6+ months
- 🚩 No tests or CI
- 🚩 Single maintainer with many open issues
- 🚩 No documentation beyond README
- 🚩 Breaking changes without major version bumps
- 🚩 Unresolved security vulnerabilities
- 🚩 No license or incompatible license

### 6. Finding Real-World Usage

#### Check Dependents
- GitHub's "Used by" section
- Look for notable companies/projects

#### Search for Integration Examples
```
"import [library]" extension:js
"from [package] import" extension:py
"require('[module]')" path:src
```

#### Review Discussions
- GitHub Discussions
- Stack Overflow questions
- Reddit threads
- Dev.to articles

## Research Report Template

```markdown
# Prior Art Research: [Problem/Feature]

## Summary
Brief description of what we're trying to solve.

## Top Solutions Found

### 1. [Library/Approach Name]
- **GitHub**: [URL]
- **Stars/Forks**: X stars, Y forks
- **Pros**: 
  - Battle-tested (used by Company A, B)
  - Great documentation
  - Active community
- **Cons**:
  - Large bundle size
  - Learning curve
- **Example Usage**:
\```javascript
// Code example
\```

### 2. [Alternative Solution]
[Similar structure]

## Recommendation

Based on research, **[Recommended Solution]** because:
1. Most widely adopted (X stars, Y dependents)
2. Best matches our requirements
3. Lowest risk (mature, well-maintained)

## Implementation Approach

From studying [successful implementation], the pattern is:
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Potential Pitfalls

From GitHub issues and discussions:
- Issue #123: [Common problem and solution]
- Issue #456: [Performance consideration]

## Additional Resources
- [Tutorial/Guide found]
- [Video walkthrough]
- [Blog post with tips]
```

## Quick Search Recipes

### Find the most popular solution
```
[problem] language:[lang] sort:stars
```

### Find recent discussions
```
[technology] [problem] created:>2024-01-01 type:issue
```

### Find enterprise-grade solutions
```
org:google OR org:facebook OR org:microsoft [technology]
```

### Find tutorials and guides
```
"step by step" OR tutorial OR guide [technology] in:readme stars:>50
```

### Find common pitfalls
```
"gotcha" OR "warning" OR "don't" [technology] in:readme,issues
```

## Research Checklist

- [ ] Searched for existing solutions
- [ ] Compared at least 3 alternatives
- [ ] Checked maintenance status
- [ ] Reviewed open issues for showstoppers
- [ ] Found real-world usage examples
- [ ] Verified license compatibility
- [ ] Tested basic functionality
- [ ] Documented findings and recommendation