# Vim/Neovim Keybinding Cheat Sheet

## Basic Navigation
- `h` `j` `k` `l` - Left, Down, Up, Right
- `w` - Jump to start of next word
- `b` - Jump to start of previous word
- `e` - Jump to end of word
- `0` - Start of line
- `$` - End of line
- `gg` - Go to first line of document
- `G` - Go to last line of document
- `{` - Jump to previous paragraph
- `}` - Jump to next paragraph
- `Ctrl-u` - Page up
- `Ctrl-d` - Page down
- `%` - Jump to matching brace/bracket

## Editing
- `i` - Insert before cursor
- `a` - Insert after cursor
- `I` - Insert at beginning of line
- `A` - Insert at end of line
- `o` - Insert new line below
- `O` - Insert new line above
- `x` - Delete character under cursor
- `dd` - Delete line
- `yy` - Copy line
- `p` - Paste after cursor
- `P` - Paste before cursor
- `u` - Undo
- `Ctrl-r` - Redo

## Visual Mode
- `v` - Enter visual mode
- `V` - Enter visual line mode
- `Ctrl-v` - Enter visual block mode
- `>` - Indent selection
- `<` - Unindent selection
- `y` - Copy selection
- `d` - Delete selection

## Search and Replace
- `/pattern` - Search forward
- `?pattern` - Search backward
- `n` - Next search result
- `N` - Previous search result
- `*` - Search for word under cursor
- `:%s/old/new/g` - Replace all occurrences
- `:s/old/new/g` - Replace in current line

## Multiple Files
- `:e filename` - Edit a file
- `:bn` - Next buffer
- `:bp` - Previous buffer
- `:bd` - Delete buffer
- `:sp` - Split horizontally
- `:vsp` - Split vertically
- `Ctrl-w h/j/k/l` - Navigate splits

## LazyVim Specific
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>e` - Toggle file explorer
- `<leader>gg` - Open Lazygit
- `gc` - Comment/uncomment
- `<leader>cd` - Line diagnostics
- `gd` - Go to definition
- `K` - Show documentation
- `<leader>ca` - Code actions

## Text Objects
- `iw` - Inner word
- `aw` - A word (includes space)
- `i"` - Inside quotes
- `a"` - Around quotes
- `ip` - Inner paragraph
- `ap` - A paragraph
- `i{` - Inside curly braces
- `a{` - Around curly braces

## Marks and Jumps
- `m{a-z}` - Set mark
- `'{a-z}` - Jump to mark
- `Ctrl-o` - Jump to previous location
- `Ctrl-i` - Jump to next location

## Tips
- Most commands can be combined with numbers (e.g., `5j` moves down 5 lines)
- Commands follow the pattern: `[number][command][text object or motion]`
- `ci"` = Change inside quotes
- `da{` = Delete around curly braces
- `yt,` = Yank until comma

## Common Command Mode Commands
- `:w` - Save
- `:q` - Quit
- `:wq` or `:x` - Save and quit
- `:q!` - Quit without saving
- `:help keyword` - Get help

Note: The leader key in LazyVim is typically set to space. 