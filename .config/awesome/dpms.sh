#!/bin/sh

# Check if xset is available
if command -v xset > /dev/null; then
  # Place all DPMS settings that you want 
  # to run on awesome-wm startup below:
  xset -dpms
  xset s off
else
  notify-send "Error: DPMS command not found."
fi
