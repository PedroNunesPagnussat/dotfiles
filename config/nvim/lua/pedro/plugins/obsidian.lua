return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "second_brain",
        path = "~/vaults/second_brain",
      },
    },
  },

  keys = {
    { "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>", desc = "Change check box state" },
    { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert Template" },
    { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open note" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Open backlinks" },
    { "<leader>ol", "<cmd>ObsidianLink<CR>", desc = "Insert link" },
    { "<leader>oi", "<cmd>ObsidianInsert<CR>", desc = "Insert note" },
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "Create new note" },
    { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch" },
  },
}
