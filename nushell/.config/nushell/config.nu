# Set XDG path for Nushell
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"

# Starship configuration
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { || starship prompt }
$env.PROMPT_COMMAND_RIGHT = { || "" }