#!/bin/bash

WINDOW_TITLE=$(/usr/bin/lsappinfo info -only name $(lsappinfo front) | cut -d '"' -f4)

if [[ $WINDOW_TITLE = "" ]]; then
  WINDOW_TITLE="Desktop"
fi

sketchybar --set $NAME label="$WINDOW_TITLE" 