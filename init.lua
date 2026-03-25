-- https://github.com/radleylewis/nvim-lite/blob/master/init.lua
--
require("config.lazy")
-- require("config.cmp")
require("config.status_line")
require("config.lsp")
-- require("config.other")

-- Color
vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")

-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
-- vim.opt.statuscolumn = "%s %{v:lnum} %{v:relnum} "
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

-- UNDO: Keep in a file for later use
local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding

-- CURSOR: Blink
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" -- cursor blinking and settings

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j" -- gj
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k" -- gk
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" }) -- CLEAR Search Highlight

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" }) -- First SEARCH then press n
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" }) -- First SEARCH then press N
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" }) -- Ctrl+d
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" }) -- Ctrl+u

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" }) -- SPACE+p
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" }) -- SPACE+x

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" }) -- SPACE+bn
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" }) -- SPACE+bp

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" }) -- ALT+j
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" }) -- ALT+k
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" }) -- SELECT and ALT+j
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" }) -- SELECT and ALT+k

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" }) -- Select + <
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" }) -- Select + >

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" }) -- J

-- FILE PATH
vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })
vim.keymap.set("n", "<leader>rpa", function() -- show file path
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================

-- TREE TOGGLE
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- FUZZY FIND
vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<CR>", { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", ":FzfLua help_tags<CR>", { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", ":FzfLua diagnostics_document<CR>", { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", ":FzfLua diagnostics_workspace<CR>", { desc = "FZF Diagnostics Workspace" })

-- ============================================================================
--
