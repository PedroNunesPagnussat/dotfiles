return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    plugins = { spelling = true },
    defaults = {},
    spec = {
      {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "Tabs" },
          { "<leader>c", group = "Code" },
          { "<leader>e", group = "File Explorer" },
          { "<leader>f", group = "Find", icon = { icon = "" } },
          { "<leader>l", group = "LSP" },
          { "<leader>m", group = "MiniMap" },
          { "<leader>o", group = "Obsidian", icon = { icon = "", color = "purple" } },
          { "<leader>q", group = "Quit" },
          { "<leader>r", group = "Replace" },
          { "<leader>s", group = "Sessions" },
          { "<leader>t", group = "Trouble" },
          { "<leader>v", group = "Venv" },
          { "<leader>w", group = "Windows" },
          { "<leader>u", group = "Notify", icon = { icon = "" } },
          { "<leader>y", group = "Yank Path/File", icon = { icon = "" } },
        },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
    {
      "<c-l><space>",
      function()
        require("which-key").show({ keys = "<c-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    -- wk.register(opts.defaults)
  end,
}
