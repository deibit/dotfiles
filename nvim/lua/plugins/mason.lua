return {
	"williamboman/mason.nvim",
	config = function()
		local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
		if not vim.loop.fs_stat(lazypath) then
			vim.fn.system({
				"git",
				"clone",
				"--filter=blob:none",
				"https://github.com/folke/lazy.nvim.git",
				"--branch=stable", -- latest stable release
				lazypath,
			})
		end
		vim.opt.rtp:prepend(lazypath)

		-- Lazy configuration
		require("lazy").setup({
			{ import = "plugs" },
			{ "kylechui/nvim-surround", config = true },
			{ "tpope/vim-obsession" },
			{ "kyazdani42/nvim-web-devicons", config = true },
			{
				"lukas-reineke/indent-blankline.nvim",
				main = "ibl",
				opts = {},
			},
			{
				"windwp/nvim-autopairs",
				config = true,
			},
			{
				"numToStr/Comment.nvim",
				config = true,
			},
			{
				"lewis6991/gitsigns.nvim",
				config = true,
			},
			{
				"chentoast/marks.nvim",
				config = true,
			},
		})
	end,
}
