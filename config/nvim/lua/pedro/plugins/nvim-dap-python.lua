-- Python-specific DAP configuration
return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
  config = function()
    local dap_python = require("dap-python")
    -- Setup with the path to your Python interpreter
    dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

    -- Keybindings for Python testing
    vim.keymap.set("n", "<leader>dt", dap_python.test_method, { desc = "Debug Test Method" })
    vim.keymap.set("n", "<leader>df", dap_python.test_class, { desc = "Debug Test Class" })
  end,
}
