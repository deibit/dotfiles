local WorkDir = {
	provider = function()
		local conditions = require("heirline.conditions")
		local cwd = vim.fn.getcwd(0)
		cwd = vim.fn.fnamemodify(cwd, ":~")
		if not conditions.width_percent_below(#cwd, 0.25) then
			cwd = vim.fn.pathshorten(cwd)
		end
		local trail = cwd:sub(-1) == "/" and "" or "/"
		return cwd .. trail
	end,
	hl = { bold = true },
}

return {
	"rebelot/heirline.nvim",
	dependencies = { "Zeioth/heirline-components.nvim" },
	opts = function()
		local lib = require("heirline-components.all")
		return {
			opts = {
				disable_winbar_cb = function(args) -- We do this to avoid showing it on the greeter.
					local is_disabled = not require("heirline-components.buffer").is_valid(args.buf)
						or lib.condition.buffer_matches({
							buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
							filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
						}, args.buf)
					return is_disabled
				end,
			},
			statuscolumn = { -- UI left column
				init = function(self)
					self.bufnr = vim.api.nvim_get_current_buf()
				end,
				lib.component.foldcolumn(),
				lib.component.numbercolumn(),
				lib.component.signcolumn(),
			} or nil,
			statusline = { -- UI statusbar
				hl = { fg = "fg", bg = "bg" },
				lib.component.mode(),
				lib.component.git_branch(),
				lib.component.file_info({ filename = false, filetype = false }),
				WorkDir,
				lib.component.git_diff(),
				lib.component.diagnostics(),
				lib.component.fill(),
				lib.component.cmd_info(),
				lib.component.fill(),
				lib.component.lsp(),
				lib.component.compiler_state(),
				lib.component.virtual_env(),
				lib.component.nav(),
			},
		}
	end,
	config = function(_, opts)
		local heirline = require("heirline")
		local heirline_components = require("heirline-components.all")

		-- Setup
		heirline_components.init.subscribe_to_events()
		heirline.load_colors(heirline_components.hl.get_colors())
		heirline.setup(opts)
	end,
}
