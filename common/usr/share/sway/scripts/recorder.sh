#!/bin/bash

countdown() {
  for count in {3..1}; do
    notify "Recording in $count seconds" -t 1000
    sleep 1
  done
}

notify() {
  notify-send \
    "$1" \
    -i "/usr/share/icons/Yaru/scalable/devices/camera-video-symbolic.svg" \
    "${@:2}"
}

kill_waybar() {
  pkill -RTMIN+8 waybar
}

kill_recursive() {
  ps -o sid= -p "$1" | xargs pkill --signal SIGINT -g
}

cleanup() {
  pid=$(cat "$1")
  rm "$1"
  kill_waybar
  kill_recursive "$pid"
  exit
}

main() {
  pid_file="/tmp/screenrecorder-$UID.pid"

  test -e "$pid_file" && cleanup "$pid_file"
  echo "$$" > "$pid_file"

  target_path=$(xdg-user-dir VIDEOS)
  timestamp=$(date +'recording_%Y%m%d-%H%M%S')

  notify "Select a region to record" -t 1000
  area=$(swaymsg -t get_tree | \
    jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | \
    slurp)

  countdown
  (sleep 0.5 && kill_waybar) &

  if [[ "$1" == "-a" ]]; then
    file="$target_path/$timestamp.mp4"
    wf-recorder --audio -g "$area" --file="$file"
  else
    file="$target_path/$timestamp.webm"
    wf-recorder \
      -g "$area" -c libvpx \
      --codec-param="qmin=0" \
      --codec-param="qmax=25" \
      --codec-param="crf=4" \
      --codec-param="b:v=1M" \
      --file="$file"
  fi

  kill_waybar && notify "Finished recording ${file}"
  rm $pid_file
}
main "$@"
