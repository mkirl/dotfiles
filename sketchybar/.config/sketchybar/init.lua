-- Require the sketchybar module
sbar = require("sketchybar")

-- Set environment variables
local env = {
  FONT = "SF Pro",
  PADDINGS = 3,
  SHADOW_COLOR = "0xff000000",
}

-- Bundle the entire initial configuration into a single message to sketchybar
sbar.begin_config()

-- Load core configurations
require("bar")
require("default")
require("items")

-- Set up aerospace integration
os.execute([[
  # Get initial aerospace workspace state
  AEROSPACE_FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
  sketchybar --trigger aerospace_workspace_change AEROSPACE_FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE
]])

sbar.end_config()

-- Run the event loop
sbar.event_loop()
