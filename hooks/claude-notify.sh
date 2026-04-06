#!/bin/bash
# Hook: Notification + Stop — Send macOS desktop notifications via claude-notify.app.
# Reads JSON from stdin, extracts message, and passes it to the binary.
# Exits 0 if binary is missing (e.g. SSH).

BINARY="$HOME/Applications/claude-notify.app/Contents/MacOS/ClaudeNotify"
test -x "$BINARY" || exit 0

input=""
while IFS= read -r -t 5 line; do
  input="${input}${line}"
done
message=$(echo "$input" | jq -r '.message // "Claude Code needs your attention"' 2>/dev/null)

exec "$BINARY" -m "$message" -a "com.mitchellh.ghostty"
