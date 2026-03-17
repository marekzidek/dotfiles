#!/bin/bash
set -euo pipefail

STATE_FILE="/tmp/tmux-focus-pair-state"

if [ ! -f "$STATE_FILE" ]; then
    tmux display-message "No focus pair state to clear."
    exit 0
fi

# If only pane 1 was stored (no FOCUS_WINDOW), just clear the buffer
if ! grep -q "^FOCUS_WINDOW=" "$STATE_FILE"; then
    rm -f "$STATE_FILE"
    tmux display-message "Focus pair buffer cleared."
    exit 0
fi

# Full revert: swap panes back, kill dummies, kill focus window
source "$STATE_FILE"

tmux swap-pane -s "$PANE1" -t "$DUMMY1"
tmux swap-pane -s "$PANE2" -t "$DUMMY2"

tmux kill-pane -t "$DUMMY1" 2>/dev/null || true
tmux kill-pane -t "$DUMMY2" 2>/dev/null || true
tmux kill-window -t "$FOCUS_WINDOW" 2>/dev/null || true

rm -f "$STATE_FILE"
tmux display-message "Focus pair reverted."

