#!/bin/bash

check_status() {
  grep -s -l -v "closed" \
    /proc/asound/card*/pcm*/sub*/status \
    &>/dev/null
}

out() {
  printf "Idle inhibition is OFF.\n"
  exit 0
}

watch_status() {
  printf "Idle inhibition is ON.\n"
  while check_status; do
    sleep 10
  done
  out
}

main() {
  check_status || out
  test "$1" = "-w" && watch_status
  systemd-inhibit \
    --what=idle \
    --who="${0##*/}" \
    --why="Inhibit idle due to audio is now playing" \
    --mode=block \
    "$0" -w
}
main "$@"
