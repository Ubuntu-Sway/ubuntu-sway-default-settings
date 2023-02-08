#!/bin/sh
# Author: Caleb Stewart
# URL: https://github.com/calebstewart/swaycwd.git
# Description: print the CWD of the currently focused window in swaywm

# Grab the window/display tree
TREE=$(swaymsg -t get_tree)
# Find the focused node
TREE_PATH=$(echo "$TREE" | gron | grep "focused = true" | sed 's/.focused.*$/.pid/g;s/^json//g')
# Find the PID of the process
PID=$(echo "$TREE" | jq "$TREE_PATH")

# how far down does the rabbit hole go? D:
while pgrep -P "$PID" >/dev/null; do
  PID=$(pgrep -P "$PID" | tail -n1)
done

# Show the current working directory
readlink -e "/proc/$PID/cwd"
