-- ============================================================================
-- LSP SETUP (Neovim v0.12 native API)
-- ============================================================================
-- Add Mason's bin folder to PATH so vim.lsp.enable can find the binaries
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- ============================================================================
-- DIAGNOSTICS (same as old, slightly improved)
-- ============================================================================

vim.diagnostic.config({
	virtual_text = { prefix = "●" }, -- cleaner than true
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- ============================================================================
-- CAPABILITIES (IMPORTANT - for completion engines like blink.cmp)
-- ============================================================================
-- WHY:
-- Without this → no proper LSP completion

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- If blink.cmp exists, enhance capabilities
local ok, blink = pcall(require, "blink.cmp")
if ok then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

-- ============================================================================
-- LSP SERVERS (RESTORED FROM OLD CONFIG)
-- ============================================================================
-- WHY:
-- v0.12 does NOT auto-enable servers → must define manually

-- Lua
vim.lsp.config.lua_ls = {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- fix undefined vim
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}
vim.lsp.enable("lua_ls")

-- Go
vim.lsp.config.gopls = {
	capabilities = capabilities,
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
vim.lsp.config.templ = {
	capabilities = capabilities,
}
vim.lsp.enable("templ")

-- HTML
vim.lsp.config.html = {
	capabilities = capabilities,
	filetypes = { "html", "templ" },
}
vim.lsp.enable("html")

-- HTMX
vim.lsp.config.htmx = {
	capabilities = capabilities,
	filetypes = { "html", "templ" },
}
vim.lsp.enable("htmx")

-- Tailwind
vim.lsp.config.tailwindcss = {
	capabilities = capabilities,
	filetypes = { "html", "templ", "javascript" },
	settings = {
		tailwindCSS = {
			includeLanguages = {
				templ = "html",
			},
		},
	},
}
vim.lsp.enable("tailwindcss")

-- Emmet
vim.lsp.config.emmet_ls = {
	capabilities = capabilities,
	filetypes = { "html", "templ", "css", "scss" },
}
vim.lsp.enable("emmet_ls")

-- ============================================================================
-- PROJECT ROOT DETECTION (IMPROVED)
-- ============================================================================
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local root = client and client.config.root_dir
		if root then
			vim.cmd("lcd " .. vim.fn.fnameescape(root))
		end
		-- This forces a statusline refresh when the LSP finally connects
		vim.schedule(function()
			vim.cmd("redrawstatus")
		end)
	end,
})
