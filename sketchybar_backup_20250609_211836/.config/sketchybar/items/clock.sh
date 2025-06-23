#!/bin/bash

sketchybar --add item clock right \
           --set clock update_freq=1 \
                        icon=󱑎 \
                        icon.padding_left=10 \
                        label.padding_right=10 \
                        background.color=0x00000000 \
                        script="$PLUGIN_DIR/clock.sh" 