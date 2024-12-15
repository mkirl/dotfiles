# Existing config...

# Set XDG path for Nushell
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"

# Starship configuration
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { || starship prompt }
$env.PROMPT_COMMAND_RIGHT = { || "" }

# If you want a right prompt, you can use this instead
# $env.PROMPT_COMMAND_RIGHT = { || starship prompt --right } 