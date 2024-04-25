vim.g.mapleader = " "

local map = vim.keymap.set

-- Exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
map("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })



