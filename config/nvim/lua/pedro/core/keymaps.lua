-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Dont add C and D to buffer
map("n", "d", '"_d', { desc = "Don't add d delition to buffer" })
map("n", "c", '"_c', { desc = "Don't add c delition to buffer" })

-- Fix line wrap jk
map("n", "j", "gj", { desc = "Move down visual line" })
map("n", "k", "gk", { desc = "Move up visual line" })

-- Copy Buffer
map({ "n", "v" }, "x", '"_x', { desc = "Don't add x delition to buffer" })
map("x", "<leader>p", [["_dP]], { desc = "Don't copy to buffer when pasting" })
-- map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to Sistem Clipboard" })
-- map("n", "<leader>Y", [["+Y]], { desc = "Copy to Sistem Clipboard" })

-- File Operations
map({ "n", "v" }, "<leader>yp", [[:let @+ = expand("%:p")<cr>]], { desc = "Copy file path to clipboard" })
map({ "n", "v" }, "<leader>yf", "<cmd>%y+<cr>", { desc = "Copy whole file to clipboard" })

-- Exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- Add ; as :
map("n", ";", ":", { desc = "Enter command mode" })

-- Add Y as y$
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Map CTRL Z to undo
map("n", "<C-z>", "<cmd>undo<cr>", { desc = "Undo" })
map("i", "<C-z>", "<cmd>undo<cr>", { desc = "Undo" })

-- Better Indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<S-tab>", "<gv")
map("v", "<tab>", ">gv")
map("i", "<S-tab>", "<C-d>")

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("n", "<A-down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "move down" })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "move up" })
map("v", "<A-down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("v", "<A-up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<leader>w|", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>w-", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Make windows equal size" })
map("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current window" })

-- Tabs
map("n", "<leader><tab>c", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>x", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<s-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Save File
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- TODO MAKE A WIRTE ALL

-- New File
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Find Replace Word
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word" })

-- Incremet / Decrement Number
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })

-- Quit
map({ "v", "n" }, "<leader>wq", "<cmd>wq<cr>", { desc = "Wirte and quit" })
map({ "v", "n" }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all windows" })
map({ "v", "n" }, "<leader>qQ", "<cmd>qa!<cr>", { desc = "Quit all windows" })

-- Cursor QoL
map("n", "J", "mzJ`z", { desc = "Keep Cursor Fixed on J" })
map("n", "<C-d>", "<C-d>zz", { desc = "Keep Cursor Fixed on PgUp" })
map("n", "<C-u>", "<C-u>zz", { desc = "Keep Cursor Fixed on PgDown" })
map("n", "n", "nzzzv", { desc = "Keep Cursor Fixed on Search" })
map("n", "N", "Nzzzv", { desc = "Keep Cursor Fixed on Search" })
