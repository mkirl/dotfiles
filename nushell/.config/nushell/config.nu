# Set XDG path for Nushell
$env.XDG_CONFIG_HOME = $"($nu.home-path)/.config"

# Starship configuration
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { || starship prompt }
$env.PROMPT_COMMAND_RIGHT = { || "" }

# Carapace completion
use carapace
carapace connect nushell
