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
			-- use_lsp_diagnostic_signs = false,
		})
	end,
	lazy = false,
	keys = {
		{ "<leader>tt", "<cmd>TroubleToggle<cr>" },
		{ "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>" },
		{ "<leader>td", "<cmd>Trouble document_diagnostics<cr>" },
		{ "<leader>tl", "<cmd>Trouble loclist<cr>" },
		{ "<leader>tq", "<cmd>Trouble quickfix<cr>" },
		{ "<leader>tr", "<cmd>Trouble lsp_references<cr>" },
	},
}
