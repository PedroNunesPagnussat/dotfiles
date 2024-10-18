return {
  {
    -- Undotree plugin to visualize undo history in a tree structure
    "mbbill/undotree", -- Plugin repository
    cmd = "UndotreeToggle", -- Lazy-load the plugin only when this command is called
    config = function()
      -- Configuration for undotree behavior and appearance
      vim.g.undotree_SetFocusWhenToggle = 1 -- Set focus on the undotree window when toggled
      vim.g.undotree_SplitWidth = 30 -- Set the width of the undotree window
      vim.g.undotree_WindowLayout = 3 -- Open undotree on the right (2 is for left, 3 for right)
      vim.g.undotree_DiffpanelHeight = 10 -- Set height of the diff panel (useful for comparing changes)
      vim.g.undotree_HelpLine = 0 -- Disable help line at the bottom of the undotree window
      vim.g.undotree_TreeNodeShape = "◉" -- Change shape of nodes in the undo tree
      vim.g.undotree_SetFocusWhenToggle = 1 -- Focus undotree window upon toggling
    end,
    keys = {
      { "<leader>ut", ":UndotreeToggle<CR>", desc = "Toggle UndoTree" }, -- Keybinding for toggling the undo tree
    },
  },
}
