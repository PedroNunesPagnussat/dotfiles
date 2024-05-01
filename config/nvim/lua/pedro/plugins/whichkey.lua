return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["<leader><tab>"] = { name = "+Tabs" },
      ["<leader>f"] = { name = "+Find" },
      ["<leader>w"] = { name = "+Windows" },
      ["<leader>q"] = { name = "+Quit" },
      ["<leader>e"] = { name = "+File Explorer" },
      ["<leader>s"] = { name = "+Sessions" },
      ["<leader>v"] = { name = "+Venv" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}

