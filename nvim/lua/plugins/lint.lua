require("lint").linters_by_ft = {
	markdown = { "vale" },
	python = { "pylint" },
	c = { "clangtidy", "cppcheck" },
	cpp = { "clangtidy", "cppcheck" },
	javascript = { "eslint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
