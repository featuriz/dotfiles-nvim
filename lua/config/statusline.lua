local M = {}

-- MODE
function M.mode()
	local m = vim.fn.mode()
	local modes = {
		n = " \u{f121} NORMAL",
		i = " \u{f11c} INSERT",
		v = " \u{f0168} VISUAL",
		V = " \u{f0168} V-LINE",
		["\22"] = " \u{f0168} V-BLOCK",
		c = " \u{f120} COMMAND",
		s = " \u{f0c5} SELECT",
		S = " \u{f0c5} S-LINE",
		["\19"] = " \u{f0c5} S-BLOCK",
		R = " \u{f044} REPLACE",
		r = " \u{f044} REPLACE",
		["!"] = " \u{f489} SHELL",
		t = " \u{f120} TERMINAL",
	}
	return modes[m] or (" \u{f059} " .. m)
end

-- PATH
function M.relpath()
	local file = vim.fn.expand("%")
	if file == "" then
		return ""
	end

	local path = vim.fn.fnamemodify(file, ":~:.")
	local w = vim.api.nvim_win_get_width(0)

	if w > 120 then
		return "\u{ea83} " .. path
	end

	local parts = vim.split(path, "/")
	if w < 60 then
		return "\u{ea83} " .. parts[#parts]
	end

	for i = 1, #parts - 2 do
		parts[i] = parts[i]:sub(1, 1)
	end
	return "\u{ea83} " .. table.concat(parts, "/")
end

-- GIT (gitsigns)
function M.git()
	local head = vim.b.gitsigns_head
	if not head or head == "" then
		return ""
	end
	return "\u{e725} " .. head
end

function M.git_diff()
	local g = vim.b.gitsigns_status_dict
	if not g then
		return ""
	end
	return string.format(" +%d ~%d -%d", g.added or 0, g.changed or 0, g.removed or 0)
end

-- CURRENT FUNCTION (Treesitter)
function M.current_function()
	local icon = "\u{f0295} "
	local ok, node = pcall(vim.treesitter.get_node, { bufnr = 0 })
	if not ok or not node then
		return icon
	end

	while node do
		local type = node:type()

		if type:match("function") or type:match("method") then
			local name_node = node:field("name")[1]
			if name_node then
				return icon .. vim.treesitter.get_node_text(name_node, 0)
			end
		end

		node = node:parent()
	end

	return icon
end

-- LSP
function M.lsp()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return "\u{eb51} " .. "no-lsp"
	end
	return "\u{eb51} " .. clients[1].name
end

function M.lsp_progress()
	local msg = vim.lsp.status()
	if not msg or msg == "" then
		return ""
	end
	msg = msg:gsub("Loading workspace: %d+/%d+", "Indexing")
	if #msg > 12 then
		msg = msg:sub(1, 12) .. "…"
	end
	return "\u{f051f} " .. msg
end

-- DIAGNOSTICS (fast)
function M.diag()
	local d = vim.diagnostic.count(0)
	if not d then
		return "\u{f0349}"
	end

	local out = {}
	if d[vim.diagnostic.severity.ERROR] then
		table.insert(out, " \u{ea87} " .. d[vim.diagnostic.severity.ERROR])
	end
	if d[vim.diagnostic.severity.WARN] then
		table.insert(out, " \u{ea6c} " .. d[vim.diagnostic.severity.WARN])
	end
	return "\u{f0349}" .. table.concat(out, "")
end

-- FORMATTER (conform.nvim)
function M.formatter()
	local ok, conform = pcall(require, "conform")
	if not ok then
		return "\u{ede4} "
	end

	local fmt = conform.list_formatters(0)
	if not fmt or #fmt == 0 then
		return "\u{ede4} "
	end

	return "\u{ede4} " .. fmt[1].name
end

-- FILE SIZE
function M.size()
	local s = vim.fn.getfsize(vim.fn.expand("%"))
	if s < 0 then
		return ""
	end
	if s < 1024 then
		return s .. "B"
	end
	if s < 1024 * 1024 then
		return string.format("%.1fK", s / 1024)
	end
	return string.format("%.1fM", s / 1024 / 1024)
end

return M
