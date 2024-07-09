return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "ofseed/copilot-status.nvim" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    local colors = {
      blue = "#89b4fa",
      green = "#a6e3a1",
      violet = "#b4befe",
      yellow = "#f9e2af",
      red = "#f38ba8",
      mauve = "#cba6f7",
      fg = "#cdd6f4",
      bg = "#1e1e2e",
      inactive_bg = "#313244",
    }

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
          return string.format(" %s (conda)", conda_env)
        end
      else
        local venv_name = vim.fn.fnamemodify(venv_path, ":t")
        return string.format(" %s (venv)", venv_name)
      end
    end

    local function isRecording()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end -- not recording
      return "recording @" .. reg
    end

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {

        lualine_a = { "mode" },
        lualine_b = { isRecording },
        lualine_c = { "branch", "diff", "diagnostics", "filename" },

        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#fab387" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },

        lualine_y = {

          { "copilot" },
          {
            virtual_env,
          },
          { "progress" },
        },
      },
    })
  end,
}
