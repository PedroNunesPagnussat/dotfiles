-- DAP UI for better visualization
return {
  "rcarriga/nvim-dap-ui",
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    -- Setup DAP UI
    dapui.setup()

    -- Open DAP UI automatically
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    -- Close DAP UI when debugging session ends
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Keybinding to toggle DAP UI
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
  end,
}
