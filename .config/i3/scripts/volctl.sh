#!/usr/bin/env bash

# Symbols used to build the notification bar
symbol_active="■"
symbol_empty="□"

upIcon="/lib/node_modules/material-design-icons/av/1x_web/ic_volume_up_white_18dp.png"
downIcon="/lib/node_modules/material-design-icons/av/1x_web/ic_volume_down_white_18dp.png"
muteIcon="/lib/node_modules/material-design-icons/av/1x_web/ic_volume_off_white_18dp.png"

function is_muted
{
  test "$vol_muted" = 'off'
}

function get_vol
{
 amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | tr -d '%'
}

function display_notification
{
  local vol_current=$(get_vol)

  # First 100% - ■ ▦ ▣ ▧ □
  for (( i = 10; i <= 100; i += 10 )); do
    if [[ $i -le $vol_current ]]; then
      vol_bar+="$symbol_active "
    else
      vol_bar+="$symbol_empty "
    fi
  done

  # Forward to Notification Daemon
  dunstify -u normal -i $ICON "$vol_bar" -t 1000 -r 30171
}

case "$1" in
  "")
    printf "Missing argument - "
    ;&
  -h|--help)
    printf "usage: $(basename $0) [tog/dec/inc/get]\n"
    exit 0
    ;;
  tog)
    amixer -q set Master toggle
    vol_muted=$(amixer sget Master | tail -1 | cut -d' ' -f8 | sed 's/\(\[\|\]\)//g')

    if is_muted; then
    	ICON=$muteIcon
    else
    	ICON=$upIcon
     fi
    ;;
  dec)
    amixer -q set Master 5%- unmute
    ICON=$downIcon
    ;;
  inc)
     ICON=$upIcon
     amixer -q set Master 5%+ unmute
    ;;
  get)
    ;;
  *)
    (>&2 echo "Unknown command: $1")
    exit 1
    ;;
esac

# Run Main Script
display_notification
