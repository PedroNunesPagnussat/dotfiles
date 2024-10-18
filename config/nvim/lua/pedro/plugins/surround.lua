return {
  "echasnovski/mini.surround",
  version = "*", -- You can specify the version or use the latest one.
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mini.surround").setup({
      -- You can customize the setup here, or leave it as default
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        replace = "sc", -- Replace surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surroundina
      },
    })
  end,
}
