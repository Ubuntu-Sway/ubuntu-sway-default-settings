#!/bin/sh

set -e
DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}

while true; do
    mkdir -p "$DIR" && inotifywait -q -e create "$DIR" --format '%w%f' | xargs notify-send "Screenshot saved"
done
