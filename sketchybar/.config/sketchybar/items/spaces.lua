local colors = require("colors")
local settings = require("settings")

-- Define the workspaces that are assigned in aerospace.toml
local assigned_workspaces = {1, 2, 3, 4, 5, 6, "T"}

local spaces = {}
local space_bracket = sbar.add("bracket", "spaces", {
  background = {
    height = 26,
    color = colors.transparent,
    border_color = colors.workspace.normal.border,
  }
})

for _, i in ipairs(assigned_workspaces) do
  local space = sbar.add("space", "space." .. i, {
    space = i,
    icon = {
      string = tostring(i),
      padding_left = 8,
      padding_right = 8,
      color = colors.text,
      highlight_color = colors.red,
      font = {
        family = settings.font.numbers,
        style = settings.font.style_map["Bold"],
        size = 14.0,
      },
    },
    label = {
      padding_right = 20,
      color = colors.dim,
      highlight_color = colors.text,
      font = {
        family = settings.font.text,
        style = settings.font.style_map["Regular"],
        size = 13.0,
      },
      y_offset = -1,
    },
    background = {
      height = 26,
      color = colors.workspace.normal.bg,
      border_width = 2,
      border_color = colors.workspace.normal.border,
      corner_radius = 6,
    },
  })

  -- Subscribe to aerospace workspace change events
  space:subscribe("aerospace_workspace_change", function(env)
    local focused_workspace = env.AEROSPACE_FOCUSED_WORKSPACE
    local selected = (tostring(i) == focused_workspace)
    
    space:set({
      icon = { highlight = selected },
      label = { highlight = selected },
      background = { 
        color = selected and colors.workspace.focused.bg or colors.workspace.normal.bg,
        border_color = selected and colors.workspace.focused.border or colors.workspace.normal.border,
      }
    })
  end)

  -- Handle mouse clicks
  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "right" then
      -- Right click functionality can be added here
    else
      -- Left click switches to the workspace
      sbar.exec("aerospace workspace " .. i)
    end
  end)

  spaces[i] = space
end

-- Add spaces to the bracket
space_bracket:set({ items = vim.tbl_keys(spaces) })

-- Create a window observer to update workspace labels
local space_window_observer = sbar.add("item", {
  position = "right",
  drawing = false,
  update_freq = 2,
})

space_window_observer:subscribe("routine", function(env)
  -- Update workspace window counts and labels
  local result = sbar.exec("aerospace list-windows")
  -- Process window information and update space labels
  -- This can be customized based on your needs
end)
