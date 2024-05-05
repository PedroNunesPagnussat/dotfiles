return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    local map = vim.keymap.set

    map(
      "v",
      "<C-_>",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      { desc = "Comment Toggle" }
    )

    map("n", "<C-_>", function()
      require("Comment.api").toggle.linewise.current()
    end, { desc = "Comment Toggle" })

    map(
      "v",
      "<C-/>",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      { desc = "Comment Toggle" }
    )

    map("n", "<C-/>", function()
      require("Comment.api").toggle.linewise.current()
    end, { desc = "Comment Toggle" })
  end,
}
