#!/bin/bash

DIRS=(
    "$HOME/repos"
    "$HOME"
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find . "${DIRS[@]}" -type d -maxdepth 1 \
        | sed "s|^$HOME/||" \
        | fzf --margin=10% --color=bw)

    [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

# Check if we're outside tmux
if [[ -z $TMUX ]]; then
    # If no tmux session exists, create one and attach
    if ! tmux has-session -t "$selected_name" 2>/dev/null; then
        tmux new-session -s "$selected_name" -c "$selected"
    else
        tmux attach-session -t "$selected_name"
    fi
    exit 0
fi

# We're inside tmux, so create session if needed and switch to it
if ! tmux has-session -t "$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
