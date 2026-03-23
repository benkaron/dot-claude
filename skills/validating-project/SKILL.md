---
name: validating-project
description: Run formatters, linters, type checkers, and tests in the proper order to validate a project. Use when validating code, running checks, ensuring quality, or preparing for commit.
argument-hint: "[--fix] [specific-check]"
---

# Validating Project

Auto-detect and validate projects systematically.

## Quick Validation

```bash
# Auto-detect and run all
make validate || make lint test || ~/.claude/skills/validating-project/validate.sh
```

## By Project Type

**Python:**
```bash
ruff format . && ruff check . && mypy . && pytest
```

**JavaScript/TypeScript:**  
```bash
npm run lint && npm run typecheck && npm test
```

**Rust:**
```bash
cargo fmt && cargo clippy && cargo test
```

**Go:**
```bash
go fmt ./... && go vet ./... && go test ./...
```

## Output Format

```
🔍 Project Validation
📝 Format    ✅ Passed
🔎 Lint      ⚠️ 3 warnings  
🔤 Types     ✅ Passed
🧪 Tests     ❌ 2 failed

Result: Failed ❌
```

## Fix Mode

```bash
# Auto-fix issues
ruff check --fix
npm run lint -- --fix
cargo fix
```

See REFERENCE.md for complete validation commands by language, CI integration, and custom validation scripts.