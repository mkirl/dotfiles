#!/bin/bash

sketchybar --add item front_app left \
           --set front_app icon.drawing=off \
                          background.color=$BACKGROUND_1 \
                          background.corner_radius=5 \
                          background.height=22 \
                          background.padding_left=5 \
                          background.padding_right=5 \
                          label.color=$WHITE \
                          label.padding_left=5 \
                          label.padding_right=5 \
                          script="$PLUGIN_DIR/front_app.sh" 