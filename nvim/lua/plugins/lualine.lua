-- Bubbles config for lualine
-- Author: lokesh-krishna (modified by deibit)
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  black  = '#080808',
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  grey   = '#303030',
  lgrey  = '#bbbbbb',
  orange = '#fc5501',
  red    = '#f70213',
  violet = '#d183e8',
  white  = '#c6c6c6',
  bwhite  = '#ffffff',
  yellow = '#edfc01',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.bwhite, bg = colors.blue },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.white, bg = colors.grey },
	},

	insert = { a = { fg = colors.bwhite, bg = colors.red } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.blue } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white, bg = colors.black },
	},
}

local ts = require("nvim-treesitter")
local loc = function()
	local r = ts.statusline()
	if r then
		return r
	else
		return ""
	end
end

require("lualine").setup({
	options = {
		theme = bubbles_theme,
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = {
			{ "mode", right_padding = 2 },
		},
		lualine_b = { { "branch", color = { fg = colors.orange } }, { "diff" } },
		lualine_c = {
			{ "filename", path = 1 },
			{ loc, color = { fg = colors.violet } },
		},
		lualine_x = {
			{
				"diagnostics",

				-- Table of diagnostic sources, available sources are:
				--   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
				-- or a function that returns a table as such:
				--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
				sources = { "nvim_diagnostic" },
				-- Displays diagnostics for the defined severity types
				sections = { "error", "warn", "info", "hint" },

				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = { fg = colors.red, bg = colors.grey }, -- Changes diagnostics' error color.
					warn = { fg = colors.orange, bg = colors.grey }, -- Changes diagnostics' warn color.
					info = { fg = colors.blue, bg = colors.grey }, -- Changes diagnostics' info color.
					hint = { fg = colors.yellow, bg = colors.grey }, -- Changes diagnostics' hint color.
				},
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
				colored = true, -- Displays diagnostics status in color if set to true.
				update_in_insert = false, -- Update diagnostics in insert mode.
				always_visible = false, -- Show diagnostics even if there are none.
			},
		},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{
				"location",
				left_padding = 2,
			},
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {
		"fzf",
		"nvim-tree",
		"symbols-outline",
	},
})
