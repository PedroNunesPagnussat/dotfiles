local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },

      window = {
        documentation = {
          border = border("CmpDocBorder"),
          winhighlight = "Normal:CmpDoc",
        },
        completion = {
          border = border("CmpCompletionBorder"),
          winhighlight = "Normal:CmpCompletion",
        },
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll docs up
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll docs down
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        -- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm selection
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp", max_item_count = 5, keyword_length = 1 },
        { name = "buffer", max_item_count = 5 },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "luasnip", max_item_count = 3 },
      }),

      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
