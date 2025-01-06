#!/bin/bash

source "$HOME/.config/sketchybar/plugins/icon_map.sh"
__icon_map "$INFO"

sketchybar --set $NAME icon="$icon_result" icon.padding_right=5 label="$INFO" 