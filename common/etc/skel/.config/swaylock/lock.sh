#!/bin/bash

# This script takes a screenshot of current output and adds a blur and vignette to it

cd /tmp
grim screen.png

# Delete existing image
rm screen-out.png

#Adds a blur and vignette
ffmpeg -i screen.png -vf "gblur=sigma=10, vignette=PI/5" -c:a copy screen-out.png

#Uses output image with Swaylock
swaylock \
--image screen-out.png \
--indicator-caps-lock \
--ignore-empty-password \
--show-failed-attempts \
--show-keyboard-layout \
--font=Ubuntu \
--inside-color 1b1b1b \
--inside-clear-color eeeeee \
--ring-color 3B758C \
--ring-clear-color 9fca56 \
--ring-ver-color 2980b9 \
--daemonize
