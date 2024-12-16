# ~/.config/fish/config.fish

# Abbreviations
abbr --add -- ff fastfetch
abbr --add -- nb '/run/current-system/sw/bin/darwin-rebuild build --flake .#aarch64-darwin'
abbr --add -- nbs '/run/current-system/sw/bin/darwin-rebuild switch --flake .#aarch64-darwin'

# Aliases
alias cat bat
alias cd z
alias diff difft
alias la 'eza -la --icons=always'
alias ll 'eza -l --icons=always'
alias ls 'eza --icons=always'
alias pn pnpm
alias px pnpx
alias search 'rg -p --glob \'!node_modules/*\''
alias tree 'eza --tree --icons=always'

# Set environment variables
set -x PATH $HOME/.pnpm-packages/bin $HOME/.pnpm-packages $PATH
set -x PATH $HOME/.npm-packages/bin $HOME/bin $PATH
set -x PATH $HOME/.local/share/bin $PATH

# Remove history data we don't want to see
set -x HISTIGNORE "pwd:ls:cd"

# Initialize zoxide (better cd)
zoxide init fish | source
atuin init fish | source
starship init fish | source

# Run fastfetch if we're in kitty
if test "$TERM" = xterm-kitty
    fastfetch
end

# Kitty shell integration
if set -q KITTY_INSTALLATION_DIR
    set --global KITTY_SHELL_INTEGRATION no-rc
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end
