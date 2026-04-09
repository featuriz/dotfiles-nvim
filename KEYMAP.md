# ⚡ Neovim Cheat Sheet (Minimal + LSP + Treesitter)

## 🧭 Modes

| Key      | Mode         |
| -------- | ------------ |
| `i`      | Insert       |
| `Esc`    | Normal       |
| `v`      | Visual       |
| `V`      | Visual line  |
| `Ctrl+v` | Visual block |
| `:`      | Command      |

---

## 🚶 Movement

| Key                 | Action                                     |
| ------------------- | ------------------------------------------ |
| `h j k l`           | Move                                       |
| `w` / `b`           | Next / prev word                           |
| `0` / `^` / `$`     | Line start / first char / end              |
| `gg` / `G`          | Top / bottom                               |
| `Ctrl+d` / `Ctrl+u` | Half page down/up                          |
| `n` / `N`           | Next/prev search (centered in your config) |

---

## ✂️ Editing

| Key      | Action      |
| -------- | ----------- |
| `x`      | Delete char |
| `dd`     | Delete line |
| `yy`     | Copy line   |
| `p`      | Paste       |
| `u`      | Undo        |
| `Ctrl+r` | Redo        |

---

## 🎯 Better Editing (Important)

| Key   | Action        |
| ----- | ------------- |
| `ciw` | Change word   |
| `diw` | Delete word   |
| `yiw` | Copy word     |
| `ci"` | Inside quotes |
| `ci(` | Inside ()     |
| `ci{` | Inside {}     |

---

## 🧩 Block Selection (VERY IMPORTANT)

| Key   | Action             |
| ----- | ------------------ |
| `vi{` | Select inside `{}` |
| `va{` | Select around `{}` |
| `vi(` | Inside `()`        |
| `vi[` | Inside `[]`        |

👉 Works perfectly in your setup (no extra plugin needed)

---

## 🔍 Search

| Key         | Action          |
| ----------- | --------------- |
| `/text`     | Search          |
| `n`         | Next            |
| `N`         | Previous        |
| `<leader>c` | Clear highlight |

---

## 📂 Files / FZF (your config)

| Key          | Action     |
| ------------ | ---------- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep  |
| `<leader>fb` | Buffers    |
| `<leader>fh` | Help       |

---

## 📁 File Explorer

| Key         | Action          |
| ----------- | --------------- |
| `<leader>e` | Toggle Neo-tree |

---

## 🧠 LSP / Diagnostics

| Key          | Action             |
| ------------ | ------------------ |
| `<leader>td` | Toggle diagnostics |

---

## 🧾 Buffers

| Key          | Action          |
| ------------ | --------------- |
| `<leader>bn` | Next buffer     |
| `<leader>bp` | Previous buffer |

---

## 🧲 Window / View

| Key                 | Action                           |
| ------------------- | -------------------------------- |
| `zz`                | Center cursor                    |
| `Ctrl+d` / `Ctrl+u` | Scroll (centered in your config) |

---

## ✍️ Visual Mode Tricks

| Key         | Action                  |
| ----------- | ----------------------- |
| `>` / `<`   | Indent                  |
| `gv`        | Reselect                |
| `<leader>p` | Paste without overwrite |
| `<leader>x` | Delete without yank     |

---

## 🧱 Line Operations

| Key     | Action                                   |
| ------- | ---------------------------------------- |
| `J`     | Join lines (keeps cursor in your config) |
| `Alt+j` | Move line down                           |
| `Alt+k` | Move line up                             |

---

## 🤖 Completion (your setup)

| Key       | Action                   |
| --------- | ------------------------ |
| `<CR>`    | New line                 |
| `<C-j>`   | Next item                |
| `<C-k>`   | Previous item            |
| `<Tab>`   | Accept + Snippet forward |
| `<S-Tab>` | Snippet backward         |

---

## 📋 Clipboard

| Key           | Action             |
| ------------- | ------------------ |
| `<leader>pa`  | Copy absolute path |
| `<leader>rpa` | Copy relative path |

---

## ⚡ Power Combos (Learn these first)

```text
ciw     → change word
di{     → delete inside {}
va{     → select full block
ggVG    → select all
```

---

## 🧠 Mental Model

- **operator + motion**
  - `d` + `w` → delete word
  - `c` + `{` → change block
  - `y` + `i(` → copy inside ()

---

## ⚠️ Important Notes for Your Setup

- No Treesitter textobjects → use `vi{`, not `af`
- Enter does NOT accept completion (by design)
- AI suggestions are merged into completion menu

---

## 🚀 Next Level (when ready)

Learn:

- `f`, `t` → jump in line
- macros (`q`)
- marks (`m`, `'`)
- registers (`"`)

---

If you want, I can give a **level-based roadmap (Beginner → Expert)** specifically for your config.
