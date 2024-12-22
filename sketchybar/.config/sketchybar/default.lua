local settings = require("settings")
local colors = require("colors")

-- Configure default settings for all items
sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 14.0
    },
    color = colors.icon,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
    background = { 
      height = 26,
      corner_radius = 9,
      border_width = 2,
      border_color = colors.item.border,
      color = colors.item.bg,
    },
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Semibold"],
      size = 13.0
    },
    color = colors.text,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
    shadow = {
      drawing = true,
      distance = 2,
      color = colors.black,
    },
  },
  background = {
    height = 28,
    corner_radius = 9,
    border_width = 2,
    border_color = colors.item.border,
    color = colors.item.bg,
  },
  popup = {
    background = {
      border_width = 2,
      corner_radius = 9,
      border_color = colors.popup.border,
      color = colors.popup.bg,
      shadow = { 
        drawing = true,
        distance = 2,
        color = colors.black,
      },
    },
    blur_radius = 20,
  },
  padding_left = settings.paddings,
  padding_right = settings.paddings,
  scroll_texts = true,
})
