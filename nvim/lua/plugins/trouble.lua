local function _next_trouble()
	local trouble = require("trouble")
	trouble.next({ skip_groups = true, jump = true })
end

local function _previous_trouble()
	local trouble = require("trouble")
	trouble.previous({ skip_groups = true, jump = true })
end

local function _first_trouble()
	local trouble = require("trouble")
	trouble.first({ skip_groups = true, jump = true })
end

local function _last_trouble()
	local trouble = require("trouble")
	trouble.last({ skip_groups = true, jump = true })
end

local function _close_trouble()
	local trouble = require("trouble")
	trouble.close()
end

local function _open_trouble()
	local trouble = require("trouble")
	trouble.open()
end

return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			signs = {
				-- icons / text used for a diagnostic
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "",
			},
			-- use_lsp_diagnostic_signs = false,
		})
	end,
	lazy = false,
	keys = {
		{ "<leader>tc", _close_trouble, desc = "close trouble" },
		{ "<leader>td", "<cmd>Trouble document_diagnostics<cr>" },
		{ "<leader>tf", _first_trouble, desc = "first trouble" },
		{ "<leader>tl", "<cmd>Trouble loclist<cr>" },
		{ "<leader>tl", _last_trouble, desc = "last trouble" },
		{ "<leader>tn", _next_trouble, desc = "next trouble" },
		{ "<leader>to", _open_trouble, desc = "open trouble" },
		{ "<leader>tp", _previous_trouble, desc = "previous trouble" },
		{ "<leader>tq", "<cmd>Trouble quickfix<cr>" },
		{ "<leader>tr", "<cmd>Trouble lsp_references<cr>" },
		{ "<leader>tt", "<cmd>TroubleToggle<cr>" },
		{ "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>" },
	},
}

-- toggle trouble with optional mode
-- require("trouble").toggle(mode?)

-- open trouble with optional mode
-- require("trouble").open(mode?)

-- close trouble
-- require("trouble").close()

-- jump to the next item, skipping the groups
-- require("trouble").next({skip_groups = true, jump = true});

-- jump to the previous item, skipping the groups
-- require("trouble").previous({skip_groups = true, jump = true});

-- jump to the first item, skipping the groups
-- require("trouble").first({skip_groups = true, jump = true});

-- jump to the last item, skipping the groups
-- require("trouble").last({skip_groups = true, jump = true});
