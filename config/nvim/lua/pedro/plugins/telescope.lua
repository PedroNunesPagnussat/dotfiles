return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    -- Core dependencies
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",

    -- Additional features
    "folke/todo-comments.nvim", -- Todo comments integration
    "nvim-telescope/telescope-project.nvim", -- Project management
    "nvim-telescope/telescope-file-browser.nvim", -- File browser
    "nvim-telescope/telescope-ui-select.nvim", -- Improved UI selector
    "folke/trouble.nvim", -- Trouble.nvim for diagnostics, quickfix, etc.

    -- TODO: Make its own module
    -- Debugging (nvim-dap as a dependency)
    -- {
    --   "mfussenegger/nvim-dap",
    --   config = function()
    --     -- Optional dap configuration
    --   end,
    -- },
    -- "nvim-telescope/telescope-dap.nvim", -- Debugger integration
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local trouble = require("trouble.providers.telescope")

    -- Custom function: Toggle preview in Telescope
    local function toggle_preview()
      local action_state = require("telescope.actions.state")
      local picker = action_state.get_current_picker(vim.api.nvim_get_current_buf())
      local previewer = picker.previewer

      if previewer then
        if picker._preview_win then
          -- Hide preview
          vim.api.nvim_win_close(picker._preview_win, true)
          picker._preview_win = nil
        else
          -- Show preview
          picker:previewer()
        end
      end
    end

    -- Telescope setup
    telescope.setup({
      defaults = {
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules", "*.lock" },
        prompt_prefix = " ",
        selection_caret = "󰐾 ",
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-p>"] = toggle_preview, -- Custom preview toggle function
            -- ["<C-l>"] = trouble.open_with_trouble, -- Open selected with Trouble
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Search hidden files
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          previewer = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!.git/" }
          end,
        },
        buffers = {
          previewer = true,
          sort_lastused = true,
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        project = {
          base_dirs = {
            "~/dotfiles",
            "~/dev",
          },
          hidden_files = true,
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Load Telescope extensions
    telescope.load_extension("fzf")
    telescope.load_extension("project")
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")
    telescope.load_extension("todo-comments")
    -- telescope.load_extension("dap") -- Load dap extension after nvim-dap

    -- Key mappings for Telescope
    local map = vim.keymap.set
    local opts = { desc = "Telescope" }

    -- Basic Telescope mappings
    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
    map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find word" })
    map("n", "<leader>fg", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
    map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

    -- Additional mappings
    map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
    map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
    map("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = "Switch projects" })
    map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

    -- New mapping: Find diagnostics/issues with Trouble
    map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })
  end,
}
