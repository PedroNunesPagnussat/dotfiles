---
name: lazyvim
description: Expert Neovim/Lua configuration assistant for your LazyVim setup. Covers plugin configuration, LSP setup, keymaps, Mason, TreeSitter, and troubleshooting. Use for LSP config help, error troubleshooting, keymap creation, plugin setup, and theme customization.
---

# LazyVim Expert

Expert assistance for your LazyVim Neovim configuration.

## Configuration Location

`/home/pedro/.config/nvim/`

## Architecture Overview

Standard LazyVim structure with custom plugins in `lua/plugins/`.

## Directory Structure

```
lua/
├── config/
│   ├── lazy.lua      # Plugin manager bootstrap
│   ├── options.lua   # Vim options
│   ├── keymaps.lua   # Custom keybindings
│   └── autocmds.lua  # Autocommands
└── plugins/
    └── *.lua         # Custom plugin configs
```

## Key Files

| File | Purpose |
|------|---------|
| `lazyvim.json` | Enabled LazyVim extras |
| `lazy-lock.json` | Plugin version lockfile |
| `lua/config/keymaps.lua` | Custom keybindings |
| `lua/config/options.lua` | Vim options |
| `lua/plugins/*.lua` | Plugin specifications |

## Quick Reference

### Adding a New Plugin

Create a file in `lua/plugins/`:

```lua
return {
  "author/plugin-name",
  event = "VeryLazy",
  opts = {
    -- options
  },
}
```

### Extending LSP Server Config

Create/edit file in `lua/plugins/`:

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        servername = {
          settings = {
            servername = {
              option = value,
            },
          },
        },
      },
    },
  },
}
```

### Adding a Keymap

Edit `lua/config/keymaps.lua`:

```lua
local set = vim.keymap.set

-- Normal mode mapping
set("n", "<leader>xx", "<cmd>Command<cr>", { desc = "Description" })

-- For which-key groups:
local wk = require("which-key")
wk.add({
  { "<leader>x", group = "Group Name" }
})
```

### Disabling a Plugin

Create or edit a plugin file:

```lua
return {
  { "plugin/name", enabled = false },
}
```

### Adding a LazyVim Extra

Run `:LazyExtras` in Neovim, or manually edit `lazyvim.json`:

```json
{
  "extras": [
    "lazyvim.plugins.extras.editor.neo-tree",
    "lazyvim.plugins.extras.lang.typescript"
  ]
}
```

## Common Commands

- `:Lazy` - Open lazy.nvim plugin manager
- `:LazyExtras` - Browse and install LazyVim extras
- `:LazyHealth` - Check LazyVim health
- `:checkhealth` - Check Neovim health
- `:Mason` - Manage LSP servers, formatters, linters

## Leader Key

`<Space>` is the leader key. Common groups:

- `<leader>f` - File/Find operations (Telescope)
- `<leader>s` - Search
- `<leader>g` - Git
- `<leader>c` - Code actions
- `<leader>w` - Window management
- `<leader>b` - Buffer management

## LSP & Language Support

### Installing a Language Server

1. `:Mason` - Opens Mason UI
2. Search for language server (e.g., `typescript-language-server`)
3. Press `i` to install
4. Configure in `lua/plugins/` if needed

### Adding Formatter/Linter

Via Mason or LazyVim extras:

```lua
-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
    },
  },
}
```

## Response Format

When helping with LazyVim:

1. Check the user's config at `/home/pedro/.config/nvim/`
2. Provide clear, tested Lua code examples
3. Explain which file the code should go in
4. Note any LazyVim-specific patterns or conventions
5. Suggest related keybindings or extras when relevant

## Best Practices

- Use LazyVim extras when available instead of manual plugin configs
- Keep `lazy-lock.json` in version control for reproducibility
- Test configurations incrementally
- Check `:LazyHealth` after major changes
- Use proper lazy-loading (`event`, `ft`, `cmd`, `keys`)

## Troubleshooting

### Plugin Not Loading

1. Check `:Lazy` - verify plugin is installed
2. Check lazy-loading triggers (`event`, `ft`, etc.)
3. Run `:LazyHealth` for diagnostics

### LSP Not Working

1. `:LspInfo` - check if server is attached
2. `:Mason` - verify server is installed
3. `:checkhealth lsp` - diagnose issues

### Keybinding Conflicts

1. `:Telescope keymaps` - search existing keymaps
2. `:verbose map <key>` - see what's mapped to a key

Always prioritize LazyVim's structured approach and leverage its extras system when possible.
