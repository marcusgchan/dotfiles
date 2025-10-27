#!/usr/bin/env bash

macos=("aerospace" "ghostty" "nvim" "tmux" "scripts")
linux=("ghostty" "nvim" "tmux" "scripts" "i3" "kitty" "waybar" "hypr")

if [[ "$OSTYPE" == "darwin"* ]]; then
  for pkg in "${macos[@]}"; do
    stow -vv -t ~ "$pkg"
  done
else
  for pkg in "${linux[@]}"; do
    stow -vv -t ~ "$pkg"
  done
fi
