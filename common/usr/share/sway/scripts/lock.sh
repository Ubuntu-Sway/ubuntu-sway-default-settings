#!/bin/bash

# Swaylock run's with additional features, e.g. adding screenshot to background
SWAYLOCK_USER_SCRIPT="$HOME/.config/swaylock/lock.sh"
SWAYLOCK_GLOB_SCRIPT="/usr/share/sway/scripts/swaylock.sh"

if [ -x "$(command -v gtklock)" ]; then
    gtklock --daemonize --follow-focus --idle-hide --start-hidden
elif [ -x "$(command -v swaylock)" ]; then
    if [[ -x "$SWAYLOCK_USER_SCRIPT" ]]; then
        "$SWAYLOCK_USER_SCRIPT"
    else
        "$SWAYLOCK_GLOB_SCRIPT"
    fi
fi
