return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"nvim-telescope/telescope.nvim", -- optional
		"sindrets/diffview.nvim", -- optional
	},
	config = true,
	keys = {
		{ "<leader>n", "<cmd>Neogit<cr>", desc = "Neogit" },
	},
}
