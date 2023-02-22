#!/bin/sh

if ! command -v notify-send >/dev/null || ! command -v pactl > /dev/null; then
    exit 0;
fi

# pactl output depends on the current locale
export LANG=C.UTF-8 LC_ALL=C.UTF-8

SINK=${1:-@DEFAULT_SINK@}
VOLUME=$(pactl get-sink-volume "$SINK")
# get first percent value
VOLUME=${VOLUME%%%*}
VOLUME=${VOLUME##* }

TEXT="Volume: ${VOLUME}%"
case $(pactl get-sink-mute "$SINK") in
    *yes)
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
