# Dotfiles

A collection of configuration files for various tools and applications, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
# Clone the repository
git clone <repository-url> ~/.dotfiles
cd ~/.dotfiles

# Install specific configurations
stow nvim
stow fish
stow git

# Install all configurations
stow */
```

## Available Configurations

- **aerospace** - Window manager configuration
- **atuin** - Shell history sync tool
- **borders** - Window border customization
- **btop** - System monitor
- **carapace** - Shell completion framework
- **fish** - Fish shell configuration
- **ghostty** - Terminal emulator
- **git** - Git configuration and aliases
- **github-copilot** - GitHub Copilot settings
- **kitty** - Terminal emulator configuration
- **lazygit** - Git TUI configuration
- **nushell** - Nushell configuration
- **nvim** - Neovim configuration
- **sketchybar** - macOS menu bar replacement
- **starship** - Cross-shell prompt
- **yazi** - File manager
- **zed** - Code editor configuration
- **zellij** - Terminal multiplexer

## Usage

### Installing Configurations

Use GNU Stow to symlink configurations to your home directory:

```bash
# Install a single configuration
stow <package-name>

# Example
stow nvim
```

### Removing Configurations

```bash
# Remove a configuration
stow -D <package-name>

# Example
stow -D nvim
```

### Updating Configurations

After making changes to any configuration:

```bash
# Re-stow to update symlinks
stow -R <package-name>
```

## Requirements

- [GNU Stow](https://www.gnu.org/software/stow/)
- macOS (some configurations are macOS-specific)

## Installation

```bash
# Install GNU Stow (macOS)
brew install stow

# Clone this repository
git clone <repository-url> ~/.dotfiles
cd ~/.dotfiles

# Install desired configurations
stow nvim fish git
```

## Directory Structure

Each directory contains configuration files that will be symlinked to the appropriate locations in your home directory when stowed.

## Additional Resources

- **docs/** - Documentation and cheat sheets
- **reference/** - Reference configurations and examples