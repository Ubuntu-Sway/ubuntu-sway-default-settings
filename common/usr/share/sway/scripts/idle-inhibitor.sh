#!/bin/bash

set -e

if grep -s -l -v "closed" /proc/asound/card*/pcm*/sub*/status; then
  swaymsg inhibit_idle open
  printf "Idle inhibition is ON."
else
  swaymsg inhibit_idle none
  printf "Idle inhibition is OFF."
fi
