return {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = { style = "moon" },
	},

	-- catppuccin
	-- https://github.com/catppuccin/catppuccin
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		opts = {
			integrations = {
				alpha = true,
				cmp = true,
				flash = true,
				gitsigns = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				lsp_trouble = true,
				mason = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				noice = true,
				notify = true,
				neotree = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		},
	},
	{
		"dracula/vim",
		-- priority = 1000,
		lazy = true,
		-- config = function()
		-- 	vim.cmd.colorscheme("dracula")
		-- end,
	},
	-- 'navarasu/onedark.nvim',
}
