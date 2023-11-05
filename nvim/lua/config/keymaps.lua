-- MAPPINGS

-- vim.cmd('noremap <C-b> :noh<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

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

-- PLUGINS AREA!!!

-- Telescope
local builtin = require("telescope.builtin")
local telescope_ext = require("telescope").extensions

-- local only_document_diagnostic = function()
-- 	return function()
-- 		builtin.diagnostics({ bufnr = 0 })
-- 	end
-- end

-- Finders
vim.keymap.set("n", "<leader>*", builtin.grep_string, { desc = "Telescope grep under cursor" })
vim.keymap.set("n", "<leader>e", builtin.registers, { desc = "Telescope registers" })
vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope ls" })
vim.keymap.set("n", "<leader>r", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set(
	"n",
	"<leader><leader>",
	builtin.current_buffer_fuzzy_find,
	{ desc = "Telescope fuzzy find current buffer" }
)
vim.keymap.set("n", "<leader>F", telescope_ext.file_browser.file_browser, { desc = "Telescope file broser" })

-- Pickers
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>c", builtin.commands, { desc = "Telescope commands" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>k", builtin.man_pages, { desc = "Telescope man pages" })
vim.keymap.set("n", "<leader>m", builtin.keymaps, { desc = "Telescope keymaps" })
vim.keymap.set("n", "<leader>o", builtin.oldfiles, { desc = "Telescope old files" })
-- LSP and symbols related keymaps
vim.keymap.set("n", "<leader>sa", builtin.diagnostics, { desc = "Telescope diagnostic" })
vim.keymap.set("n", "<leader>sc", builtin.lsp_incoming_calls, { desc = "Telescope lsp incoming calls" })
vim.keymap.set("n", "<leader>sd", builtin.lsp_definitions, { desc = "Telescope lsp definitions" })
vim.keymap.set("n", "<leader>si", builtin.lsp_implementations, { desc = "Telescope lsp implementations" })
vim.keymap.set("n", "<leader>so", builtin.lsp_outgoing_calls, { desc = "Telescope lsp outgoing calls" })
vim.keymap.set("n", "<leader>sr", builtin.treesitter, { desc = "Telescope treesitter" })
vim.keymap.set("n", "<leader>st", builtin.lsp_type_definitions, { desc = "Telescope lsp type definitions" })
vim.keymap.set("n", "<leader>sx", builtin.lsp_references, { desc = "Telescope lsp references" })
vim.keymap.set("n", "<leader>sw", builtin.lsp_workspace_symbols, { desc = "Telescope lsp workspace symbols" })
vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "Telescope lsp document symbols" })
-- vim.keymap.set("n", "<leader>xx", only_document_diagnostic(), { desc = "Telescope diagnostic (current buffer)" })
-- Git related keymaps
vim.keymap.set("n", "<leader>gt", builtin.git_stash, { desc = "Telescope git stash" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git branches" })
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Telescope git commits" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope git ls files" })
vim.keymap.set("n", "<leader>go", builtin.git_bcommits, { desc = "Telescope git buffer commits" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope git status" })

-- Trouble
vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>", {})
vim.keymap.set("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", {})
vim.keymap.set("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", {})
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble loclist<cr>", {})
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", {})
vim.keymap.set("n", "<leader>tr", "<cmd>Trouble lsp_references<cr>", {})

-- BufDelete
vim.keymap.set("n", "<leader>d", "<cmd>Bdelete<cr>", { desc = "bufdelete" })

-- SymbolsOutline
vim.keymap.set("n", "<leader>2", "<cmd>SymbolsOutline<cr>", { desc = "Toggle symbols outline window" })

-- Nvim-tree
vim.keymap.set("n", "<leader>1", "<cmd>Neotree toggle<cr>", { desc = "Toogle Neotree" })

-- ToogleTerm
vim.keymap.set("n", "<leader>l", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Lazygit", noremap = true, silent = true })
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { desc = "ToogleTerm", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"<leader>T",
	"<cmd>ToggleTerm direction=float size=80<CR>",
	{ desc = "ToggleTerm float", noremap = true, silent = true }
)

-- Neogit
vim.keymap.set("n", "<leader>n", "<cmd>Neogit<CR>", { desc = "Neogit" })
