return {
  "folke/flash.nvim",
  -- event = "BufReadPre",
  lazy = false,
  opts = {
    modes = {
      search = {
        -- enabled = true, -- Enable search mode by default
      },
      char = {
        -- enabled = true, -- Enable character motions by default
        -- jump_labels = true, -- Use jump labels for f, F, t, T motions
      },
    },
  },

  keys = {
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    -- {
    --   "f",
    --   mode = { "n", "x", "o" },
    --   function()
    --     require("flash").jump({
    --       mode = "char",
    --       search = {
    --         mode = "exact",
    --       },
    --     })
    --   end,
    --   desc = "Flash Forward",
    -- },
    -- {
    --   "F",
    --   mode = { "n", "x", "o" },
    --   function()
    --     require("flash").jump({
    --       mode = "char",
    --       search = {
    --         mode = "exact",
    --         forward = false,
    --       },
    --     })
    --   end,
    --   desc = "Flash Backward",
    -- },
    -- {
    --   "t",
    --   mode = { "n", "x", "o" },
    --   function()
    --     require("flash").jump({
    --       mode = "char",
    --       search = {
    --         mode = "exact",
    --         offset = -1,
    --       },
    --     })
    --   end,
    --   desc = "Flash Till",
    -- },
    -- {
    --   "T",
    --   mode = { "n", "x", "o" },
    --   function()
    --     require("flash").jump({
    --       mode = "char",
    --       search = {
    --         mode = "exact",
    --         forward = false,
    --         offset = -1,
    --       },
    --     })
    --   end,
    --   desc = "Flash Till Backward",
    -- },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
