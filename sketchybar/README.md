# SketchyBar Configuration with Aerospace Integration

This SketchyBar configuration is designed to work seamlessly with the Aerospace window manager.

## Features

### 🚀 Aerospace Integration
- **Workspace Indicators**: Shows workspaces 1-10 with visual feedback
- **Real-time Updates**: Listens to Aerospace events for instant updates
- **Smart Visual States**:
  - Focused workspace: Blue highlight
  - Workspaces with windows: Semi-transparent background
  - Empty workspaces: Dim icons

### 📊 System Monitoring
- **Clock**: Updates every 10 seconds with date and time
- **Volume**: Real-time volume indicator with appropriate icons
- **Battery**: Shows battery percentage with charging status
- **Front App**: Displays currently focused application

### 🎨 Visual Design
- Semi-transparent bar with blur effects
- Modern SF Pro font
- Nerd Font icons for visual consistency
- Catppuccin-inspired color palette

## Installation

Since this is managed by Stow, simply run:

```bash
cd ~/dotfiles
stow sketchybar
brew services restart sketchybar
```

## File Structure

```
.config/sketchybar/
├── sketchybarrc          # Main configuration
├── colors.sh             # Color definitions
├── plugins/
│   ├── aerospace.sh      # Aerospace workspace handler
│   ├── aerospace_listener.sh  # Background event listener
│   ├── front_app.sh      # Front application display
│   ├── clock.sh          # Date/time display
│   ├── volume.sh         # Volume indicator
│   └── battery.sh        # Battery status
└── helpers/
    └── default.sh        # Default item settings
```

## Aerospace Commands

The configuration uses these Aerospace commands:
- `aerospace workspace X` - Switch to workspace X (click action)
- `aerospace list-workspaces --focused` - Get current workspace
- `aerospace list-windows --workspace X` - Check workspace content
- `aerospace listen` - Event monitoring for real-time updates

## Customization

### Colors
Edit `colors.sh` to change the color scheme. The current palette is Catppuccin-inspired.

### Workspaces
Modify the `WORKSPACES` array in `sketchybarrc` to change the number of workspaces.

### Fonts
Update font settings in the `--default` section of `sketchybarrc`.

## Requirements

- SketchyBar: `brew install FelixKratz/formulae/sketchybar`
- Aerospace: Configured and running
- Nerd Fonts: For proper icon display

## Troubleshooting

If workspaces don't update:
1. Ensure Aerospace is running
2. Check that the event listeners are active
3. Restart SketchyBar: `brew services restart sketchybar`

If icons don't display properly:
1. Install SF Pro font (system default on macOS)
2. Install a Nerd Font for additional icons
