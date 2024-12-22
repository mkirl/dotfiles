local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}
-- Define the workspaces that are assigned in aerospace.toml
local assigned_workspaces = {1, 2, 3, 4, 5, 6, 7, 10}

for _, i in ipairs(assigned_workspaces) do
  local space = sbar.add("space", "space." .. i, {
    space = i,
    icon = {
      font = { family = settings.font.numbers },
      string = i,
      padding_left = 15,
      padding_right = 8,
      color = colors.white,
      highlight_color = colors.red,
    },
    label = {
      padding_right = 20,
      color = colors.grey,
      highlight_color = colors.white,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.bg1,
      border_width = 1,
      height = 26,
      border_color = colors.black,
      corner_radius = 6,
      drawing = true,
    },
    popup = { background = { border_width = 5, border_color = colors.black } }
  })

  spaces[i] = space

  -- Create a bracket for each workspace
  local space_bracket = sbar.add("bracket", { space.name }, {
    background = {
      color = colors.transparent,
      border_color = colors.bg2,
      height = 28,
      border_width = 2,
      corner_radius = 8,
    }
  })

  -- Add separator between workspaces
  if i ~= assigned_workspaces[#assigned_workspaces] then
    sbar.add("item", "separator." .. i, {
      padding_left = 10,
      padding_right = 10,
      label = {
        string = "•",
        font = "sketchybar-app-font:Regular:12.0",
        color = colors.grey,
      },
      background = {
        drawing = false,
      }
    })
  end

  -- Subscribe to AeroSpace workspace change events
  space:subscribe("aerospace_workspace_change", function(env)
    sbar.exec("echo 'Workspace event: " .. i .. ", AEROSPACE_FOCUSED_WORKSPACE=" .. tostring(env.AEROSPACE_FOCUSED_WORKSPACE) .. "' >> /tmp/sketchybar_debug.log")
    
    local focused_workspace = tonumber(env.AEROSPACE_FOCUSED_WORKSPACE)
    local selected = (i == focused_workspace)
    
    space:set({
      icon = { highlight = selected },
      label = { highlight = selected },
      background = { 
        drawing = true,
        color = selected and colors.bg2 or colors.bg1,
        border_color = selected and colors.black or colors.bg2 
      }
    })
    
    space_bracket:set({
      background = { border_color = selected and colors.grey or colors.bg2 }
    })
  end)

  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "right" then
      -- Do nothing for right click
    else
      sbar.exec("aerospace workspace " .. i)
    end
  end)
end

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

-- Update window icons in workspace
space_window_observer:subscribe("space_windows_change", function(env)
  -- Get the current workspace number
  local current_workspace = tonumber(sbar.exec("aerospace list-workspaces --focused"))
  if not current_workspace then return end
  
  -- Get windows in current workspace
  local windows_output = sbar.exec("aerospace list-windows --workspace " .. current_workspace)
  local icon_line = ""
  local no_app = true
  
  -- Parse windows output and create icon line
  for window in windows_output:gmatch("[^\n]+") do
    no_app = false
    local app = window:match("|([^|]+)|")
    if app then
      app = app:match("^%s*(.-)%s*$") -- trim whitespace
      local lookup = app_icons[app]
      local icon = ((lookup == nil) and app_icons["Default"] or lookup)
      icon_line = icon_line .. icon
    end
  end

  if (no_app) then
    icon_line = " —"
  end
  
  if spaces[current_workspace] then
    sbar.animate("tanh", 10, function()
      spaces[current_workspace]:set({ label = icon_line })
    end)
  end
end)

-- Rest of the spaces indicator code remains the same
local spaces_indicator = sbar.add("item", {
  padding_left = -3,
  padding_right = 0,
  icon = {
    padding_left = 8,
    padding_right = 9,
    color = colors.grey,
    string = icons.switch.on,
  },
  label = {
    width = 0,
    padding_left = 0,
    padding_right = 8,
    string = "Spaces",
    color = colors.bg1,
  },
  background = {
    color = colors.with_alpha(colors.grey, 0.0),
    border_color = colors.with_alpha(colors.bg1, 0.0),
  }
})

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = spaces_indicator:query().icon.value == icons.switch.on
  spaces_indicator:set({
    icon = currently_on and icons.switch.off or icons.switch.on
  })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 1.0 },
        border_color = { alpha = 1.0 },
      },
      icon = { color = colors.bg1 },
      label = { width = "dynamic" }
    })
  end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 0.0 },
        border_color = { alpha = 0.0 },
      },
      icon = { color = colors.grey },
      label = { width = 0, }
    })
  end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)
