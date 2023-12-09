return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"dart",
			})
		end,
	},
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = {
	-- 		servers = {
	-- 			dartls = {},
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"akinsho/flutter-tools.nvim",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"stevearc/dressing.nvim", -- optional for vim.ui.select
	-- 	},
	-- 	config = function()
	-- 		require("flutter-tools").setup({})
	-- 	end,
	-- },
}
