# Create Linear Issue

You need to create a Linear issue based on the current conversation with the user.

## Process

1. **Summarize the Context**
   - Review the recent conversation
   - Identify the main problem or task discussed
   - Extract key requirements and acceptance criteria

2. **Craft the Issue**
   - **Title**: Concise, action-oriented summary (max 80 chars)
   - **Description**: Include:
     - Problem statement or goal
     - Requirements discussed
     - Technical details mentioned
     - Acceptance criteria
     - Any code snippets or examples shared

3. **Set Appropriate Metadata**
   - **Priority**: Based on urgency discussed (1=urgent, 2=high, 3=normal, 4=low)
   - **Estimate**: If complexity was discussed
   - **Labels**: Add relevant technical tags

4. **Create the Issue**
   ```bash
   linear-cli create \
     --title "[Concise title from conversation]" \
     --description "[Full context and requirements]" \
     --priority [1-4] \
     --team ENG
   ```

5. **Confirm Creation**
   - Show the created issue ID
   - Provide the Linear URL if available
   - Ask if any adjustments are needed

## Important Notes

- Use the `linear-cli` skill for correct syntax
- Include enough context so someone else could implement it
- Reference any relevant files or code discussed
- Add links to related PRs or issues if mentioned

## Example Output

"I'll create a Linear issue for the skill/command relationship discussion:

```bash
linear-cli create \
  --title "Document skill vs command architecture patterns" \
  --description "User needs clarity on when to use skills vs commands in Claude Code setup.

Context from discussion:
- Skills provide reference knowledge (HOW to do things)
- Commands provide instructions/workflows (WHAT to do)
- They can work together (commands can trigger skills)

Requirements:
- Create documentation explaining the difference
- Add examples of each type
- Show how they complement each other

Acceptance Criteria:
- [ ] Clear explanation of skills vs commands
- [ ] Real-world examples
- [ ] Best practices guide" \
  --priority 3 \
  --team ENG
```

Created issue ENG-789: Document skill vs command architecture patterns"