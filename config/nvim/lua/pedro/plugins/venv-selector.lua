-- return {
--   "linux-cultist/venv-selector.nvim",
--   dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
--   branch = "regexp",
--   stay_on_this_version = true,
--   opts = {
--     anaconda_base_path = "~/miniconda",
--     anaconda_envs_path = "~/miniconda/envs",
--     -- auto_refresh = true,
--   },
--   config = function()
--     require("venv-selector").setup()
--   end,
--   event = "VeryLazy",
--   keys = {
--     { "<leader>v", "<cmd>VenvSelect<cr>", desc = "Load Env" },
--   },
-- }

return {}
