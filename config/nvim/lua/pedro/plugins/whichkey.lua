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
--      ["g"] = { name = "+goto" },
--      ["gs"] = { name = "+surround" },
--      ["z"] = { name = "+fold" },
--      ["]"] = { name = "+next" },
--      ["["] = { name = "+prev" },
      ["<leader><tab>"] = { name = "+Tabs" },
--      ["<leader>b"] = { name = "+buffer" },
--      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "Find" },
--      ["<leader>g"] = { name = "+git" },
--      ["<leader>gh"] = { name = "+hunks" },
--      ["<leader>q"] = { name = "+quit/session" },
--      ["<leader>s"] = { name = "+search" },
--      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+Windows" },
      ["<leader>q"] = { name = "+Quit" },
      ["<leader>e"] = { name = "+File Explorer" },
--      ["<leader>x"] = { name = "+diagnostics/quickfix" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}

