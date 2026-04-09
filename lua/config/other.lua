-- https://github.com/stevearc/conform.nvim
local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofmt", "goimports" },
		templ = { "templ" },
		markdown = { "prettierd" },
		yaml = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		javascript = { "prettierd" },
	},
	-- Best practice: Format on save
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- Which key
local wk = require("which-key")
wk.setup({
	preset = "modern", -- Use the sleek v3+ UI
	win = {
		border = "single", -- Matches your Arch/Terminal aesthetic
	},
})
wk.add({
	{ "<leader>f", group = "find (fzf-lua)" },
	{ "<leader>g", group = "go (gopls)" },
	{ "<leader>l", group = "lsp (native v0.12)" },
	{ "<leader>t", group = "templ/html" },
})

-- Mason
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
