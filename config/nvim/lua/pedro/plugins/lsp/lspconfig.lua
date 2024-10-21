return {
  -- Neovim's built-in LSP client configuration
  "neovim/nvim-lspconfig",
  -- Load the plugin on buffer read or new file events
  event = { "BufReadPre", "BufNewFile" },
  -- Dependencies required for LSP functionality
  dependencies = {
    -- LSP source for nvim-cmp completion plugin
    "hrsh7th/cmp-nvim-lsp",
    -- File operations for LSP (e.g., rename files)
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- Neovim setup for Lua development (required by lua_ls)
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Import required modules
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local map = vim.keymap.set

    -- Define the function to run when an LSP server attaches to a buffer
    local on_attach = function(client, bufnr)
      -- Options for key mappings (buffer-local and silent)
      local opts = { buffer = bufnr, silent = true }

      -- List of LSP-related key mappings
      local mappings = {
        -- Go to references using Telescope
        { desc = "Go to references", keys = "gr", cmd = "<cmd>Telescope lsp_references<CR>" },
        -- Go to declaration
        { desc = "Go to declaration", keys = "gD", cmd = vim.lsp.buf.declaration },
        -- Go to definitions using Telescope
        { desc = "Go to definitions", keys = "gd", cmd = "<cmd>Telescope lsp_definitions<CR>" },
        -- Show implementations using Telescope
        { desc = "Show LSP implementations", keys = "gi", cmd = "<cmd>Telescope lsp_implementations<CR>" },
        -- Go to type definitions using Telescope
        { desc = "Go to type definitions", keys = "gt", cmd = "<cmd>Telescope lsp_type_definitions<CR>" },
        -- Code actions (both normal and visual modes)
        { desc = "Code actions", keys = "<leader>ca", cmd = vim.lsp.buf.code_action, mode = { "n", "v" } },
        -- Rename symbol
        { desc = "Smart replace", keys = "<leader>rs", cmd = vim.lsp.buf.rename },
        -- Find diagnostics using Telescope
        { desc = "Find diagnostics", keys = "<leader>fd", cmd = "<cmd>Telescope diagnostics bufnr=0<CR>" },
        -- Show line diagnostics in a floating window
        { desc = "Line diagnostics", keys = "<leader>d", cmd = vim.diagnostic.open_float },
        -- Navigate to previous diagnostic
        { desc = "Go to previous diagnostic", keys = "[d", cmd = vim.diagnostic.goto_prev },
        -- Navigate to next diagnostic
        { desc = "Go to next diagnostic", keys = "]d", cmd = vim.diagnostic.goto_next },
        -- Show documentation for the symbol under the cursor
        { desc = "Show documentation for what is under cursor", keys = "K", cmd = vim.lsp.buf.hover },
        -- Restart LSP server
        { desc = "Restart LSP", keys = "<leader>lr", cmd = ":LspRestart<CR>" },
      }

      -- Set the key mappings defined above
      for _, mapping in ipairs(mappings) do
        map(
          mapping.mode or "n", -- Mode: normal by default
          mapping.keys, -- Key sequence
          mapping.cmd, -- Command to execute
          vim.tbl_extend("force", opts, { desc = mapping.desc }) -- Options with description
        )
      end

      -- Additional buffer-local settings or commands can be added here
    end

    -- Enhance LSP capabilities with nvim-cmp for autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Customize diagnostic signs in the sign column
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      -- Define sign with text and highlight group
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Set up LSP servers using mason-lspconfig
    mason_lspconfig.setup_handlers({
      -- Default handler for servers not explicitly configured
      function(server_name)
        -- List of servers to use the default handler
        local default_servers = { "pyright", "lua_ls", "dockerls" }
        if vim.tbl_contains(default_servers, server_name) then
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end
      end,
      -- Specific configuration for ruff (built-in Ruff LSP server)
      ["ruff_lsp"] = function()
        lspconfig.ruff_lsp.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          init_options = {
            -- Ruff LSP specific settings can be added here
            settings = {
              args = {}, -- Add any Ruff-specific arguments here
            },
          },
        })
      end,
      -- Specific configuration for pyright (Python language server)
      ["pyright"] = function()
        -- Merge default capabilities with Pyright-specific settings
        local pyright_capabilities = vim.tbl_deep_extend("force", capabilities, {
          textDocument = {
            publishDiagnostics = {
              tagSupport = { valueSet = { 2 } }, -- Support for deprecation tags
            },
          },
        })
        lspconfig.pyright.setup({
          capabilities = pyright_capabilities,
          on_attach = on_attach,
          settings = {
            python = {
              analysis = {
                useLibraryCodeForTypes = true, -- Use library code for type information
                typeCheckingMode = "basic", -- Set type checking level
                diagnosticMode = "openFilesOnly",
                autoSearchPaths = true,
                diagnosticSeverityOverrides = {
                  reportUnusedImport = "none",
                  reportUnusedVariable = "none",
                  reportUnusedFunction = "none",
                  reportUnusedClass = "none",
                  reportDuplicateImport = "none",
                  -- Add other diagnostics you want Pyright to ignore
                },
                -- Add the 'exclude' setting here
                exclude = {
                  "~/.local/share/uv/python/**",
                },
              },
            },
          },
        })
      end,
      -- Specific configuration for lua_ls (Lua language server)
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- Recognize 'vim' as a global variable
              },
              completion = {
                callSnippet = "Replace", -- Adjust completion behavior
              },
            },
          },
        })
      end,
      -- Specific configuration for dockerls (Dockerfile language server)
      ["dockerls"] = function()
        lspconfig.dockerls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          -- Additional settings for dockerls can be added here
        })
      end,
    })
  end,
}
