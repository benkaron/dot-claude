.PHONY: help install validate clean pre-commit pre-commit-install pre-commit-update dotfiles

help:  ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install:  ## Install all dependencies and stow dotfiles
	@uv sync
	@uv run pre-commit install
	@$(MAKE) dotfiles

validate:  ## Run all checks: formatting, linting, markdown
	@uv run pre-commit run --all-files

pre-commit:  ## Alias for validate
	@$(MAKE) validate

dotfiles:  ## Stow all dotfile packages into ~
	@if ! command -v stow >/dev/null 2>&1; then \
		echo "stow not found — install with: brew install stow"; \
	else \
		for pkg in dotfiles/*/; do \
			name=$$(basename $$pkg); \
			echo "Stowing $$name..."; \
			stow --adopt -d dotfiles -t ~ $$name; \
		done; \
	fi

pre-commit-install:  ## Install pre-commit hooks (one-time)
	@uv run pre-commit install

pre-commit-update:  ## Update pre-commit hooks to latest versions
	@uv run pre-commit autoupdate

clean:  ## Remove .venv and caches
	rm -rf .venv __pycache__ .pytest_cache
