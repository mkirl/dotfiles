#!/bin/bash

sketchybar --add item weather right \
           --set weather update_freq=1800 \
                       icon.color=$WHITE \
                       icon.padding_left=10 \
                       icon.padding_right=5 \
                       label.color=$WHITE \
                       label.padding_right=10 \
                       background.color=$BACKGROUND_1 \
                       background.corner_radius=5 \
                       background.height=22 \
                       background.padding_right=3 \
                       script="$PLUGIN_DIR/weather.sh" 