#!/bin/bash

# Get focused workspace first for immediate feedback
CURRENT_WORKSPACE=$(/opt/homebrew/bin/aerospace list-workspaces --focused)

# Update focused workspace border immediately
sketchybar --set space.$CURRENT_WORKSPACE background.border_color=0xFFFF9800 background.border_width=2

# Update other workspaces in the background
{
  # Get window info
  windows_query_json=$(/opt/homebrew/bin/aerospace list-windows --all --format '%{app-name} %{workspace}' --json)

  # Update all workspaces
  for workspace in $(/opt/homebrew/bin/aerospace list-workspaces --all); do
    # Set border color based on focus
    if [ "$workspace" != "$CURRENT_WORKSPACE" ]; then
      sketchybar --set space.$workspace background.border_color=0xFF2962FF background.border_width=2
    fi

    # Get all the windows in the workspace
    windows_in_workspace=$(echo "$windows_query_json" | jq -r ".[] | select(.workspace == \"$workspace\") | .\"app-name\"")

    # check if any windows in the workspace
    if [ "$windows_in_workspace" = "" ]; then
      label="-"
    else
      source "$HOME/.config/sketchybar/plugins/icon_map.sh"
      label=""
      # Set IFS to newline to handle multi-word app names correctly
      IFS=$'\n'
      for window in $windows_in_workspace; do
        __icon_map "$window"
        label="$label$icon_result "
      done
      # Reset IFS to its default value
      unset IFS
    fi

    sketchybar --set space.$workspace label="$label"
  done

  # Update the current front app title
  focused_window_title=$(/opt/homebrew/bin/aerospace list-windows --focused --format "%{window-title}")
  sketchybar --set "front_app.title" label="$focused_window_title"
} & 