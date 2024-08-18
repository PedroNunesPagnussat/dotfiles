-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Navigation with line wrap considerations
map("n", "j", "gj", { desc = "Move down visual line" })
map("n", "k", "gk", { desc = "Move up visual line" })

-- Copy and Paste with Clipboard
map({ "n", "v" }, "x", '"_x', { desc = "Delete without adding to buffer" })
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
map("n", "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
map("n", "<leader>P", [["+P]], { desc = "Paste from system clipboard before cursor" })

-- File Operations
map("n", "<leader>yp", [[:let @+ = expand("%:p")<cr>]], { desc = "Copy file path to clipboard" })
map("n", "<leader>yf", "<cmd>%y+<cr>", { desc = "Copy entire file to clipboard" })

-- Exit Insert Mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- Symbol Matching
map({ "n", "v" }, "gm", "%", { desc = "Go to matching symbol" })

-- Command Mode and Yank Enhancements
map("n", ";", ":", { desc = "Enter command mode" })
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Undo with Ctrl+Z
map({ "n", "i" }, "<C-z>", "<cmd>undo<cr>", { desc = "Undo" })

-- Improved Indentation
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("i", "<S-tab>", "<C-d>", { desc = "Un-indent in insert mode" })
map("v", "<S-tab>", "<gv")

-- Open Current Directory in VSCode
map("n", "<leader>co", "<cmd>!code .<cr>", { desc = "Open in VSCode" })

-- Line Movement
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Window Navigation and Management
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

map("n", "<leader>w|", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>w-", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Make windows equal size" })
map("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current window" })

-- Tab Management
map("n", "<leader><tab>c", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<s-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>x", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Save File
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- New File
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Find and Replace
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Search and Clear Highlights
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear search highlight" })

-- Quit
map({ "v", "n" }, "<leader>wq", "<cmd>wq<cr>", { desc = "Save and quit" })
map({ "v", "n" }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all windows" })
map({ "v", "n" }, "<leader>qQ", "<cmd>qa!<cr>", { desc = "Quit all windows without saving" })

-- Cursor Positioning Enhancements
map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
map("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor centered on half-page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor centered on half-page up" })
map("n", "n", "nzzzv", { desc = "Keep cursor centered on search result" })
map("n", "N", "Nzzzv", { desc = "Keep cursor centered on previous search result" })
