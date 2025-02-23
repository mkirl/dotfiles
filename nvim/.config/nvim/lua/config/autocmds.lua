-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Format Go files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
  end,
})

-- Set TypeScript and TSX indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.bo.tabstop = 2        -- Size of a hard tabstop
    vim.bo.shiftwidth = 2     -- Size of an indentation
    vim.bo.expandtab = true   -- Always uses spaces instead of tabs
    vim.bo.softtabstop = 2    -- Number of spaces a tab counts for
  end,
})
