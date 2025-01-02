#!/bin/bash

# Format the date and time
DATE=$(date '+%a %d %b')
TIME=$(date '+%H:%M')

# Update sketchybar
sketchybar --set $NAME label="$TIME $DATE" 