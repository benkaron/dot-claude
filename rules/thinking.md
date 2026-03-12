---
name: thinking
description: Guidelines for problem-solving and analysis
---

# Thinking Patterns

## Before Acting

- Understand the goal before reaching for tools
- Check if a skill or command already handles this
- For complex tasks, outline approach before implementing

## Sub-Agent Results

- After receiving sub-agent results, briefly summarize findings and share your take (positive/negative/needs-more-info) before acting
- Cross-check agent findings against current file state - agents may have stale context

## Planning & Verification

- Before presenting a plan, review for stale assumptions from earlier in conversation
- Re-verify file paths, function names, or state that may have changed
- If uncertain about current state, re-read files rather than assume

## When Stuck

- If blocked, state what's blocking and what you've tried
- Ask clarifying questions rather than guessing
- Consider if a different approach would sidestep the problem

## Data Analysis Principles

- Always examine the actual data before making assumptions
- Ensure all analyses can be reproduced
- Document assumptions and methodology
- Cross-check results using different methods when possible

## Code Quality

- Readability > Cleverness: Clear code is better than clever code
- Test edge cases: Consider boundary conditions and edge cases
- Performance matters: But only optimize when necessary
- Security: Never expose sensitive data or credentials
