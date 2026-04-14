# Shared shell config (managed via dot-claude repo)

# Machine-local config (conda, homebrew paths, etc.)
[[ -f ~/.local.zsh ]] && source ~/.local.zsh

# Secrets (API keys, tokens, etc.)
[[ -f ~/.secrets.zsh ]] && source ~/.secrets.zsh

# Rust/Cargo
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# lazysql — use XDG config path (cross-platform)
alias lazysql='lazysql -config ~/.config/lazysql/config.toml'

# Starship prompt
eval "$(starship init zsh)"
