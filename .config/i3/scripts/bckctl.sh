#!/usr/bin/env bash

# Symbols used to build the notification bar
symbol_active="■"
symbol_empty="□"

ICON="/usr/lib/node_modules/material-design-icons/image/1x_web/ic_brightness_7_white_18dp.png"
function get_bright
{
xbacklight -get | awk -F '.' '{print $1}'
}

function display_notification
{
  local bright_current=$(get_bright)

  # First 100% - ■ ▦ ▣ ▧ □
  for (( i = 10; i <= 100; i += 10 )); do
    if [[ $i -le $bright_current ]]; then
      bright_bar+="$symbol_active "
    else
      bright_bar+="$symbol_empty "
    fi
  done

  # Forward to Notification Daemon
  dunstify -u normal -i $ICON "$bright_bar" -t 1000 -r 30171
}

case "$1" in
  "")
    printf "Missing argument - "
    ;&
  -h|--help)
    printf "usage: $(basename $0) [dec/inc/get]\n"
    exit 0
    ;;
  dec)
    xbacklight -dec 10
    ;;
  inc)
    xbacklight -inc 10
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
