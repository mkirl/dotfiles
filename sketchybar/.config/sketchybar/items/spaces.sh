#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space space.$sid left \
             --set space.$sid associated_space=$sid \
                              icon=${SPACE_ICONS[i]} \
                              icon.padding_left=8 \
                              icon.padding_right=8 \
                              background.padding_left=5 \
                              background.padding_right=5 \
                              background.color=$SURFACE0 \
                              background.corner_radius=6 \
                              background.height=24 \
                              background.border_width=1 \
                              background.border_color=$SURFACE1 \
                              background.drawing=on \
                              label.drawing=off \
                              script="$PLUGIN_DIR/space.sh" \
                              click_script="aerospace workspace $sid"
done

sketchybar --add item space_separator left \
           --set space_separator icon= \
                                background.drawing=off \
                                label.drawing=off 