-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- GIT GUD

-- Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Disable arrow keys in visual mode
map('v', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('v', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('v', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('v', '<down>', '<cmd>echo "Use j to move!!"<CR>')


-- Exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
map("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })


-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })


-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })


-- Buffers
--map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
--map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })


-- Tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })


-- Save File
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- TODO MAKE A WIRTE ALL


-- Better Indenting
map("v", "<", "<gv")
map("v", ">", ">gv")


-- Find Replace Word
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- Search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Clear search highlight" })


-- Cursor QoL
map("n", "J", "mzJ`z", { desc = "Keep Cursor Fixed on J" })
map("n", "<C-d>", "<C-d>zz", { desc = "Keep Cursor Fixed on PgUp" })
map("n", "<C-u>", "<C-u>zz", { desc = "Keep Cursor Fixed on PgDown" })
map("n", "n", "nzzzv", { desc = "Keep Cursor Fixed on Search" })
map("n", "N", "Nzzzv", { desc = "Keep Cursor Fixed on Search" })

-- New File
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
