# Validate Project

Auto-detect and run formatter, linter, type checker, and tests for the current project.

## Task

I'll figure out the best validation approach and systematically validate this project.

I will:

1. **Auto-detect project type** - Scan for `pyproject.toml`, `package.json`, `Cargo.toml`, `Makefile`
2. **Discover available tooling** - Check which formatters, linters, type checkers are configured
3. **Execute validation pipeline** - Run steps in proper order (format -> lint -> typecheck -> test)
4. **Handle validation failures** - Provide clear guidance for fixing issues
5. **Report complete results** - Show what passed/failed and next steps

## Validation Pipeline

### 1. **Format Code**

- **Python**: `uv run ruff format` or `uv run black`
- **TypeScript/JavaScript**: `npm run format` or `npx prettier`
- **Rust**: `cargo fmt`

### 2. **Lint Code**

- **Python**: `uv run ruff check` or `uv run flake8`
- **TypeScript/JavaScript**: `npm run lint` or `npx eslint`
- **Rust**: `cargo clippy`

### 3. **Type Check**

- **Python**: `uv run mypy` or `uv run pyright`
- **TypeScript**: `npx tsc --noEmit`

### 4. **Run Tests**

- **Python**: `uv run pytest`
- **TypeScript/JavaScript**: `npm test`
- **Rust**: `cargo test`

## Auto-Discovery Logic

```bash
# Project type detection (priority order)
if [ -f "Makefile" ]; then
  # Make-based project - check for make validate/test targets
elif [ -f "pyproject.toml" ]; then
  # Python project - check for uv, poetry, pip-tools
elif [ -f "package.json" ]; then
  # Node.js project - check for npm, yarn, pnpm
elif [ -f "Cargo.toml" ]; then
  # Rust project - use cargo commands
fi
```

## Error Handling

- **Tool not found**: Clear installation instructions
- **Configuration missing**: Suggest minimal setup
- **Validation failures**: Specific fix recommendations
- **Permission issues**: Guidance for access problems
