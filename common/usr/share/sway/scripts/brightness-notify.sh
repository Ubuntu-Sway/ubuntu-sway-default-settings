#!/bin/sh

VALUE=$(echo "$(brightnessctl get) * 100 / $(brightnessctl max)" | bc)
TEXT="Brightness: ${VALUE}%"

notify-send \
    --expire-time 800 \
    --hint string:x-canonical-private-synchronous:brightness \
    --hint "int:value:$VALUE" \
    --hint "int:transient:1" \
    "${TEXT}"
