vim.api.nvim_create_autocmd("FileType", {
	pattern = { "hcl", "terraform" },
	desc = "terraform/hcl commentstring configuration",
	command = "setlocal commentstring=#\\ %s",
})

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, {
					"terraform",
					"hcl",
				})
			end
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				terraformls = {},
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			if type(opts.sources) == "table" then
				local null_ls = require("null-ls")
				vim.list_extend(opts.sources, {
					null_ls.builtins.formatting.terraform_fmt,
					null_ls.builtins.diagnostics.terraform_validate,
				})
			end
		end,
	},
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				cmake = { "cmakelint" },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
			},
		},
	},
}
