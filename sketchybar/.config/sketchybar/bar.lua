local colors = require("colors")

-- Unload the macOS on screen indicator overlay for volume change
os.execute([[
  launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist > /dev/null 2>&1 &
]])

-- Configure the bar
sbar.bar({
  height = 45,
  color = colors.bar.bg,
  border_width = 2,
  border_color = colors.bar.border,
  shadow = false,
  position = "top",
  sticky = true,
  padding_right = 10,
  padding_left = 10,
  y_offset = -5,
  margin = -2,
  topmost = "window",
  blur_radius = 20,
})
