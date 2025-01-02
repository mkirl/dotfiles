#!/bin/bash

# Add debug logging
echo "$(date): Workspace script triggered" >> /tmp/sketchybar_workspace.log

# Get the current workspace directly from aerospace
CURRENT_WORKSPACE=$(aerospace list-workspaces --current)
echo "$(date): Current workspace: $CURRENT_WORKSPACE" >> /tmp/sketchybar_workspace.log

# Exit if we can't determine the current workspace
if [ -z "$CURRENT_WORKSPACE" ]; then
  echo "$(date): No current workspace found" >> /tmp/sketchybar_workspace.log
  exit 0
fi

# Update all workspace items
for sid in $(aerospace list-workspaces --all); do
  if [ "$sid" = "$CURRENT_WORKSPACE" ]; then
    # Active workspace
    sketchybar --set space.$sid \
      background.color=0x40ffffff \
      label.color=0xffffffff \
      icon.color=0xffffffff \
      background.border_color=0xFF92B3F5
  else
    # Inactive workspace
    sketchybar --set space.$sid \
      background.color=0x00000000 \
      label.color=0xFF92B3F5 \
      icon.color=0xFFFFFFFF \
      background.border_color=0xA092B3F5
  fi
done

# Log completion
echo "$(date): Workspace update completed" >> /tmp/sketchybar_workspace.log 