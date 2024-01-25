require("neodev").setup({})
require("mason").setup()
require("mason-lspconfig").setup()
local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local lsp_flags = {
	debounce_text_changes = 150,
}

-- nvim_lsp.sourcekit.setup({ on_attach = on_attach, flags = lsp_flags })

nvim_lsp.pyright.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

nvim_lsp.clangd.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

nvim_lsp.gopls.setup({
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

nvim_lsp.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

nvim_lsp.gdscript.setup({ on_attach = on_attach, flags = lsp_flags })
