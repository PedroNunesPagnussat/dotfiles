-- DAP configuration
return {
  "mfussenegger/nvim-dap",
  ft = "python",
  config = function()
    local dap = require("dap")

    -- Define custom highlight groups for breakpoints
    vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#cc241d" }) -- Example: red text on white background

    -- Customize icons for breakpoints
    vim.fn.sign_define("DapBreakpoint", { text = "󰐾", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "󰰲 ", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
    )

    -- Keybindings for DAP actions
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue Execution" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into Function" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over Line" })
    vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out of Function" })
    -- vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
  end,
}
