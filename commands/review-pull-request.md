# Review Pull Request

Pull Request: $ARGUMENTS

## Task

I'll carefully review this pull request against issue requirements and good coding practices.

I will:

1. **Read the pull request** to understand changes, scope, and implementation approach
2. **Find related issue** for acceptance criteria and original requirements
3. **Ensure latest code context** - pull changes and verify working directory state
4. **Review project documentation** - check `CLAUDE.md`, `docs/` for standards
5. **Analyze implementation quality** - code structure, patterns, maintainability
6. **Verify test coverage** - ensure complete testing of new functionality
7. **Check style compliance** - validate against project guidelines
8. **Assess scope adherence** - confirm changes are minimal and focused on requirements
9. **Determine review action** - check if self-authored (comment) vs external (formal review)
10. **Submit structured feedback** - provide actionable recommendations

## Review Framework

### **Requirements Alignment**

- **Acceptance Criteria Coverage**: Verify all issue requirements are met
- **Scope Boundaries**: Ensure no scope creep beyond original ticket
- **Edge Case Handling**: Confirm robust error handling and input validation

### **Code Quality Assessment**

- **Architecture Consistency**: Follows established patterns from codebase
- **Code Organization**: Single Responsibility Principle, DRY compliance
- **Documentation**: Adequate comments for complex logic, API changes documented
- **Performance Considerations**: No obvious bottlenecks or inefficient algorithms

### **Test Coverage Verification**

- **Coverage Completeness**: All new functionality has corresponding tests
- **Error Scenarios**: Edge cases and failure modes are tested
- **Integration Testing**: Changes work correctly with existing system

### **Implementation Standards**

- **Branch Management**: Clean commit history, appropriate branch naming
- **Change Minimalism**: Smallest necessary changes to achieve requirements
- **Security Review**: Input validation, no credentials exposure

## Command Reference

```bash
# View PR with full details
gh pr view <number> --json title,body,author,commits,files,comments,reviews

# Get diff and file changes
gh pr diff <number>

# View related GitHub issue
gh issue view <number> --json title,body,labels,assignees

# Submit review (if not self-authored)
gh pr review <number> --approve|--request-changes|--comment
```
