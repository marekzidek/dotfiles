#!/bin/bash
set -euo pipefail

STATE_FILE="/tmp/tmux-focus-pair-state"
CURRENT_PANE=$(tmux display-message -p '#{pane_id}')

# STATE MACHINE:
# No state file → store pane 1
# State file with PANE1 only → store pane 2 and create focus view
# State file with full focus pair → already active, show message

if [ ! -f "$STATE_FILE" ]; then
    # --- FIRST HIT: Store pane 1 ---
    echo "PANE1=$CURRENT_PANE" > "$STATE_FILE"
    tmux display-message "Focus pair: pane 1 stored ($CURRENT_PANE). Navigate to pane 2 and hit prefix+j again."
    exit 0
fi

# Check if we're in "pane 1 stored" state or "full focus pair" state
if grep -q "^FOCUS_WINDOW=" "$STATE_FILE"; then
    tmux display-message "Focus pair already active. Prefix+J to revert."
    exit 1
fi

# --- SECOND HIT: Store pane 2, create focus view ---
source "$STATE_FILE"
PANE2=$CURRENT_PANE

# Don't pair a pane with itself
if [ "$PANE1" = "$PANE2" ]; then
    tmux display-message "Same pane selected twice. Pick a different pane."
    exit 1
fi

# Create dummy placeholder for pane 1
DUMMY1=$(tmux split-window -t "$PANE1" -P -F '#{pane_id}' -l 1 "sleep 99999")
tmux swap-pane -s "$PANE1" -t "$DUMMY1"

# Create dummy placeholder for pane 2
DUMMY2=$(tmux split-window -t "$PANE2" -P -F '#{pane_id}' -l 1 "sleep 99999")
tmux swap-pane -s "$PANE2" -t "$DUMMY2"

# Create new focus-pair window
tmux new-window -n "focus-pair"
FOCUS_WINDOW=$(tmux display-message -p '#{window_id}')
DEFAULT_PANE=$(tmux display-message -p '#{pane_id}')

# Move both panes into the new window
tmux join-pane -s "$PANE1" -t "$DEFAULT_PANE"
tmux kill-pane -t "$DEFAULT_PANE"
tmux join-pane -h -s "$PANE2" -t "$PANE1"

# Save full state
cat > "$STATE_FILE" <<EOF
PANE1=$PANE1
DUMMY1=$DUMMY1
PANE2=$PANE2
DUMMY2=$DUMMY2
FOCUS_WINDOW=$FOCUS_WINDOW
EOF

tmux display-message "Focus pair active. Prefix+J to revert."

