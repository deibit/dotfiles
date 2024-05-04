return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},

				keymaps = {
					toggle_server_expand = "<CR>",
					install_server = "i",
					update_server = "u",
					check_server_version = "c",
					update_all_servers = "U",
					check_outdated_servers = "C",
					uninstall_server = "X",
					cancel_installation = "<C-c>",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"pylsp",
				"clangd",
				"dockerls",
				"docker_compose_language_service",
				"gopls",
				"html",
				"jsonls",
				"tsserver",
				"lua_ls",
				"autotools_ls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("lspconfig").pylsp.setup({})
			require("lspconfig").lua_ls.setup({})
			require("lspconfig").clangd.setup({})
			require("lspconfig").dockerls.setup({})
			require("lspconfig").docker_compose_language_service.setup({})
			require("lspconfig").gopls.setup({})
			require("lspconfig").html.setup({})
			require("lspconfig").jsonls.setup({})
			require("lspconfig").autotools_ls.setup({})
		end,
	},
}
