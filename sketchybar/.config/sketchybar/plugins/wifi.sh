#!/bin/bash

source "$CONFIG_DIR/icons.sh"

WIFI=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
SSID=$(echo "$WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME icon=$WIFI_DISCONNECTED label="Disconnected"
else
  sketchybar --set $NAME icon=$WIFI_CONNECTED label="$SSID"
fi 