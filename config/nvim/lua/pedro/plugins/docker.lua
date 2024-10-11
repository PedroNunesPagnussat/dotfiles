return {
  {
    "ekalinin/Dockerfile.vim",
    lazy = false,
    -- ft = "dockerfile",
    config = function()
      -- Any additional config if needed can go here
      vim.api.nvim_command("autocmd BufRead,BufNewFile Dockerfile set filetype=dockerfile")
    end,
  },
}
