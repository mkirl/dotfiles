local colors = require("colors")
local settings = require("settings")

local volume = sbar.add("item", "volume", {
  position = "right",
  icon = {
    string = "󰕾",
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Regular"],
      size = 16.0,
    },
    padding_right = 8,
    color = colors.blue,
  },
  label = {
    string = "100%",
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 12.0,
    },
    color = colors.text,
    padding_right = 8,
  },
})

-- Create a shell script to handle volume updates
local volume_script = [[
#!/bin/bash

# Get volume information
VOLUME=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')

# Set the icon based on volume level and mute state
if [ "$MUTED" = "true" ]; then
  ICON="󰝟"
  VOLUME="Muted"
else
  if [ "$VOLUME" -eq 0 ]; then
    ICON="󰕿"
  elif [ "$VOLUME" -lt 30 ]; then
    ICON="󰖀"
  elif [ "$VOLUME" -lt 70 ]; then
    ICON="󰕾"
  else
    ICON="󰕾"
  fi
  VOLUME="${VOLUME}%"
fi

sketchybar --set volume icon="$ICON" label="$VOLUME"
]]

-- Write the script to a file
os.execute("mkdir -p " .. os.getenv("HOME") .. "/.config/sketchybar/plugins")
local script_path = os.getenv("HOME") .. "/.config/sketchybar/plugins/volume.sh"
local f = io.open(script_path, "w")
f:write(volume_script)
f:close()
os.execute("chmod +x " .. script_path)

-- Subscribe to volume change events
volume:subscribe("volume_change", function()
  os.execute(script_path)
end)

-- Update volume on mouse scroll
volume:subscribe("mouse.scrolled", function(env)
  local direction = env.SCROLL
  local command = direction == "up" and "up" or "down"
  os.execute("osascript -e 'set volume output volume (output volume of (get volume settings) - " .. (direction == "up" and "-5" or "5") .. ")'")
end)

-- Toggle mute on click
volume:subscribe("mouse.clicked", function()
  os.execute("osascript -e 'set volume output muted (not output muted of (get volume settings))'")
end)

-- Initial update
os.execute(script_path)

return volume

