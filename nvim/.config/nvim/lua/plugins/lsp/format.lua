local Util = require("lazy.core.util")

local M = {}

M.autoformat = true

function M.enabled()
	return M.opts.autoformat
end

function M.toggle()
	if vim.b.autoformat == false then
		vim.b.autoformat = nil
		M.autoformat = true
	else
		M.autoformat = not M.autoformat
	end
	if M.autoformat then
		Util.info("Enabled format on save", { title = "Format" })
	else
		Util.warn("Disabled format on save", { title = "Format" })
	end
end

---@param opts? {force?:boolean}
function M.format(opts)
	local buf = vim.api.nvim_get_current_buf()
	if vim.b.autoformat == false and not (opts and opts.force) then
		return
	end
	local ft = vim.bo[buf].filetype
	local have_nls = package.loaded["null-ls"]
		and (#require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0)

	vim.lsp.buf.format(vim.tbl_deep_extend("force", {
		bufnr = buf,
		filter = function(client)
			if have_nls then
				return client.name == "null-ls"
			end
			return client.name ~= "null-ls"
		end,
	}, require("exsqzme.util").opts("nvim-lspconfig").format or {}))
end

---@param formatters LazyVimFormatters
function M.notify(formatters)
	local lines = { "# Active:" }

	for _, client in ipairs(formatters.active) do
		local line = "- **" .. client.name .. "**"
		if client.name == "null-ls" then
			line = line
				.. " ("
				.. table.concat(
					vim.tbl_map(function(f)
						return "`" .. f.name .. "`"
					end, formatters.null_ls),
					", "
				)
				.. ")"
		end
		table.insert(lines, line)
	end

	if #formatters.available > 0 then
		table.insert(lines, "")
		table.insert(lines, "# Disabled:")
		for _, client in ipairs(formatters.available) do
			table.insert(lines, "- **" .. client.name .. "**")
		end
	end

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, {
		title = "Formatting",
		on_open = function(win)
			vim.api.nvim_win_set_option(win, "conceallevel", 3)
			vim.api.nvim_win_set_option(win, "spell", false)
			local buf = vim.api.nvim_win_get_buf(win)
			vim.treesitter.start(buf, "markdown")
		end,
	})
end

function M.on_attach(client, buf)
	-- dont format if client disabled it
	if
		client.config
		and client.config.capabilities
		and client.config.capabilities.documentFormattingProvider == false
	then
		return
	end

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
			buffer = buf,
			callback = function()
				if M.autoformat then
					M.format()
				end
			end,
		})
	end
end

return M
