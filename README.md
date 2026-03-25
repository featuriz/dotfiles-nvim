# Neovim Configuration

My personal Neovim setup for development across multiple machines.

## 📋 Requirements

- Neovim 0.9.0 or higher
- Git
- A Nerd Font (for icons)
- Node.js (for LSP support)
- Ripgrep (for Telescope)

## 🚀 Installation

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

# TREESITTER

- TSInstall lua => Install 'lua'. => /home/sud/.local/share/nvim/site/parser/lua.so. Sameway use TSUninstall.
- Inspect => Current Line
- InspectTree => Whole File. Inside press o => Query Editor(FILTER). `(function_call) @fn`
- checkhealth nvim-treesitter => TREESITTER Health

```
 require("lualine").setup({})

 local table = {} -- Error: shadowing_builtin
 local x = ; -- Invalid syntax
 require("luasnip.loaders.from_vscode").lazy_load()

```
