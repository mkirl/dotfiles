#!/bin/bash

update() {
  source "$CONFIG_DIR/colors.sh"
  COLOR=$SURFACE0
  BORDER_COLOR=$SURFACE1
  
  if [ "$SELECTED" = "true" ]; then
    COLOR=$SURFACE1
    BORDER_COLOR=$OVERLAY0
  fi
  
  sketchybar --set $NAME background.color=$COLOR \
                         background.border_color=$BORDER_COLOR \
                         icon.color=$LABEL_COLOR
}

case "$SENDER" in
  "mouse.entered") sketchybar --set $NAME background.border_color=$OVERLAY0
  ;;
  "mouse.exited") update
  ;;
  "space_change") update
  ;;
  "aerospace_workspace_change") update
  ;;
esac 