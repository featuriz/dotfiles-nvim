-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- Use the new API: vim.lsp.config

vim.lsp.config["lua_ls"] = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Fix "Undefined global 'vim'"
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			completion = {
				callSnippet = "Replace",
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.enable("lua_ls")

-- Go
vim.lsp.config["gopls"] = {
	settings = {
		gopls = {
			analyses = { unusedparams = true },
			staticcheck = true,
			gofumpt = true,
		},
	},
}
vim.lsp.enable("gopls")

-- Templ
vim.lsp.config["templ"] = {}
vim.lsp.enable("templ")

-- HTML (Optional but highly recommended for templ)
vim.lsp.config["html"] = {
	filetypes = { "html", "templ" },
}
vim.lsp.enable("html")

-- HTMX
vim.lsp.config["htmx"] = {
	filetypes = { "html", "templ" },
}
vim.lsp.enable("htmx")

-- Tailwind CSS
vim.lsp.config["tailwindcss"] = {
	filetypes = { "html", "templ", "javascript" }, -- , "svelte", "vue"
	settings = {
		tailwindCSS = {
			includeLanguages = {
				templ = "html", -- Treat templ as html for tailwind classes
			},
		},
	},
}
vim.lsp.enable("tailwindcss")

-- Emmet (Optional: for fast HTML expansion like div.container > ul > li*3)
vim.lsp.config["emmet_ls"] = {
	filetypes = { "html", "templ", "css", "sass", "scss", "less" },
}
vim.lsp.enable("emmet_ls")
