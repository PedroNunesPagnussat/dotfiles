return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    anaconda_base_path = "~/miniconda",
    anaconda_envs_path = "~/miniconda/envs",
    -- auto_refresh = true,
  },
  event = "VeryLazy",
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Load Env" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Load recent Env" },
  },
}
