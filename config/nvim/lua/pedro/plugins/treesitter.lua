return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "p00f/nvim-ts-rainbow",
  },
  config = function()
    local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      vim.notify("nvim-treesitter not found!")
      return
    end

    treesitter.setup({
      -- Enable syntax highlighting
      highlight = {
        enable = true,
        use_languagetree = true,
      },

      -- Enable indentation based on treesitter
      indent = { enable = true },

      -- Enable autotagging for HTML and XML
      autotag = {
        enable = true,
      },

      -- Enable rainbow parentheses
      -- rainbow = {
      --   enable = true,
      --   extended_mode = true, -- Highlight also non-bracket delimiters
      --   max_file_lines = nil, -- No line limit for rainbow highlight
      -- },

      -- Ensure these language parsers are installed
      ensure_installed = {
        "bash",
        "c",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "ninja",
        "python",
        "query",
        "regex",
        "rst",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "xml",
      },

      -- Enable incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
