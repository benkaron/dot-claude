```
    ██████╗  ██████╗ ████████╗      ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗
    ██╔══██╗██╔═══██╗╚══██╔══╝     ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝
    ██║  ██║██║   ██║   ██║        ██║     ██║     ███████║██║   ██║██║  ██║█████╗  
    ██║  ██║██║   ██║   ██║        ██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝  
    ██████╔╝╚██████╔╝   ██║        ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗
    ╚═════╝  ╚═════╝    ╚═╝         ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
    
                          Personal Claude Code Configuration
    ═══════════════════════════════════════════════════════════════════════════════
                        Skills • Commands • Agents • Dotfiles
```

# Benk's Claude Code Setup

Personal Claude Code configuration with custom skills, commands, agents, and dotfiles.

## Setup on a new machine

### Desktop notifications (claude-notify)

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

# Auto-start on login
cp com.claude.notify.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.claude.notify.plist

# Start now
open ~/Applications/claude-notify.app
```

On first notification, macOS will prompt for notification permissions.
Allow them in **System Settings > Notifications > ClaudeNotify**.