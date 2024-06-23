return {
  "rmagatti/goto-preview",
  config = function()
    require("goto-preview").setup({
      width = 150, -- Width of the floating window
      height = 30, -- Height of the floating window
      default_mappings = true, -- Bind default mappings
    })

    -- Add keymps
    local map = vim.keymap.set
    map("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = "Preview definition" })
    map("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", { desc = "Preview definition" })
  end,
}
