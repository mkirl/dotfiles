#!/bin/bash

# Get the current volume and mute status
VOLUME=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')

if [[ $MUTED == "true" ]]; then
  ICON="󰝟"
  VOLUME="muted"
elif [[ $VOLUME == 0 ]]; then
  ICON="󰝟"
elif [[ $VOLUME < 50 ]]; then
  ICON="󰕿"
else
  ICON="󰕾"
fi

# Update sketchybar
sketchybar --set $NAME icon="$ICON" label="$VOLUME%" 