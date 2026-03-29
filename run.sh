#!/usr/bin/env bash

macos=("zsh" "ohmyposh" "aerospace" "ghostty" "nvim" "tmux" "scripts")
linux=("zsh" "ohmyposh" "ghostty" "nvim" "tmux" "scripts" "i3" "kitty" "waybar" "hypr")

if [[ "$OSTYPE" == "darwin"* ]]; then
  for pkg in "${macos[@]}"; do
    stow -vv -t ~ "$pkg"
  done
else
  for pkg in "${linux[@]}"; do
    stow -vv -t ~ "$pkg"
  done
fi
