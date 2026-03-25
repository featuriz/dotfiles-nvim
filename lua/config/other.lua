-- format 
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- go
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.go",
	callback = function()
		vim.cmd("silent! !goimports -w %")
	end,
})

-- lua
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.lua",
	callback = function()
		vim.cmd("silent! !stylua -w %")
	end,
})

