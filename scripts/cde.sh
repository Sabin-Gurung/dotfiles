#!/usr/bin/env bash
set -e

dir_name=$(basename "$PWD")

# create new window in current session, start in current dir
window_id=$(tmux new-window -c "$PWD" -n "$dir_name" -P -F "#{window_id}")

# LEFT pane (main)
left_pane="${window_id}.1"

tmux split-window -h -t "$left_pane" -c "$PWD" -l 70
right_pane="${window_id}.2"

# run gemini on right
tmux send-keys -t "$right_pane" "gemini" Enter

# split LEFT pane horizontally (bottom 20%)
tmux split-window -v -t "$left_pane" -c "$PWD" -l 15
bottom_pane="${window_id}.3"

# run nvim on top-left
tmux send-keys -t "$left_pane" "nvim" Enter

# focus top-left
tmux select-pane -t "$left_pane"


