return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    local web_icons = require("nvim-web-devicons")
    web_icons.setup({
      override = {
        toml = {
          icon = "",
          color = "#6d8086",
          name = "Toml",
        },
      },
      default = true,
    })
  end,
}
