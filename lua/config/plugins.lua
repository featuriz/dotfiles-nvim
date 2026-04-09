vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/Exafunction/windsurf.nvim" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"), -- pin to 1.x stable
		build = "cargo build --release", -- compiles the Rust fuzzy binary
	},
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"), -- stable v3
	},
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})
