-- Catppuccin
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },

      transparent_background = false, -- disables setting the background color.
    })

    vim.cmd.colorscheme("catppuccin")
    vim.cmd("highlight ColorColumn ctermbg=235 guibg=#eba0ac") -- Set color line color
    -- vim.cmd("highlight ColorColumn ctermbg=235 guibg=#d20f39") -- Set to be really red
  end,
}

-- Gruvbox

-- return {
--   {
--     "ellisonleao/gruvbox.nvim",
--     priority = 1000,
--     config = function()
--       require("gruvbox").setup({
--         invert_selection = true,
--         invert_signs = true,
--         invert_tabline = true,
--         invert_intend_guides = true,
--         inverse = true,
--         contrast = "",
--         dim_inactive = true, -- Ok
--         transparent_mode = false, -- Ok
--       })
--       vim.o.background = "dark"
--       vim.cmd("colorscheme gruvbox")
--     end,
--   },
-- }
