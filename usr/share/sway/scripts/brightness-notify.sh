#!/bin/sh

VALUE=$(light -G | cut -d'.' -f1)
TEXT="Brightness: ${VALUE}%"

notify-send \
    --expire-time 800 \
    --hint string:x-canonical-private-synchronous:brightness \
    --hint "int:value:$VALUE" \
    --hint "int:transient:1" \
    "${TEXT}"
