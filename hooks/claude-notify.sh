#!/bin/bash
# Hook: Notification + Stop — Send macOS desktop notifications via terminal-notifier.
# Reads JSON from stdin, extracts message, fires a silent notification that focuses
# Ghostty on click. Exits cleanly without leaking processes.

command -v terminal-notifier >/dev/null || exit 0

input=$(timeout 1 cat 2>/dev/null)
message=$(echo "$input" | jq -r '.message // "Claude Code needs your attention"' 2>/dev/null)

terminal-notifier \
  -title "Claude Code" \
  -message "$message" \
  -activate "com.mitchellh.ghostty" \
  -group "claude-code" \
  >/dev/null 2>&1

exit 0
