-- lazy.lua

return {
  {
    "mbbill/undotree", -- Plugin repository
    cmd = "UndotreeToggle", -- Load the plugin only when this command is called
    config = function()
      -- You can add any specific configurations here if needed
      vim.g.undotree_SetFocusWhenToggle = 1 -- Example: Set focus on the undotree window when toggled
    end,
    keys = {
      { "<leader>ut", ":UndotreeToggle<CR>", desc = "Toggle UndoTree" }, -- Keybinding for toggling the undo tree
    },
  },
}
