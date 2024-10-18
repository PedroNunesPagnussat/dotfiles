return {
  "github/copilot.vim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local map = vim.keymap.set
    -- Copilot settings
    -- vim.g.copilot_no_tab_map = true -- Disable default <Tab> mapping
    -- vim.g.copilot_assume_mapped = true -- Assume mappings are set manually

    -- Custom key mapping to accept Copilot suggestions
    -- map("i", "<C-f>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
  end,
}
