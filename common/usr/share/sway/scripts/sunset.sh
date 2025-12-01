#!/bin/bash

config="$HOME/.config/wlsunset/config"

#Startup function
function start() {
    [[ -f "$config" ]] && source "$config"
    temp_low=${temp_low:-"4000"}
    temp_high=${temp_high:-"6500"}
    duration=${duration:-"900"}
    sunrise=${sunrise:-"07:00"}
    sunset=${sunset:-"19:00"}
    location=${location:-"on"}
    fallback_longitude=${fallback_longitude:-"8.7"}
    fallback_latitude=${fallback_latitude:-"50.1"}

    if [ "${location}" = "on" ]; then
        if [[ -z ${longitude+x} ]] || [[ -z ${latitude+x} ]]; then
            GEO_CONTENT=$(curl -sL http://ip-api.com/json/)
        fi
        longitude=${longitude:-$(echo "$GEO_CONTENT" | jq '.lon // empty')}
        longitude=${longitude:-$fallback_longitude}
        latitude=${latitude:-$(echo "$GEO_CONTENT" | jq '.lat // empty')}
        latitude=${latitude:-$fallback_latitude}

        echo longitude: "$longitude" latitude: "$latitude"

        wlsunset -l "$latitude" -L "$longitude" -t "$temp_low" -T "$temp_high" -d "$duration" &
    else
        wlsunset -t "$temp_low" -T "$temp_high" -d "$duration" -S "$sunrise" -s "$sunset" &
    fi
}

#Accepts managing parameter
case $1'' in
'off')
    pkill -U $USER -x wlsunset
    pkill -U ${SUDO_USER:-$USER} -x -SIGRTMIN+6 'waybar'
    ;;
'on')
    start
    pkill -U ${SUDO_USER:-$USER} -x -SIGRTMIN+6 'waybar'
    ;;
'toggle')
    if pkill -U $USER -x -0 wlsunset; then
        pkill -U $USER -x wlsunset
    else
        start
    fi
    pkill -U ${SUDO_USER:-$USER} -x -SIGRTMIN+6 'waybar'
    ;;
'check')
    command -v wlsunset
    exit $?
    ;;
esac

#Returns a string for Waybar
if pkill -U $USER -x -0 wlsunset; then
    class="on"
    text="Night Color mode: enabled"
else
    class="off"
    text="Night Color mode: disabled"
fi

printf '{"alt":"%s","tooltip":"%s"}\n' "$class" "$text"
