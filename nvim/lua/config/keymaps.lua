local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ","

-- Fast saving
map("n", "<leader>w", ":w<CR>", default_opts)

-- Splits
map("n", '<leader>"', ":vsplit<CR>", default_opts)
map("n", "<leader>%", ":split<CR>", default_opts)
map("n", "<leader>x", "<C-w>c", default_opts)

-- Keep search matches in the middle of the window
map("n", "n", "nzzzv", default_opts)
map("n", "N", "Nzzzv", default_opts)
map("n", "g;", "g;zz", default_opts)

-- Move between wrapped lines
map("n", "j", "gj", default_opts)
map("n", "k", "gk", default_opts)
map("v", "j", "gj", default_opts)
map("v", "k", "gk", default_opts)

-- Reselect visual block after indent/outdent
map("v", "<", "<gv", default_opts)
map("v", ">", ">gv", default_opts)

-- In command mode, let home/end of line work
map("c", "<C-a>", "<Home>", default_opts)
map("c", "<C-e>", "<End>", default_opts)

-- Nops
map("n", "Q", "<Nop>", default_opts)

-- Emulate windows copy/cut
map("v", "<LeftRelease>", '"+y<LeftRelease"', default_opts)
map("v", "<C-c>", '"+y<CR>', default_opts)
map("v", "<C-x>", '"+d<CR>', default_opts)
map("n", "<leader>p", "o<Esc>p", default_opts)
map("n", "<leader>P", "O<Esc>p", default_opts)

-- Fast escape
map("i", "jk", "<Esc>", default_opts)

-- Fast search / and ?
map("n", "<space>", "/", default_opts)

-- Redo with 'U'
map("n", "U", "<C-r>", default_opts)

-- Completion
vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

local keys = {
	["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
	["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
	["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
}

_G.cr_action = function()
	if vim.fn.pumvisible() ~= 0 then
		-- If popup is visible, confirm selected item or add new line otherwise
		local item_selected = vim.fn.complete_info()["selected"] ~= -1
		return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
	else
		-- If popup is not visible, use plain `<CR>`. You might want to customize
		-- according to other plugins. For example, to use 'mini.pairs', replace
		-- next line with `return require('mini.pairs').cr()`
		return keys["cr"]
	end
end

vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
