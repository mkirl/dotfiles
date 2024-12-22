#!/bin/bash

CURRENT_SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | awk -F'"' '{print $2}')

if [ "$CURRENT_SOURCE" = "" ]; then
  CURRENT_SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "InputSourceKind" | awk -F'"' '{print $2}')
fi

sketchybar --set $NAME icon="⌨" label="$CURRENT_SOURCE" 