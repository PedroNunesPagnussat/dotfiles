return {

  "nvimdev/dashboard-nvim",
  event = "VimEnter",

  opts = function()
    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      modifiable = true,
      config = {

        header = {
          "                                                  ",
          "                                                  ",
          "                                                  ",
          "                                                  ",
          "                                                  ",
          "                                                  ",
          "                                                  ",
          "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
          "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
          "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
          "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
          "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
          "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
          "                                                  ",
          "             [ @PedroNunesPagnussat ]             ",
          "                                                  ",
          "                                                  ",
        },

        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                      desc = " Find File",       icon = "󰱼 ", key = "f" },
          { action = "SessionRestore",                            desc = " Restore Session", icon = " ", key = "r" },
          { action = "NvimTreeToggle",                            desc = " File Explorer",   icon = " ", key = "e" },
          { action = "ene | startinsert",                         desc = " New File",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                        desc = " Recent Files",    icon = " ", key = "s" },
          { action = "Telescope live_grep",                       desc = " Find Text",       icon = " ", key = "w" },
          { action = "Telescope find_files cwd=~/.config/nvim",   desc = " Config",          icon = " ", key = "c" },
          { action = "Lazy update",                               desc = " Update Plugins",  icon = "󰚰 ", key = "u" },
          { action = "Lazy",                                      desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                        desc = " Quit",            icon = " ", key = "q" },
        },

        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
