#!/bin/bash

# Get current workspace from aerospace
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

# Check if this workspace is the current one
if [ "$CURRENT_WORKSPACE" = "$NAME" ]; then
  BACKGROUND_COLOR=0xff7dc4e4
  ICON_COLOR=0xff181926
else
  # Check if workspace has windows
  WORKSPACE_NUMBER=$(echo "$NAME" | sed 's/workspace\.//')
  WINDOWS=$(aerospace list-windows --workspace "$WORKSPACE_NUMBER" | wc -l | tr -d ' ')
  
  if [ "$WINDOWS" -gt 0 ]; then
    BACKGROUND_COLOR=0x44ffffff
    ICON_COLOR=0xffffffff
  else
    BACKGROUND_COLOR=0x00000000
    ICON_COLOR=0xff9ca0b0
  fi
fi

sketchybar --set "$NAME" background.color="$BACKGROUND_COLOR" \
                         background.drawing=on \
                         icon.color="$ICON_COLOR"
