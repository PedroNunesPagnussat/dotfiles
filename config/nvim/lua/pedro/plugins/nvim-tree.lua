return {
  "nvim-tree/nvim-tree.lua",
  event = { "VimEnter" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- Disable netrw (default file explorer) to avoid conflicts with nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      -- General settings
      auto_reload_on_write = true,
      reload_on_bufenter = true,
      hijack_cursor = true, -- Keep cursor on the same item after opening files

      -- File tree view settings
      view = {
        side = "right", -- Move tree view to the right
        width = 35, -- Set default width of the tree
        relativenumber = true, -- Show relative line numbers
      },

      -- Renderer settings for folder structure and icons
      renderer = {
        highlight_diagnostics = true, -- Highlight diagnostics in file tree
        highlight_git = true, -- Highlight git status
        -- root_folder_label = false, -- Customize if needed to highlight the root folder
        indent_markers = {
          enable = true, -- Show indent markers to improve visual clarity
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- Change arrow glyph when folder is closed
              arrow_open = "", -- Change arrow glyph when folder is open
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "", -- Icon for untracked files
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },

      -- Integration with window management to improve splits
      actions = {
        open_file = {
          resize_window = true, -- Auto-resize window after opening a file
          window_picker = {
            enable = false, -- Disable window picker when opening a file
          },
        },
      },

      -- Custom filters (e.g., ignore certain files)
      filters = {
        custom = { ".DS_Store", "node_modules", ".venv", "*.egg-info" },
      },

      -- Git integration
      git = {
        ignore = false, -- Show git ignored files in the tree
        show_on_dirs = true, -- Highlight git status on directories as well
      },

      -- Automatically focus the current file when opening the tree
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    })

    -- Keymap configurations
    local map = vim.keymap.set -- Use a shorthand for keymap settings

    -- Mappings for nvim-tree
    map("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    map("n", "<leader>t", function()
      local lib = require("nvim-tree.lib")
      local node = lib.get_node_at_cursor()
      if node and not node.open then
        vim.cmd("tabnew " .. node.absolute_path) -- Open the file in a new tab
      end
    end, { desc = "Open file in new tab" })

    -- Auto close nvim-tree
    vim.api.nvim_create_autocmd("WinLeave", {
      pattern = "NvimTree_*",
      command = "close",
    })
  end,
}
