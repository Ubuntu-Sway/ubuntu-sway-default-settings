#!/bin/sh
set -x
# toggles the help wrapper state

VISIBILITY_SIGNAL=30
QUIT_SIGNAL=2

if [ "$1" = "--toggle" ]; then
  pkill -f -${VISIBILITY_SIGNAL} 'nwg-wrapper.*-s help.sh'
else
  pkill -f -${QUIT_SIGNAL} 'nwg-wrapper.*-s help.sh'
  for output in $(swaymsg -t get_outputs --raw | jq -r '.[].name'); do
    nwg-wrapper -o "$output" -i -sv ${VISIBILITY_SIGNAL} -sq ${QUIT_SIGNAL} -s help.sh -p left -a end &
  done
fi
