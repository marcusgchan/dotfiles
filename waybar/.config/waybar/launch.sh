#!/usr/bin/env bash

pkill waybar

if [[ $USER = "marcus" ]] then
  waybar -c ~/.config/waybar/config & -s ~/.config/waybar/styles.css
else
  waybar &
fi
