-- 1. Load plugins FIRST (must come before anything that uses them)
require("config.plugins")
require("config.statusline")
require("config.lsp")
require("config.other")
require("config.ai")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10 -- keep lines around cursor
vim.opt.sidescrolloff = 10

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2 -- IMPORTANT: preserved from old config
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI
vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")

vim.opt.signcolumn = "yes" -- always show signs
vim.opt.colorcolumn = "100" -- ruler at 100 chars
vim.opt.showmatch = true -- highlight matching brackets
-- vim.opt.cmdheight = 1
vim.opt.showmode = false -- using statusline instead
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0

-- Completion (still required for cmp/blink)
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Performance
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

-- Visual cleanup
vim.opt.fillchars = { eob = " " } -- remove ~ lines

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Toggle Neo-tree
vim.keymap.set("n", "<leader>e", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end, { desc = "File Explorer (Neo-tree)" })

-- ============================================================================
-- GLOBAL STATUSLINE (ONE FOR ENTIRE UI)
-- ============================================================================
-- WHY:
-- Shows ONLY one statusline for whole Neovim instance
-- Always reflects the ACTIVE window (like tmux)

vim.opt.laststatus = 3

-- ============================================================================
-- FILE / UNDO SETTINGS
-- ============================================================================
-- WHY:
-- Same logic → still correct in v0.12

local undodir = vim.fn.expand("~/.vim/undodir")

if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

vim.opt.autoread = true
vim.opt.autowrite = false

-- ============================================================================
-- GENERAL BEHAVIOR
-- ============================================================================

vim.opt.hidden = true -- allow switching buffers without saving
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false

vim.opt.iskeyword:append("-") -- treat - as word
vim.opt.path:append("**") -- recursive file search

vim.opt.selection = "inclusive"
vim.opt.mouse = "a"
vim.opt.modifiable = true
vim.opt.encoding = "utf-8"

-- ============================================================================
-- CURSOR
-- ============================================================================
-- WHY:
-- Still valid → no change in v0.12

vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- ============================================================================
-- FOLDING (TREESITTER BASED)
-- ============================================================================
-- WHY:
-- v0.12 improved treesitter, but config remains same

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- ============================================================================
-- WINDOW BEHAVIOR
-- ============================================================================

vim.opt.splitbelow = true
vim.opt.splitright = true

-- ============================================================================
-- COMMAND-LINE COMPLETION
-- ============================================================================

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- ============================================================================
-- PERFORMANCE TUNING
-- ============================================================================

vim.opt.diffopt:append("linematch:60")
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- ============================================================================
-- CORE KEYMAPS (PORTED FROM OLD)
-- ============================================================================

-- Better movement on wrapped lines
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })

vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Clear search
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Centered navigation
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" }) -- First SEARCH then press n
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" }) -- First SEARCH then press N
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" }) -- Ctrl+d
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" }) -- Ctrl+u

-- Paste/delete without yank
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" }) -- SPACE+p
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" }) -- SPACE+x

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" }) -- SPACE+bn
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" }) -- SPACE+bp

-- Move lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" }) -- ALT+j
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" }) -- ALT+k
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" }) -- SELECT and ALT+j
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" }) -- SELECT and ALT+k

-- Indent retain selection
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" }) -- Select + <
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" }) -- Select + >

-- Join lines keep cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" }) -- J

-- ============================================================================
-- FUZZY FIND
-- ============================================================================
vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<CR>", { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", ":FzfLua help_tags<CR>", { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", ":FzfLua diagnostics_document<CR>", { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", ":FzfLua diagnostics_workspace<CR>", { desc = "FZF Diagnostics Workspace" })

-- Expert Keymap for the status window
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })

-- ============================================================================
-- FILE PATH COPY (IMPORTANT FEATURE YOU HAD)
-- ============================================================================

vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)

vim.keymap.set("n", "<leader>rpa", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	print("file:", path)
end)

-- ============================================================================
-- DIAGNOSTICS TOGGLE
-- ============================================================================
-- WHY:
-- Works with new built-in LSP (v0.12)

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- ============================================================================
-- AUTOCMDS (UNCHANGED)
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- restore cursor
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		pcall(vim.api.nvim_win_set_cursor, 0, mark)
	end,
})

-- markdown/text behavior
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

--
-- Enable the byte-compiler
vim.loader.enable()

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("NativeTS", { clear = true }),
	callback = function(args)
		local bufnr = args.buf
		local ft = vim.bo[bufnr].filetype

		-- 1. Ignore "special" buffers like neo-tree, telescope, or help files
		local ignore_ft = { "neo-tree", "TelescopePrompt", "help", "qf" }
		for _, name in ipairs(ignore_ft) do
			if ft == name then
				return
			end
		end

		-- 2. Only start if a parser is actually installed on your Arch system
		-- This check prevents the "Parser could not be created" error
		local lang = vim.treesitter.language.get_lang(ft)
		if lang then
			-- Use pcall to wrap the start function just in case
			pcall(vim.treesitter.start, bufnr, lang)

			-- Enable native indentation
			vim.bo[bufnr].indentexpr = "v:lua.vim.treesitter.indentexpr()"
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	command = "checktime",
})

-- ============================================================================
-- STATUSLINE
-- ============================================================================
_G.sl = require("config.statusline")

vim.opt.statusline = table.concat({
	" ",
	"%{v:lua.sl.mode()}",
	" \u{e0b1} %{v:lua.sl.relpath()}",
	" \u{e0b1} %{v:lua.sl.git()} %{v:lua.sl.git_diff()}",
	" \u{e0b1} %h%m%r",
	" \u{e0b1} %{v:lua.sl.current_function()}",
	"%=",
	"%{v:lua.sl.lsp_progress()}",
	" \u{e0b3} %{v:lua.sl.lsp()}",
	" \u{e0b3} %{v:lua.sl.formatter()}",
	" \u{e0b3} %{v:lua.sl.diag()}",
	" \u{e0b3} %l:%c",
	" \u{e0b3} %P",
	" \u{e0b3} %{v:lua.sl.size()} ",
})
