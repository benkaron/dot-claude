# Sets up complete GitHub project infrastructure from any `issues.md` file

Set up GitHub project from issues file: $ARGUMENTS

I'll analyze the provided `issues.md` file and create complete GitHub project infrastructure including labels, milestones, project board, and all issues with proper relationships.

I will:

1. **Parse and analyze the issues file** using Claude's analysis capabilities
2. **Extract project structure** including labels, milestones, and issue relationships
3. **Create GitHub labels** with appropriate colors and descriptions
4. **Set up milestones** with calculated due dates based on project phases
5. **Create GitHub project board** with custom fields for tracking
6. **Generate all issues** with proper labels, milestones, and descriptions
7. **Link issue dependencies** through comments and references
8. **Provide complete summary** of created resources

## Prerequisites

- The `gh` CLI is installed and authenticated
- You're in the root directory of a GitHub repository
- The repository already exists on GitHub
- The `issues.md` file exists and is properly formatted

## Process Overview

### Phase 1: Analysis & Extraction

- Read and parse the `issues.md` file
- Extract unique labels, milestones, and project metadata
- Identify issue relationships and dependencies

### Phase 2: Infrastructure Setup

- Create all required labels with smart color coding
- Set up project milestones
- Create GitHub project board with custom fields

### Phase 3: Issue Creation

- Create all issues with proper titles and descriptions
- Apply appropriate labels and milestone assignments
- Link related issues through comments

## Sub-Agent Coordination

This command leverages sub-agents for parallel processing:

1. **Analysis Agent**: Extracts and organizes all project metadata
2. **Setup Agent**: Creates labels, milestones, and project board
3. **Issue Creation Agent**: Processes issue creation in batches
4. **Dependency Agent**: Links issues and sets up relationships

## Error Handling

- Validates GitHub CLI authentication before starting
- Checks for existing labels/milestones to avoid duplicates
- Handles rate limiting with appropriate delays
- Provides detailed error messages for troubleshooting

This command integrates with the workflow:
`spec-to-requirements.md` -> `requirements-to-tasks.md` -> `tasks-to-issues.md` -> **`setup-github-issues.md`**
