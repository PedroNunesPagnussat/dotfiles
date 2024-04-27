-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Close Toggle File explorer on exit
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "NvimTree_*",
  command = "close",
})

