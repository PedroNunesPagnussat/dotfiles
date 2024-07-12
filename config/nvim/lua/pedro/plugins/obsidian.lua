return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre",
  --   "BufNewFile",
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
    mappings = {
      ["gd"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },
  },
  vim.api.nvim_set_keymap(
    "n",
    "<leader>oc",
    "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
    { noremap = true, silent = true }
  ),

  vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { noremap = true, silent = true }),
  vim.keymap.set("v", "<leader>ol", "<cmd>ObsidianLink<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianSearch<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>fo", "<cmd>ObsidianQuickSwitch<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { noremap = true, silent = true }),
}
