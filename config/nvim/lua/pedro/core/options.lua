-- Vim Options
local opt = vim.opt

-- Line Numbers
opt.relativenumber = true -- Relative line numbers
opt.number = true -- Absolute line number

-- Identation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- Expand tab to spaces
opt.autoindent = true -- Copy indent from current line on new one
opt.shiftround = true -- Round indent

-- Search Settings
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Include mixed case in your search in case-sensitive search
opt.hlsearch = true -- Set highlight on search

-- Mouse
opt.mouse = "a" -- Allow Mouse

-- Backspace
opt.backspace = "indent,eol,start" -- Allow backspace on indent, end of line or insert mode start position

-- Line Wrapping
opt.wrap = false -- Disable line wrapping

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard as default register

-- Split Windows
opt.splitright = true -- Split vertical window to the right
opt.splitbelow = true -- Split horizontal window to the bottom

-- Undo
opt.undofile = true -- Save undo history

local undopath = os.getenv("HOME") .. "/.vim/undodir"
opt.undodir = undopath

-- Swap
opt.swapfile = false

-- Buffers
opt.confirm = true -- Confirm before exiting unsaved buffer

-- Appearance
opt.termguicolors = true -- Terminal colors
opt.background = "dark" -- Colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- Show sign column so that text doesn't shift
vim.g.have_nerd_font = true -- NerdFont flag

-- Scroll off
opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.

-- Spelling
opt.spell = false
opt.spelllang = { "en" }

--MD
opt.conceallevel = 1
-- Cursor Line
opt.cursorline = true -- Highlight the current cursor line

-- File explorer
vim.cmd("let g:netrw_liststyle = 3") -- Set File Explorer to work as a tree

-- Mode
opt.showmode = false -- Don't show the mode, since it's already in the status line

-- Inisable chars
opt.list = true -- Show invisable chars
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Change the icons

-- Color Line
opt.colorcolumn = "120" -- Set Color line char
