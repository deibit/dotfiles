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
				local file_ext = vim.fn.expand("%:e")
				if file_ext == "py" then
					lint.try_lint("pylint")
				elseif file_ext == "md" then
					lint.try_lint("vale")
				elseif file_ext == "c" or file_ext == "cpp" or file_ext == "h" then
					lint.try_lint("clangtidy")
				elseif file_ext == "js" then
					lint.try_lint("eslint")
				else
					lint.try_lint()
				end
			end,
		})
	end,
}
