#!/bin/bash
# Remove default labels
gh label delete "bug" --yes 2>/dev/null
gh label delete "duplicate" --yes 2>/dev/null  
gh label delete "enhancement" --yes 2>/dev/null
gh label delete "good first issue" --yes 2>/dev/null
gh label delete "help wanted" --yes 2>/dev/null
gh label delete "invalid" --yes 2>/dev/null
gh label delete "question" --yes 2>/dev/null
gh label delete "wontfix" --yes 2>/dev/null

# Type labels
gh label create "type: feature" --description "New feature" --color "0E7A0D"
gh label create "type: bug" --description "Something broken" --color "D73A4A"  
gh label create "type: chore" --description "Maintenance" --color "FEF2C0"
gh label create "type: docs" --description "Documentation" --color "0075CA"
gh label create "type: refactor" --description "Code improvement" --color "D4C5F9"

# Priority labels
gh label create "priority: critical" --description "Drop everything" --color "B60205"
gh label create "priority: high" --description "Important" --color "D93F0B"
gh label create "priority: medium" --description "Normal" --color "FBCA04"
gh label create "priority: low" --description "Nice to have" --color "0E8A16"

# Status labels  
gh label create "status: blocked" --description "Waiting" --color "D93F0B"
gh label create "status: in progress" --description "Working" --color "0E8A16"
gh label create "status: review needed" --description "Needs review" --color "FBCA04"
gh label create "status: ready" --description "Ready to start" --color "0E7A0D"

# Effort labels
gh label create "effort: XS" --description "< 2 hours" --color "C2E0C6"
gh label create "effort: S" --description "2-4 hours" --color "C2E0C6"  
gh label create "effort: M" --description "1-2 days" --color "FEF2C0"
gh label create "effort: L" --description "3-5 days" --color "FBCA04"
gh label create "effort: XL" --description "> 1 week" --color "D93F0B"

# Area labels
gh label create "area: frontend" --description "Frontend" --color "5319E7"
gh label create "area: backend" --description "Backend" --color "1D76DB"
gh label create "area: database" --description "Database" --color "0E8A16"
gh label create "area: infrastructure" --description "DevOps" --color "C5DEF5"
gh label create "area: testing" --description "Testing" --color "BFD4F2"

echo "✅ Labels created successfully"