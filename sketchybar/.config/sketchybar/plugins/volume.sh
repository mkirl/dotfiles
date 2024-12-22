#!/bin/bash

source "$CONFIG_DIR/icons.sh"

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [[ $MUTED == "true" ]]; then
  ICON=$VOLUME_0
  VOLUME=0
else
  case ${VOLUME} in
    100) ICON=$VOLUME_100
    ;;
    [6-9][0-9]) ICON=$VOLUME_66
    ;;
    [3-5][0-9]) ICON=$VOLUME_33
    ;;
    [1-2][0-9]) ICON=$VOLUME_10
    ;;
    *) ICON=$VOLUME_0
  esac
fi

sketchybar --set $NAME icon="$ICON" label="${VOLUME}%" 