return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "ofseed/copilot-status.nvim" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Define colors
    local colors = {
      blue = "#83a598",
      green = "#b8bb26",
      violet = "#d3869b",
      yellow = "#fabd2f",
      red = "#fb4934",
      mauve = "#d3869b",
      fg = "#ebdbb2",
      bg = "#282828",
      inactive_bg = "#3c3836",
      semilightgray = "#a89984", -- Added missing color definition
    }

    -- Define lualine theme
    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg },
        x = { bg = colors.bg, fg = colors.fg },
        y = { bg = colors.bg, fg = colors.fg },
        z = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg },
        x = { bg = colors.bg, fg = colors.fg },
        y = { bg = colors.bg, fg = colors.fg },
        z = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg },
        x = { bg = colors.bg, fg = colors.fg },
        y = { bg = colors.bg, fg = colors.fg },
        z = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.mauve, fg = colors.bg, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg },
        x = { bg = colors.bg, fg = colors.fg },
        y = { bg = colors.bg, fg = colors.fg },
        z = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg },
        x = { bg = colors.bg, fg = colors.fg },
        y = { bg = colors.bg, fg = colors.fg },
        z = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    -- Function to detect virtual environment for Python
    local virtual_env = function()
      if vim.bo.filetype ~= "python" then
        return ""
      end

      local conda_env = os.getenv("CONDA_DEFAULT_ENV")
      local venv_path = os.getenv("VIRTUAL_ENV")

      if venv_path == nil then
        if conda_env == nil then
          return ""
        else
          return string.format("conda", conda_env)
        end
      -- component_separators = { left = '', right = '' },
      else
        local venv_name = vim.fn.fnamemodify(venv_path, ":t")
        return string.format("venv", venv_name)
      end
    end

    -- Function to check if macro recording is active
    local function isRecording()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end -- not recording
      return "recording @" .. reg
    end

    local function vim_logo()
      return " "
    end

    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_a = { vim_logo, "mode" },
        lualine_b = { isRecording },
        lualine_c = { "branch", "diff", "diagnostics", "filename" },
        lualine_x = {
          { "copilot" },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#fab387" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
          {
            virtual_env,
            color = function()
              local conda_env = os.getenv("CONDA_DEFAULT_ENV")
              if conda_env ~= nil then
                return { fg = colors.green } -- Conda environment in green
              else
                return { fg = colors.yellow } -- Venv in yellow
              end
            end,
          },
          { "progress" },
          { "location" },
        },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
