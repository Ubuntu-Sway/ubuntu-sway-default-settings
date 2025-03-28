#!/bin/bash

export LC_ALL=C

OUT_NAME="HEADLESS-1"
TIP="Tip: use ${OUT_NAME} to cast only chosen windows"

swaymsg -t get_outputs \
  | jq -r '.[] | .name' \
  | fuzzel \
    --dmenu \
    --lines=4 \
    --prompt="Select the output for the screencast: " \
    --placeholder "${TIP}" \
    --font=Ubuntu:size=11 \
    --width=50
