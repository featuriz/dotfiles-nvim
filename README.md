# ⚡ Neovim v0.12 Config (Arch Linux + tmux)

A **minimal, fast, LSP-first Neovim setup** with AI-assisted completion and zero bloat.

---

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Neovim](https://img.shields.io/badge/Neovim-0.12+-57A143.svg)](https://neovim.io)

---

## ✨ Highlights

- ⚡ Fast startup (`vim.loader`)
- 🧠 Native LSP + Treesitter (no heavy abstraction)
- 🤖 AI completion (Codeium via `windsurf.nvim`)
- 🚀 Rust-powered completion (`blink.cmp`)
- 🪶 Minimal plugins, maximum control
- 🧩 Works cleanly inside `tmux`

---

## ✨ Features

- **Completion**
  - `blink.cmp` (Rust fuzzy engine)
  - LSP + buffer + path + snippets
  - AI suggestions (Codeium integrated into same menu)

- **LSP**
  - `nvim-lspconfig`
  - `mason.nvim` for managing servers

- **UI / UX**
  - `which-key.nvim`
  - `neo-tree.nvim`
  - Nerd Font icons

- **Search**
  - `fzf-lua`

- **Git**
  - `gitsigns.nvim`

- **Formatting**
  - `conform.nvim`

---

## 📦 Plugins

- `plenary.nvim`
- `windsurf.nvim` (Codeium integration)
- `blink.cmp` (Rust fuzzy)
- `friendly-snippets`
- `nvim-lspconfig`
- `mason.nvim`
- `neo-tree.nvim`
- `nui.nvim`
- `fzf-lua`
- `conform.nvim`
- `which-key.nvim`
- `gitsigns.nvim`

---

## ⚙️ Requirements

- Neovim **v0.12+**
- Arch Linux (or compatible)
- `tmux`
- `cargo` (for building `blink.cmp`)
- Nerd Font (recommended)

---

## 🔧 Installation

```bash
git clone https://github.com/featuriz/dotfiles-nvim ~/.config/nvim
```

Then open Neovim:

```bash
nvim
```

Build step (required for performance):

```bash
cd ~/.local/share/nvim/site/pack/*/start/blink.cmp
cargo build --release
```

---

## ⌨️ Keymaps (Completion)

| Key       | Action                   |
| --------- | ------------------------ |
| `<CR>`    | New line (no accept)     |
| `<C-j>`   | Next item                |
| `<C-k>`   | Previous item            |
| `<Tab>`   | Accept + Snippet forward |
| `<S-Tab>` | Snippet backward         |

> ⚠️ `<C-CR>` is NOT used (tmux/terminal limitation)

---

### General

- `<leader>e` → File explorer
- `<leader>ff` → Find files
- `<leader>fg` → Live grep
- `<leader>fb` → Buffers
- `<leader>c` → Clear search
- `<leader>td` → Toggle diagnostics

- `<leader>zj` → Next block `{`
- `<leader>zk` → Previous block `}`
- `vi{` → Visual select inside `{`
- `va{` → Visual select around `{`

---

## 🧠 Behavior

- **Enter never confirms completion**
- AI + LSP suggestions share same menu
- AI suggestions are prioritized
- Completion is fully async (no UI blocking)

---

## 🧩 Notable Design Choices

- `completeopt = menuone,noinsert,noselect`
- Global statusline (`laststatus = 3`)
- Treesitter folding + indentation
- Native Treesitter start (manual control)
- No Treesitter plugin dependency

---

## 🤖 AI Integration

- Powered by **Codeium** via `windsurf.nvim`
- Suggestions appear inline with normal completion
- Prioritized in menu automatically

---

## 🧠 Philosophy

- Keep it **minimal**
- Prefer **native Neovim APIs**
- Avoid unnecessary abstraction
- Fast startup, fast completion

---

## ⚠️ Disclaimer

This is a personal config:

- May change frequently
- No guarantee of stability
- Optimized for my workflow

---

## 📌 Notes

- Uses **Rust-based fuzzy matching** (fallback to Lua if not built)
- AI suggestions are async and won’t block UI
- Works best inside `tmux`

---

## 🧩 Future Improvements

- Treesitter enhancements
- Better tmux navigation integration
- More LSP optimizations

---
