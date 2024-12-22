local colors = require("colors")
local settings = require("settings")

local wifi = sbar.add("item", "wifi", {
  position = "right",
  icon = {
    string = "󰖩",
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Regular"],
      size = 16.0,
    },
    padding_right = 8,
    color = colors.green,
  },
  label = {
    string = "Checking...",
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 12.0,
    },
    color = colors.text,
    padding_right = 8,
  },
})

-- Create a shell script to handle wifi updates
local wifi_script = [[
#!/bin/bash

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [ "$SSID" = "" ]; then
  ICON="󰖪"
  LABEL="Disconnected"
else
  SIGNAL=$(echo "$CURRENT_WIFI" | grep -o "agrCtlRSSI: .*" | sed 's/^agrCtlRSSI: //')
  
  if [ "$SIGNAL" -gt -50 ]; then
    ICON="󰖩"
  elif [ "$SIGNAL" -gt -70 ]; then
    ICON="󰖧"
  else
    ICON="󰖪"
  fi
  
  if [ "$CURR_TX" = "" ]; then
    CURR_TX="0"
  fi
  LABEL="${SSID} (${CURR_TX}Mbps)"
fi

sketchybar --set wifi icon="$ICON" label="$LABEL"
]]

-- Write the script to a file
local script_path = os.getenv("HOME") .. "/.config/sketchybar/plugins/wifi.sh"
local f = io.open(script_path, "w")
f:write(wifi_script)
f:close()
os.execute("chmod +x " .. script_path)

-- Update every 30 seconds
wifi:subscribe("routine", function()
  os.execute(script_path)
end, 30)

-- Update on click
wifi:subscribe("mouse.clicked", function()
  if env.BUTTON == "right" then
    os.execute("open /System/Library/PreferencePanes/Network.prefPane")
  else
    os.execute(script_path)
  end
end)

-- Initial update
os.execute(script_path)

return wifi
