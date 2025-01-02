#!/bin/bash

# Those queries take a lot of time (100ms)
workspace_query_json=$(/opt/homebrew/bin/aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json)
windows_query_json=$(/opt/homebrew/bin/aerospace list-windows --all --format '%{app-name} %{workspace}' --json)

# Update per workspace
for workspace in $(echo $workspace_query_json | jq -r ".[] | .workspace"); do
  workspace_display_id=$(echo "$workspace_query_json" | jq -r ".[] | select(.workspace == \"$workspace\") | .\"monitor-appkit-nsscreen-screens-id\"")

  # Get all the windows in the workspace
  windows_in_workspace=$(echo "$windows_query_json" | jq -r ".[] | select(.workspace == \"$workspace\") | .\"app-name\"")

  # Check if this is the focused workspace
  CURRENT_WORKSPACE=$(/opt/homebrew/bin/aerospace list-workspaces --focused)
  if [ "$workspace" = "$CURRENT_WORKSPACE" ]; then
    background_color="0x00000000"
    border_color="0xFFFF9800"
    border_width=2
  else
    background_color="0x00000000"
    border_color="0xFF2962FF"
    border_width=2
  fi

  # check if any windows in the workspace
  if [ "$windows_in_workspace" = "" ]; then
    label="-"
    label_font="FiraCode Nerd Font:Bold:16.0"
  else
    source "$HOME/.config/sketchybar/plugins/icon_map.sh"
    label=""
    label_font="FiraCode Nerd Font:Bold:16.0"
    # Set IFS to newline to handle multi-word app names correctly
    IFS=$'\n'
    for window in $windows_in_workspace; do
      __icon_map "$window"
      label="$label$icon_result "
    done
    # Reset IFS to its default value
    unset IFS
  fi

  sketchybar --set "space.$workspace" \
    label="$label" \
    label.drawing=on \
    label.font="$label_font" \
    display="$workspace_display_id" \
    background.color="$background_color" \
    background.border_color="$border_color" \
    background.border_width="$border_width"
done

# Update the current front app title
focused_window_title=$(/opt/homebrew/bin/aerospace list-windows --focused --format "%{window-title}")
sketchybar --set "front_app.title" label="$focused_window_title" 