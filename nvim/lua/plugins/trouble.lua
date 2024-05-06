return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			signs = {
				-- icons / text used for a diagnostic
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "",
			},
		})
	end,
	branch = "dev",
	lazy = false,
	keys = {
		{ "<leader>t", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>" },
	},
}
