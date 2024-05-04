return {
	"mfussenegger/nvim-lint",
	config = function()
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			pattern = { "*.c", "*.h", "*.py", "*.md", "*.js", "*.html", "*.css" },
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
	opts = {
		linters_by_ft = {
			markdown = { "vale" },
			python = { "pylint" },
			c = { "clangtidy", "cppcheck" },
			cpp = { "clangtidy", "cppcheck" },
			javascript = { "eslint" },
		},
	},
}
