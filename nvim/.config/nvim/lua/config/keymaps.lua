-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

-- Use C-/ (represented as C-_) for commenting instead of terminal
-- Delete the default terminal binding
vim.keymap.del("n", "<c-/>", { silent = true })
vim.keymap.del("t", "<c-/>", { silent = true })

-- Set C-/ for commenting (works with mini.comment or Comment.nvim)
set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment line" })
set("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })
