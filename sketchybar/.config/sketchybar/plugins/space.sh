#!/bin/bash

echo "Space.sh called with SENDER=$SENDER NAME=$NAME AEROSPACE_FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE" >> /tmp/sketchybar_debug.log

update() {
  if [ "$SENDER" = "aerospace_workspace_change" ]; then
    source "$CONFIG_DIR/colors.sh"
    COLOR=$BACKGROUND_2
    
    # Get the current focused workspace
    CURRENT_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE
    echo "Updating workspace $CURRENT_WORKSPACE" >> /tmp/sketchybar_debug.log
    
    # Reset all workspaces to default state
    for i in 1 2 3 4 5 6 7 10; do
      sketchybar --set space.$i icon.highlight=false \
                        label.highlight=false \
                        background.border_color=$BACKGROUND_2
    done
    
    # Highlight the current workspace
    sketchybar --set space.$CURRENT_WORKSPACE icon.highlight=true \
                      label.highlight=true \
                      background.border_color=$GREY
  fi
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    echo ''
  else
    if [ "$MODIFIER" = "shift" ]; then
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
      if [ $? -eq 0 ]; then
        if [ "$SPACE_LABEL" = "" ]; then
          sketchybar --set $NAME icon="${NAME:6}"
        else
          sketchybar --set $NAME icon="${NAME:6} ($SPACE_LABEL)"
        fi
      fi
    else
      echo "Switching to workspace ${NAME#*.}" >> /tmp/sketchybar_debug.log
      aerospace workspace ${NAME#*.}
    fi
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac 