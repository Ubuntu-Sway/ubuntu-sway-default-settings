#!/bin/sh

VOLUME=$(pulsemixer --get-volume)
# get first percent value
VOLUME=${VOLUME%%%*}
VOLUME=${VOLUME##* }

TEXT="Volume: ${VOLUME}%"
case $(pulsemixer --get-mute) in
     *1)
         TEXT="Volume: muted"
         VOLUME=0
         ;;
esac

notify-send \
    --app-name sway \
    --expire-time 800 \
    --hint string:x-canonical-private-synchronous:volume \
    --hint "int:value:$VOLUME" \
    --hint "int:transient:1" \
    "${TEXT}"
