return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = {
      char = "┊",
      tab_char = "┊",
      highlight = {
        "Normal", -- Typically black text on white background in most color schemes
        "NonText", -- Often used for non-visible characters, usually in white
      },
    },

    whitespace = {
      highlight = {
        "CursorColumn",
        "Whitespace",
      },
      remove_blankline_trail = false,
    },

    scope = {
      enabled = false,
      highlight = {
        "Normal", -- Black text on white background
        "NonText", -- White text
      },
    },

    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
}
