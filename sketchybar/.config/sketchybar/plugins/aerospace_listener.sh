#!/bin/bash

# This script listens for aerospace workspace changes and updates sketchybar
aerospace listen workspace-change exec -- sketchybar --trigger aerospace_workspace_change &

# Also listen for window focus changes to update workspace indicators
aerospace listen window-focus-change exec -- sketchybar --trigger aerospace_window_change &
