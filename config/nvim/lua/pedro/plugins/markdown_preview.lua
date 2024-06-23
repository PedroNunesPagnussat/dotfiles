return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },

  -- Add keymaps
  config = function()
    local map = vim.keymap.set

    map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })
  end,
}
