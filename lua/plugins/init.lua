return {
	-- Core dependencies
	-- https://github.com/nvim-lua/plenary.nvim
	{ "nvim-lua/plenary.nvim", lazy = true },

	-- https://github.com/nvim-tree/nvim-web-devicons
	-- { "nvim-tree/nvim-web-devicons", opts = {} },

	-- Tree / Folder
	-- https://github.com/nvim-tree/nvim-tree.lua
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 35,
				},
				filters = {
					dotfiles = false,
				},
				renderer = {
					group_empty = true,
				},
				git = {
					enable = true,
					ignore = false,
				},
			})
		end,
	},

	-- FUZZY FINDER
	-- https://github.com/junegunn/fzf?tab=readme-ov-file#linux-packages -- FIRST install this in pc
	-- https://github.com/ibhagwan/fzf-lua
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- 40+ Indepentednt modules
	-- https://github.com/nvim-mini/mini.nvim
	{
		"nvim-mini/mini.nvim",
		version = "*",
		config = function()
			require("mini.ai").setup({})
			require("mini.comment").setup({}) -- gcc => Add comment this line
			require("mini.move").setup({})
			require("mini.surround").setup({})
			require("mini.cursorword").setup({})
			require("mini.indentscope").setup({})
			require("mini.pairs").setup({})
			require("mini.trailspace").setup({})
			require("mini.bufremove").setup({})
			require("mini.notify").setup({})
			require("mini.icons").setup({})
		end,
	},

	-- https://github.com/stevearc/conform.nvim
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofumpt", "goimports" },
				templ = { "templ" },
				markdown = { "prettierd", "marksman" },
				yaml = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	-- Treesitter
	-- https://github.com/nvim-treesitter/nvim-treesitter
	{ "nvim-treesitter/nvim-treesitter", branch = "main", lazy = false, build = ":TSUpdate" },

	-- https://github.com/nvim-lualine/lualine.nvim
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- },

	-- https://github.com/L3MON4D3/LuaSnip
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},

	-- https://github.com/folke/which-key.nvim
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- https://github.com/hrsh7th/nvim-cmp
	-- { "hrsh7th/nvim-cmp" },
	-- { "hrsh7th/nvim-lspconfig" },
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/cmp-buffer" },
	-- { "hrsh7th/cmp-path" },
	-- { "hrsh7th/cmp-cmdline" },
	-- { "saadparwaiz1/cmp_luasnip" }, -- For luasnip users. As per https://github.com/hrsh7th/nvim-cmp#setup

	-- LSP:: https://github.com/neovim/nvim-lspconfig
	{ "neovim/nvim-lspconfig" },
	-- MASON:: https://github.com/mason-org/mason.nvim
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	-- https://github.com/mason-org/mason-lspconfig.nvim
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			-- ensure_installed = { "lua_ls" },
		},
		dependencies = { { "mason-org/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
	},

	-- https://github.com/saghen/blink.cmp
	-- https://cmp.saghen.dev/installation#lazy-nvim
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "none",
				["<CR>"] = { "accept", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
				kind_icons = {
					Codeium = "󱜙", -- Custom icon for AI suggestions
					Windsurf = "󱜙", -- Or "󰧑" if you prefer a different AI spark
				},
			},
			completion = { documentation = { auto_show = true } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			-- cmdline = {
			-- 	keymap = { preset = "inherit" },
			-- 	completion = { menu = { auto_show = true } },
			-- },
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "windsurf" },
				providers = {
					windsurf = {
						name = "Windsurf",
						module = "codeium.blink",
						score_offset = 100,
						async = true,
						transform_items = function(_, items)
							for _, item in ipairs(items) do
								item.kind_icon = "󱜙"
								item.kind_name = "Windsurf" -- This maps to your icon key
							end
							return items
						end,
					},
				},
			},
		},
	},
	--
	-- GIT
	-- https://github.com/tpope/vim-fugitive
	{
		"tpope/vim-fugitive",
	},
	-- https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",
	},
	--
	-- AI
	-- https://github.com/Exafunction/windsurf.vim
	{
		"Exafunction/windsurf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				virtual_text = { enabled = true },
			})
		end,
	},

	{},
}
