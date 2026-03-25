```
    ██████╗  ██████╗ ████████╗      ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗
    ██╔══██╗██╔═══██╗╚══██╔══╝     ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝
    ██║  ██║██║   ██║   ██║        ██║     ██║     ███████║██║   ██║██║  ██║█████╗
    ██║  ██║██║   ██║   ██║        ██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝
    ██████╔╝╚██████╔╝   ██║        ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗
    ╚═════╝  ╚═════╝    ╚═╝         ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝

                         One Repo to Rule Them All
    ═══════════════════════════════════════════════════════════════════════════════
                Skills • Hooks • Agents • Rules • Dotfiles
```

# Benk's Claude Code Setup

Everything I need on a new machine — Claude Code configuration, terminal dotfiles, and developer tooling — in one repo.

## What's in here

| Directory | Purpose |
| --- | --- |
| `skills/` | On-demand reference docs loaded via skill matching |
| `hooks/` | Shell scripts triggered by Claude Code events |
| `agents/` | Custom agent definitions |
| `rules/` | Always-loaded behavioral rules |
| `dotfiles/` | GNU Stow packages: ghostty, nvim, starship, zsh |
| `settings.json` | Permissions, hooks config, plugins, env vars |

## Setup on a new machine

### 1. Clone and install

```bash
git clone https://github.com/benkaron/dot-claude.git ~/.claude
cd ~/.claude
make install    # uv sync + pre-commit install + stow dotfiles
```

### 2. Font (Ioskeley Mono)

[Ioskeley Mono](https://github.com/ahatem/IoskeleyMono) — an Iosevka config that mimics Berkeley Mono (SIL Open Font License).

```bash
# Download latest release and install
cd /tmp
curl -LO https://github.com/ahatem/IoskeleyMono/releases/latest/download/IoskeleyMono-Normal.zip
unzip IoskeleyMono-Normal.zip -d IoskeleyMono
cp IoskeleyMono/*.ttf ~/Library/Fonts/
```

The Ghostty config references `Ioskeley Mono` — install the font before launching.

### 3. Machine-local shell config

`make install` stows a shared `.zshrc` that sources two optional local files (not tracked in git):

- **`~/.local.zsh`** — machine-specific paths and tools (conda, homebrew, etc.)
- **`~/.secrets.zsh`** — API keys and tokens

Create `~/.local.zsh` for anything that varies per machine:

```bash
# Example: conda setup, custom PATH entries, etc.
cat > ~/.local.zsh << 'EOF'
# Machine-local config (not tracked in git)
# Add conda init block, custom PATHs, etc. here
EOF
```

### 4. Desktop notifications (claude-notify)

Native macOS notifications with click-to-focus. Required for the Notification and Stop hooks.

```bash
# Build from source (requires Xcode CLI tools)
cd /tmp
git clone https://github.com/armandsalle/claude-notify.git
cd claude-notify
bash build.sh

# Install to ~/Applications
mkdir -p ~/Applications
cp -r .build/release/ClaudeNotify.app ~/Applications/claude-notify.app
codesign --force --deep --sign - ~/Applications/claude-notify.app

# Auto-start on login (fix path in plist first)
sed "s|/Applications/ClaudeNotify.app|$HOME/Applications/claude-notify.app|" \
  com.claude.notify.plist > ~/Library/LaunchAgents/com.claude.notify.plist
launchctl load ~/Library/LaunchAgents/com.claude.notify.plist
```

On first notification, macOS will prompt for notification permissions.
Allow them in **System Settings > Notifications > ClaudeNotify**.

### 5. Conversation history search (glhf)

Search past Claude Code sessions for solutions, commands, and approaches.

```bash
# Install from source (requires Rust toolchain)
cargo install --git https://github.com/TrevorS/glhf glhf

# Build the search index (takes a few seconds)
glhf index
```

Usage: `glhf search "query" --mode semantic --compact`

## Day-to-day

```bash
make validate   # Run all checks (pre-commit)
make dotfiles   # Re-stow all dotfile packages
make help       # Show all targets
```
