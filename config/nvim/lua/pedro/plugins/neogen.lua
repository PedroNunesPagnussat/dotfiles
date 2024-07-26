return {
  "danymat/neogen",
  config = function()
    require("neogen").setup({
      enabled = true,
      snippet_engine = "luasnip",
      languages = {
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
      },
    })

    -- Key mapping to trigger neogen
    vim.api.nvim_set_keymap(
      "n",
      "<leader>cd",
      '<cmd>lua require("neogen").generate()<CR>',
      { noremap = true, silent = true, desc = "Generate annotations" }
    )

    -- Key mappings for snippet navigation
    vim.api.nvim_set_keymap(
      "i",
      "<C-j>",
      '<cmd>lua require("luasnip").jump(1)<CR>',
      { noremap = true, silent = true, desc = "Jump to next snippet placeholder" }
    )
    vim.api.nvim_set_keymap(
      "i",
      "<C-k>",
      '<cmd>lua require("luasnip").jump(-1)<CR>',
      { noremap = true, silent = true, desc = "Jump to previous snippet placeholder" }
    )
    vim.api.nvim_set_keymap(
      "s",
      "<C-j>",
      '<cmd>lua require("luasnip").jump(1)<CR>',
      { noremap = true, silent = true, desc = "Jump to next snippet placeholder" }
    )
    vim.api.nvim_set_keymap(
      "s",
      "<C-k>",
      '<cmd>lua require("luasnip").jump(-1)<CR>',
      { noremap = true, silent = true, desc = "Jump to previous snippet placeholder" }
    )
  end,
}
