-- Vim Options 
local opt = vim.opt    


-- Line Numbers 
opt.relativenumber = true             -- Relative line numbers
opt.number = true 	                  -- Absolute line number

  
-- Identation
opt.tabstop = 2                       -- 2 spaces for tabs
opt.shiftwidth = 2                    -- 2 spaces for indent width
opt.expandtab = true                  -- Expand tab to spaces
opt.autoindent = true                 -- Copy indent from current line on new one
opt.shiftround = true                 -- Round indent


-- Search Settings
opt.ignorecase = true                 -- Ignore case when searching
opt.smartcase = true                  -- Include mixed case in your search in case-sensitive search


-- Cursor Line
opt.cursorline = true                 -- Highlight the current cursor line


-- Backspace
opt.backspace = "indent,eol,start"    -- Allow backspace on indent, end of line or insert mode start position


-- Clipboard
opt.clipboard:append("unnamedplus")   -- Use system clipboard as default register

-- Split Windows
opt.splitright = true                 -- Split vertical window to the right
opt.splitbelow = true                 -- Split horizontal window to the bottom


-- Appearance
opt.termguicolors = true              -- Terminal colors
opt.background = "dark"               -- Colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"                -- Show sign column so that text doesn't shift


-- File explorer
vim.cmd("let g:netrw_liststyle = 3")  -- Set File Explorer to work as a tree


-- Color Line
opt.colorcolumn = "120"               -- Set Color line char
vim.cmd('highlight ColorColumn ctermbg=235 guibg=#d20f39') -- Set color line color


-- line wrapping
--opt.wrap = false -- disable line wrapping
