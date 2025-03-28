#!/bin/bash
#
# This script implements the function of mirroring outputs.
# It uses wl-mirror and Sway's ability to create headless outputs.
#
# The script is written as a singleton. It allows the user to run only one
# instance of itself and kills all others. This is necessary so that wl-mirror
# instances do not interfere with each other.

SELF_NAME="$(basename "$0")"
SELF_PID="$$"

get_pgid() {
  ps -h -o "%r" -p "$1" | awk '{print $1}'
}
SELF_PGID="$(get_pgid "$SELF_PID")"

kill_by_pgid() {
  pkill -"$2" -g "$1"
}

kill_copies() {
  mapfile -t pids < <(pgrep -u "$USER" -x "$SELF_NAME")
  for pid in "${pids[@]}" ; do
    pgid="$(get_pgid "$pid")"
    [[ $pgid -ne $SELF_PGID ]] && kill_by_pgid "$pgid" "INT"
  done
}

main() {
  # Don't single quote the trap's command!
  # It must be expanded when the trap is defined.
  # shellcheck disable=SC2064
  trap "kill_by_pgid $SELF_PGID TERM" INT
  kill_copies
  [[ "$1" != "-k" ]] && wl-mirror -F "${1:-HEADLESS-1}"
}
main "$@"
