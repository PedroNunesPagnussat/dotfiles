return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = true,
  keymaps = {
    insert = "<C-g>s",
    insert_line = "<C-g>S",
    normal = "<leader>s",
    normal_cur = "yss",
    visual = "S",
    delete = "ds",
    change = "cs",
    change_line = "cS",
  },
}
