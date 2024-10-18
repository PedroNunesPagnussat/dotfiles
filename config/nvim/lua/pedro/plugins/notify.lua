return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss All Notifications",
    },
  },
  opts = {
    -- Static notifications for now; change to "fade_in_slide_out" or "fade" for smoother animation.
    stages = "fade_in_slide_out",

    -- Timeout controls how long notifications are displayed (in milliseconds).
    timeout = 2000, -- Increased to 3000ms for better readability

    -- Set the maximum height of the notification window
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,

    -- Set the maximum width of the notification window
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,

    -- Ensure notification windows are on top of other UI elements
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,

    -- Customize notification icons for clarity (makes it easier to recognize issues).
    icons = {
      DEBUG = "", -- Bug icon for debugging
      ERROR = "", -- Error icon, immediately recognizable
      WARN = "", -- Warning icon
      INFO = "", -- Information icon
      TRACE = "✎", -- Trace icon for detailed logs
    },

    -- Set the background color behind notifications to ensure readability in all themes.
    background_colour = "#1e1e1e", -- Dark background for contrast
  },
}
