# ~/.config/fish/config.fish

# Abbreviations
abbr --add -- ff fastfetch

# Aliases
alias vim nvim
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
alias goland="open -a GoLand"
alias cursor="open -a Cursor"
alias idea="open -a 'IntelliJ IDEA'"

# Set environment variables
set -x PATH /opt/homebrew/bin $PATH
set -x PATH /Applications/Cursor.app/Contents/MacOS $PATH
set -x PATH $HOME/.pnpm-packages/bin $HOME/.pnpm-packages $PATH
set -x PATH $HOME/.npm-packages/bin $HOME/bin $PATH
set -x PATH $HOME/.local/share/bin $PATH
set -x PATH $HOME/go/bin $PATH

# Set editor variable
set -x EDITOR nvim

#Zig 0.14
set -gx PATH /Users/mike/Prodev/zig-macos-aarch64-0.14.0-dev.2546+0ff0bdb4a $PATH

# Remove history data we don't want to see
set -x HISTIGNORE "pwd:ls:cd"

# Initialize zoxide (better cd)
zoxide init fish | source
atuin init fish | source
starship init fish | source

# Run fastfetch if we're in kitty and it's an interactive shell
if status is-interactive && test "$TERM" = xterm-kitty
    fastfetch
end

# Kitty shell integration
if set -q KITTY_INSTALLATION_DIR
    set --global KITTY_SHELL_INTEGRATION no-rc
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end
