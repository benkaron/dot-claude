.PHONY: help install test lint format validate dotfiles clean

help:  ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install:  ## Install dependencies
	@echo "Installing dependencies..."
	@if command -v uv >/dev/null 2>&1; then \
		uv sync; \
	elif [ -f requirements.txt ]; then \
		pip install -r requirements.txt; \
	else \
		echo "No dependencies to install"; \
	fi

test:  ## Run tests
	@echo "Running tests..."
	@if [ -d tests ]; then \
		pytest tests/; \
	else \
		echo "No tests directory found"; \
	fi

lint:  ## Run linters
	@echo "Running linters..."
	@if command -v ruff >/dev/null 2>&1; then \
		ruff check .; \
	elif command -v flake8 >/dev/null 2>&1; then \
		flake8 .; \
	else \
		echo "No linter found (install ruff or flake8)"; \
	fi

format:  ## Format code
	@echo "Formatting code..."
	@if command -v black >/dev/null 2>&1; then \
		black .; \
	elif command -v ruff >/dev/null 2>&1; then \
		ruff format .; \
	else \
		echo "No formatter found (install black or ruff)"; \
	fi

validate: format lint  ## Format and lint all files (pre-commit)
	@echo "Validation complete!"

dotfiles:  ## Stow all dotfile packages into ~
	@echo "Stowing dotfiles..."
	@if command -v stow >/dev/null 2>&1; then \
		cd dotfiles && \
		for dir in */; do \
			echo "Stowing $$dir"; \
			stow -t ~ "$$dir"; \
		done; \
	else \
		echo "GNU Stow not installed. Install with: brew install stow"; \
	fi

clean:  ## Clean up generated files
	@echo "Cleaning up..."
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	@if [ -d .venv ]; then rm -rf .venv; fi
	@echo "Cleanup complete!"
