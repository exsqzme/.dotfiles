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
