-- Install kickstart
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key to space (must be before plugins)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Install plugins
require("lazy").setup({
  {
    "folke/lazy.nvim",
    version = "*"
  },
  {
    "nvim-lua/plenary.nvim",
    name = "plenary"
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    }
  },
  -- Add telescope for fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- Add some colorscheme
  { 'folke/tokyonight.nvim' },
  -- Add which-key for better key binding hints
  { 'folke/which-key.nvim', opts = {} },
  -- Add nvim-tree for file explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- disable netrw at the very start
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })

      -- create a keymap
      vim.keymap.set(
        "n",
        "<leader>e",
        "<cmd>NvimTreeToggle<CR>",
        { noremap = true, silent = true, desc = "Toggle file explorer" }
      )
    end,
  },
  -- Add snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { 
      sections = {
          { section = "header" },
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "hub status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      scope = { enabled = true },
      styles = {
        notification = {}
      }
    },
    keys = {
      { "<leader>z",  function() require('snacks').zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() require('snacks').zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() require('snacks').scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() require('snacks').scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() require('snacks').notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() require('snacks').bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() require('snacks').rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() require('snacks').gitbrowse() end, desc = "Git Browse" },
      { "<leader>gb", function() require('snacks').git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gf", function() require('snacks').lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>gg", function() require('snacks').lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() require('snacks').lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() require('snacks').notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>",      function() require('snacks').terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() require('snacks').terminal() end, desc = "which_key_ignore" },
      { "]]",         function() require('snacks').words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() require('snacks').words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          require('snacks').win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            require('snacks').debug.inspect(...)
          end
          _G.bt = function()
            require('snacks').debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          local snacks = require('snacks')
          snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          snacks.toggle.diagnostics():map("<leader>ud")
          snacks.toggle.line_number():map("<leader>ul")
          snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          snacks.toggle.treesitter():map("<leader>uT")
          snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          snacks.toggle.inlay_hints():map("<leader>uh")
          snacks.toggle.indent():map("<leader>ug")
          snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  }
})

-- Set colorscheme
vim.cmd[[colorscheme tokyonight]]

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.o.shell = "fish"

-- Initialize LSP
local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()

-- LSP Keybindings Documentation:
-- Navigation:
--   gd - Go to definition
--   gD - Go to declaration
--   gr - Find references
--   gi - Go to implementation
--
-- Documentation:
--   K  - Show hover documentation
--   <C-k> - Show signature help
--
-- Code Actions:
--   <leader>rn - Rename symbol
--   <leader>ca - Code actions
--   <leader>f  - Format code
--   <leader>D  - Type definition
--
-- Workspace:
--   <leader>wa - Add workspace folder
--   <leader>wr - Remove workspace folder
--   <leader>wl - List workspace folders
--
-- For more information:
--   :help lsp
--   :help vim.lsp.buf
lsp_zero.on_attach(function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end)

-- Configure language servers
require('lspconfig').lua_ls.setup({})
require('lspconfig').ts_ls.setup({})  -- Use ts_ls for TypeScript
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Format on save
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- Configure nvim-cmp
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  })
})

-- Configure treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { 
    "lua",
    "vim",
    "vimdoc",
    "javascript",
    "typescript",
    "rust",
    "python",
    "nix"
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- After the telescope plugin installation, add these keymaps:
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find help" })
