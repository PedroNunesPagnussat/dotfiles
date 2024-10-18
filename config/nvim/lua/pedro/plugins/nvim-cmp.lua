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

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
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
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-l>"] = cmp.mapping.confirm({ select = true }),
        -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        --   ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --       cmp.select_next_item()
        --     elseif luasnip.expand_or_jumpable() then
        --       luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --       cmp.complete()
        --     else
        --       fallback()
        --     end
        --   end, { "i", "s" }),
        --
        --   ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --       cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --       luasnip.jump(-1)
        --     else
        --       fallback()
        --     end
        --   end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp", max_item_count = 5, keyword_length = 1 },
        { name = "buffer", max_item_count = 5 },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "luasnip", max_item_count = 3 },
        { name = "spell" }, -- Optional spell-checking source
      }),

      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

      -- experimental = {
      --   ghost_text = true,
      -- },

      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      performance = {
        debounce = 50,
        throttle = 100,
        fetching_timeout = 500,
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
