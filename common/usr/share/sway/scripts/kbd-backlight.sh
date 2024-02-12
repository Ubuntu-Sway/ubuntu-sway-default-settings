#!/usr/bin/env sh
set -x

case $1'' in
'on')
    brightnessctl -r -d "*kbd_backlight"
    ;;
'off')
    brightnessctl -s -d "*kbd_backlight" && brightnessctl -d "*kbd_backlight" set 0
    ;;
esac
