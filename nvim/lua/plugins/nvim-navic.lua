local colors = require("catppuccin.palettes.macchiato")

return {
	"SmiteshP/nvim-navic",
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		require("nvim-navic").setup({
			icons = {
				File = "󰈙 ",
				Module = " ",
				Namespace = "󰌗 ",
				Package = " ",
				Class = "󰌗 ",
				Method = "󰆧 ",
				Property = " ",
				Field = " ",
				Constructor = " ",
				Enum = "󰕘",
				Interface = "󰕘",
				Function = "󰊕 ",
				Variable = "󰆧 ",
				Constant = "󰏿 ",
				String = "󰀬 ",
				Number = "󰎠 ",
				Boolean = "◩ ",
				Array = "󰅪 ",
				Object = "󰅩 ",
				Key = "󰌋 ",
				Null = "󰟢 ",
				EnumMember = " ",
				Struct = "󰌗 ",
				Event = " ",
				Operator = "󰆕 ",
				TypeParameter = "󰊄 ",
			},
			lsp = {
				auto_attach = true,
				preference = nil,
			},
			highlight = false,
			separator = " > ",
			depth_limit = 0,
			depth_limit_indicator = "..",
			safe_output = true,
			lazy_update_context = false,
			click = false,
			format_text = function(text)
				return text
			end,
			vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = colors.green }),
			vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = colors.yellow }),
			vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = colors.green }),
		})
	end,
}
