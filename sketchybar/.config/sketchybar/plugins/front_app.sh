#!/bin/bash

ICON_PADDING_RIGHT=5

case $INFO in
  "Arc")
    ICON=":arc:"
    ;;
  "Code")
    ICON=":vscode:"
    ;;
  "Finder")
    ICON=":finder:"
    ;;
  "Firefox")
    ICON=":firefox:"
    ;;
  "GhostTy")
    ICON=":terminal:"
    ;;
  *)
    ICON=":default:"
    ;;
esac

sketchybar --set $NAME icon="$ICON" icon.padding_right=$ICON_PADDING_RIGHT label="$INFO" 