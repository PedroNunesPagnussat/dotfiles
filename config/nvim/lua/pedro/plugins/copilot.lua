return {
  "github/copilot.vim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local map = vim.keymap.set

    map("i", "<C-Space>", "<cmd>Copilot panel<cr>", { desc = "Open Copilot panel" })
    map("n", "<leader>cc", "<cmd>Copilot panel<cr>", { desc = "Open Copilot panel" })
    map("n", "<leader>cd", "<cmd>Copilot disable<cr>", { desc = "Disable Copilot" })
    map("n", "<leader>ce", "<cmd>Copilot enable<cr>", { desc = "Enable Copilot" })
  end,
}
