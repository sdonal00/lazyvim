-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>W", "<cmd>w<cr>", { desc = "Save file" })
vim.api.nvim_create_user_command('W', 'w', { nargs = 0 })
vim.api.nvim_create_user_command('Q', 'q', { nargs = 0 })

vim.keymap.set("v", "<C-j>", ":move '>+1<CR>gv=gv", { desc = "Move lines down" })
vim.keymap.set("v", "<C-k>", ":move '<-2<CR>gv=gv", { desc = "Move lines up" })

vim.keymap.set("n", "<C-j>", ":move .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":move .-2<CR>==", { desc = "Move line up" })
