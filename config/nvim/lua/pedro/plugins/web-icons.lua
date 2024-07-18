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
        zip = {
          icon = "",
          color = "#f38ba8",
          name = "Zip",
        },
      },
      default = true,
    })
  end,
}
