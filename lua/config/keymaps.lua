-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>W", "<cmd>w<cr>", { desc = "Save file" })
vim.api.nvim_create_user_command('W', 'w', { nargs = 0 })
vim.api.nvim_create_user_command('Q', 'q', { nargs = 0 })
