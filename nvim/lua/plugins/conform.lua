local get_venv_command = function(command)
	if vim.env.VIRTUAL_ENV then
		return vim.env.VIRTUAL_ENV .. "/bin/" .. command
	else
		return command
	end
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

return {
	"stevearc/conform.nvim",
	opts = {
    formatters = {black = {command = get_venv_command(("black"))}},
		formatters_by_ft = {
			-- Conform will run multiple formatters sequentially
			-- Use a sub-list to run only the first available formatter
			c = { { "clang-format" } },
			cpp = { { "clang-format" } },
			css = { { "prettier" } },
			html = { { "prettier" } },
			javascript = { { "prettier" } },
			json = { { "prettier" } },
			lua = { "stylua" },
			python = { "isort", "black" },
			yaml = { { "yamlfmt" } },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
