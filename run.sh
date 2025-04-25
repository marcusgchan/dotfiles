#!/usr/bin/env bash

macos=("aerospace" "kitty" "nvim" "tmux")

if [[ "$OSTYPE" == "darwin"* ]]; then
  for pkg in "${macos[@]}"; do
    stow -vv -t ~ "$pkg"
  done
else
  for pkg in */; do
    pkg="${pkg%/}"  # remove trailing slash
    if [[ ! " ${macos[*]} " =~ " $pkg " ]]; then
      stow -vv -t ~ "$pkg"
    fi
  done
fi
