return {
  "echasnovski/mini.map",
  version = false,
  config = function()
    local minimap = require("mini.map")
    minimap.setup()

    vim.api.nvim_set_keymap(
      "n",
      "<Leader>mm",
      ':lua require("mini.map").toggle()<CR>',
      { noremap = true, silent = true, desc = "Toggle minimap" }
    )

    vim.api.nvim_set_keymap(
      "n",
      "<Leader>mr",
      ':lua require("mini.map").refresh()<CR>',
      { noremap = true, silent = true, desc = "Refresh minimap" }
    )
    -- minimap.toggle()
  end,

  -- keys = {
  --   {
  --     "<leader>mm",
  --     function()
  --       require("mini.map").toggle()
  --     end,
  --     desc = "Toggle minimap",
  --   },
  --   {
  --     "<leader>mr",
  --     function()
  --       require("mini.map").refresh()
  --     end,
  --     desc = "Refresh minimap",
  --   },
  -- },
}
