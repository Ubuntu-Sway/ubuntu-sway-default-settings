#!/bin/bash

USER_SCRIPT="$HOME/.config/swaylock/lock.sh"
GLOB_SCRIPT="/usr/share/sway/scripts/swaylock.sh"

if [[ -x "$USER_SCRIPT" ]]; then
    "$USER_SCRIPT"
else
    "$GLOB_SCRIPT"
fi
