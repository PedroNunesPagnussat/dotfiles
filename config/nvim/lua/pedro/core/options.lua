-- Vim Options
local opt = vim.opt

-- Line Numbers
opt.number = true -- Show absolute line number
opt.relativenumber = true -- Show relative line numbers

-- Indentation
opt.tabstop = 2 -- Number of spaces a <Tab> counts for
opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Copy indent from current line when starting a new line
opt.shiftround = true -- Round indent to multiple of 'shiftwidth'

-- Search Settings
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override 'ignorecase' if search pattern contains uppercase characters
opt.hlsearch = true -- Highlight matches of previous search pattern

-- Mouse
opt.mouse = "a" -- Enable mouse support in all modes

-- Backspace
opt.backspace = "indent,eol,start" -- Make backspace behave in a more intuitive way

-- Line Wrapping
opt.wrap = false -- Disable line wrapping

-- Clipboard
-- opt.clipboard:append("unnamedplus") -- Use system clipboard as default register

-- Split Windows
opt.splitright = true -- Vertical splits will automatically be to the right
opt.splitbelow = true -- Horizontal splits will automatically be below

-- Undo
opt.undofile = true -- Save undo history to an undo file
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Set undo directory

-- Swap
opt.swapfile = false -- Disable swapfile creation

-- Buffers
opt.confirm = true -- Ask for confirmation when exiting an unsaved buffer

-- Appearance
opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
opt.background = "dark" -- Use dark background
opt.signcolumn = "yes" -- Always show the sign column to avoid text shifting
vim.g.have_nerd_font = true -- Flag indicating the presence of NerdFont

-- Scrolling
opt.scrolloff = 8 -- Minimum number of lines to keep above and below the cursor

-- Spelling
opt.spell = false -- Disable spell checking by default
opt.spelllang = { "en" } -- Set spell check language to English

-- Markdown
opt.conceallevel = 1 -- Enable concealment for Markdown

-- Cursor Line
opt.cursorline = true -- Highlight the current cursor line

-- File Explorer (Netrw)
vim.g.netrw_liststyle = 3 -- Use tree-style listing in Netrw

-- Mode Display
opt.showmode = false -- Don't show mode in the command line (assuming a statusline plugin shows it)

-- Inisible Characters
opt.list = true -- Show invisible characters
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Customize the display of invisible characters

-- Color Line
opt.colorcolumn = "89" -- Set Color line char
