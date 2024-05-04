return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			markdown = { "vale" },
			python = { "pylint" },
			c = { "clangtidy", "cppcheck" },
			cpp = { "clangtidy", "cppcheck" },
			javascript = { "eslint" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),

			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
