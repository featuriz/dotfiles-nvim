-- ============================================================================
-- WINDSURF (Codeium) SETUP
-- ============================================================================
require("codeium").setup({
	-- We use blink.cmp as the completion UI, not nvim-cmp
	-- Setting this to false disables the nvim-cmp source registration entirely
	enable_cmp_source = true,

	virtual_text = {
		enabled = true, -- Show ghost-text inline while you type
		manual = false, -- Auto-suggest (no keypress needed to trigger)
		idle_delay = 75, -- Wait 75ms after typing stops before requesting

		-- Keeps AI ghost-text visible above LSP inlay hints in the render order
		virtual_text_priority = 65535,

		-- true = default keymaps active (Tab=accept, Alt+[ / Alt+] to cycle)
		map_keys = true,
	},
})

-- ============================================================================
-- BLINK.CMP SETUP
-- Docs: https://cmp.saghen.dev
-- nvim-cmp is NOT installed — blink handles everything
-- ============================================================================
require("blink.cmp").setup({

	-- ----- Keymaps (unchanged from your v0.11 config) -----
	keymap = {
		preset = "none", -- all bindings are explicit
		["<CR>"] = { "fallback" }, -- Enter = accept
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "accept", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},

	-- ----- Appearance -----
	appearance = {
		nerd_font_variant = "mono", -- "mono" = Nerd Font Mono, "normal" = regular
		kind_icons = {
			-- Custom icons for AI suggestion entries in the blink menu
			Windsurf = "󱜙",
		},
	},

	-- ----- Completion behavior -----
	completion = {
		documentation = { auto_show = true }, -- auto-popup docs for selected item
	},

	-- ----- Fuzzy matching -----
	-- Uses the compiled Rust binary from 'cargo build --release' above
	-- Falls back to Lua implementation if binary is missing (with a warning)
	fuzzy = { implementation = "prefer_rust_with_warning" },

	-- ----- Completion sources -----
	sources = {
		-- "windsurf" feeds AI suggestions from codeium.blink into the same menu
		default = { "lsp", "path", "snippets", "buffer", "codeium" },

		providers = {
			codeium = {
				name = "Codeium",
				module = "codeium.blink", -- adapter module in windsurf.nvim
				score_offset = 100, -- float AI suggestions to the top
				async = true, -- non-blocking (cloud request)

				-- Stamp each AI item with the Windsurf icon in the menu
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						item.kind_icon = "󱜙"
						item.kind_name = "Windsurf"
					end
					return items
				end,
			},
		},
	},
})

-- ============================================================================
-- CODECOMPANION.NVIM SETUP — Multi-AI chat with easy switching
--
-- Free providers configured:
--   1. Gemini Flash  → most generous free tier, fast          ($GEMINI_API_KEY)
--   2. Groq          → very fast LPU inference, rate-limited  ($GROQ_API_KEY)
--   3. OpenRouter    → many free models, can be slow          ($OPENROUTER_API_KEY)
--
-- Get keys:
--   Gemini:      https://aistudio.google.com/apikey
--   Groq:        https://console.groq.com/keys
--   OpenRouter:  https://openrouter.ai/settings/keys
--
-- Export in your ~/.bashrc or ~/.zshrc:
--   export GEMINI_API_KEY="..."
--   export GROQ_API_KEY="..."
--   export OPENROUTER_API_KEY="..."
-- ============================================================================
-- require("codecompanion").setup({
--
-- 	adapters = {
--
-- 		-- Adapter 1: Google Gemini Flash — use this as your daily driver
-- 		gemini = function()
-- 			return require("codecompanion.adapters").extend("gemini", {
-- 				env = { api_key = "GEMINI_API_KEY" }, -- reads $GEMINI_API_KEY
-- 				schema = {
-- 					model = { default = "gemini-2.0-flash" },
-- 				},
-- 			})
-- 		end,
--
-- 		-- Adapter 2: Groq — fall back here when Gemini rate-limits you
-- 		groq = function()
-- 			return require("codecompanion.adapters").extend("openai_compatible", {
-- 				env = { api_key = "GROQ_API_KEY" }, -- reads $GROQ_API_KEY
-- 				url = "https://api.groq.com/openai/v1/chat/completions",
-- 				schema = {
-- 					model = { default = "llama-3.3-70b-versatile" },
-- 				},
-- 			})
-- 		end,
--
-- 		-- Adapter 3: OpenRouter free models — last resort
-- 		openrouter = function()
-- 			return require("codecompanion.adapters").extend("openai_compatible", {
-- 				env = { api_key = "OPENROUTER_API_KEY" },
-- 				url = "https://openrouter.ai/api/v1/chat/completions",
-- 				schema = {
-- 					model = {
-- 						-- ":free" suffix = OpenRouter free tier (no credits needed)
-- 						default = "meta-llama/llama-3.3-70b-instruct:free",
-- 					},
-- 				},
-- 			})
-- 		end,
-- 	},
--
-- 	-- Default adapter when no argument is passed to :CodeCompanionChat
-- 	-- Change "gemini" to whichever provider is working right now
-- 	strategies = {
-- 		chat = { adapter = "gemini" }, -- used by :CodeCompanionChat
-- 		inline = { adapter = "gemini" }, -- used by :CodeCompanion (inline ask)
-- 	},
-- 	display = {
-- 		chat = { window = { layout = "vertical", width = 0.35 } },
-- 		diff = { provider = "mini_diff" },
-- 	},
-- })
--
-- -- ============================================================================
-- -- AI SWITCH KEYMAPS
-- -- Windsurf handles inline completions automatically (always on)
-- -- These keymaps are for the codecompanion chat/ask workflow
-- --
-- -- Usage:
-- --   <leader>ac  → open chat with current adapter (default: Gemini)
-- --   <leader>ag  → switch to Gemini and open chat
-- --   <leader>ar  → switch to Groq and open chat
-- --   <leader>ao  → switch to OpenRouter and open chat
-- --   <leader>ai  → inline ask (selected text or current line)
-- -- ============================================================================
-- local map = vim.keymap.set
--
-- -- Open chat with whichever adapter is active in strategies above
-- map("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>", { desc = "AI: Open chat" })
--
-- -- Inline ask — works on visual selection or current line
-- map({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "AI: Inline ask" })
--
-- -- Switch to Gemini — your primary free provider
-- map("n", "<leader>ag", function()
-- 	vim.cmd("CodeCompanionChat gemini") -- adapter name passed as argument
-- end, { desc = "AI: Chat with Gemini (primary)" })
--
-- -- Switch to Groq — fast fallback when Gemini rate-limits
-- map("n", "<leader>ar", function()
-- 	vim.cmd("CodeCompanionChat groq")
-- end, { desc = "AI: Chat with Groq (fallback)" })
--
-- -- Switch to OpenRouter — last resort free models
-- map("n", "<leader>ao", function()
-- 	vim.cmd("CodeCompanionChat openrouter")
-- end, { desc = "AI: Chat with OpenRouter (last resort)" })
-- --
