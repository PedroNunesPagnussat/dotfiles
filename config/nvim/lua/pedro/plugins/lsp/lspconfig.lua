return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local map = vim.keymap.set

    -- LSP Attach autocmd for setting up buffer-local keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        local mappings = {
          { desc = "Go to references", keys = "gr", cmd = "<cmd>Telescope lsp_references<CR>" },
          { desc = "Go to declaration", keys = "gD", cmd = vim.lsp.buf.declaration },
          { desc = "Go to definitions", keys = "gd", cmd = "<cmd>Telescope lsp_definitions<CR>" },
          { desc = "Show LSP implementations", keys = "gi", cmd = "<cmd>Telescope lsp_implementations<CR>" },
          { desc = "Go to type definitions", keys = "gt", cmd = "<cmd>Telescope lsp_type_definitions<CR>" },
          { desc = "Code actions", keys = "<leader>ca", cmd = vim.lsp.buf.code_action, mode = { "n", "v" } },
          { desc = "Smart replace", keys = "<leader>rs", cmd = vim.lsp.buf.rename },
          { desc = "Find diagnostics", keys = "<leader>fd", cmd = "<cmd>Telescope diagnostics bufnr=0<CR>" },
          { desc = "Line diagnostics", keys = "<leader>d", cmd = vim.diagnostic.open_float },
          { desc = "Go to previous diagnostic", keys = "[d", cmd = vim.diagnostic.goto_prev },
          { desc = "Go to next diagnostic", keys = "]d", cmd = vim.diagnostic.goto_next },
          { desc = "Show documentation for what is under cursor", keys = "K", cmd = vim.lsp.buf.hover },
          { desc = "Restart LSP", keys = "<leader>lr", cmd = ":LspRestart<CR>" },
        }

        for _, mapping in ipairs(mappings) do
          map(mapping.mode or "n", mapping.keys, mapping.cmd, vim.tbl_extend("force", opts, { desc = mapping.desc }))
        end
      end,
    })

    -- Set up capabilities for nvim-cmp
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Set up LSP servers with mason-lspconfig
    mason_lspconfig.setup_handlers({
      ["ruff_lsp"] = function()
        lspconfig.ruff_lsp.setup({ capabilities = capabilities })
      end,
      ["pyright"] = function()
        lspconfig.pyright.setup({
          capabilities = (function()
            local cap = vim.lsp.protocol.make_client_capabilities()
            cap.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            return cap
          end)(),
          settings = {
            python = {
              analysis = {
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  -- reportUnusedVariable = "none",
                  -- reportCallIssue = "none",
                  -- reportAttributeAccessIssue = "none",
                  reportMissingImports = "none",
                  -- reportMissingTypeStubs = "none",
                  -- reportGeneralTypeIssues = "none",
                  -- reportReturnType = "none",
                  -- reportInvalidTypeForm = "none",
                  -- reportArgumentType = "none",
                  -- reportUndefinedVariable = "none",
                  -- reportUnusedImport = "none",
                  -- reportUnusedFunction = "none",
                  -- reportUnusedClass = "none",
                  -- reportMissingTypeArgument = "none",
                  -- reportMissingTypeAnnotation = "none",
                  -- reportInvalidTypeVarUse = "none",
                  -- reportUnusedExpression = "none",
                  -- reportUnboundVariable = "none",
                },
                typeCheckingMode = "basic",
              },
            },
          },
        })
      end,
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
