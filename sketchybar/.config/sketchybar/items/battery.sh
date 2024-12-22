#!/bin/bash

sketchybar --add item battery right \
           --set battery update_freq=3 \
                         icon.color=$WHITE \
                         icon.padding_left=10 \
                         icon.padding_right=5 \
                         label.color=$WHITE \
                         label.padding_right=10 \
                         background.color=$BACKGROUND_1 \
                         background.corner_radius=5 \
                         background.height=22 \
                         background.padding_right=3 \
                         script="$PLUGIN_DIR/battery.sh" 