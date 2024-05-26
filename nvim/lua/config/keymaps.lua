local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ","

-- Fast saving
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", default_opts)

-- Splits and Buffers
vim.api.nvim_set_keymap("n", '<leader>"', ":vsplit<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<leader>%", ":split<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<leader>X", "<C-w>c", default_opts)
vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>lua MiniBufremove.delete()<CR>", default_opts)

-- Keep search matches in the middle of the window
vim.api.nvim_set_keymap("n", "n", "nzzzv", default_opts)
vim.api.nvim_set_keymap("n", "N", "Nzzzv", default_opts)
vim.api.nvim_set_keymap("n", "g;", "g;zz", default_opts)

-- Move between wrapped lines
vim.api.nvim_set_keymap("n", "j", "gj", default_opts)
vim.api.nvim_set_keymap("n", "k", "gk", default_opts)
vim.api.nvim_set_keymap("v", "j", "gj", default_opts)
vim.api.nvim_set_keymap("v", "k", "gk", default_opts)

-- Reselect visual block after indent/outdent
vim.api.nvim_set_keymap("v", "<", "<gv", default_opts)
vim.api.nvim_set_keymap("v", ">", ">gv", default_opts)

-- In command mode, let home/end of line work
vim.api.nvim_set_keymap("c", "<C-a>", "<Home>", default_opts)
vim.api.nvim_set_keymap("c", "<C-e>", "<End>", default_opts)

-- Disable command line history
vim.api.nvim_set_keymap("n", "Q", "<Nop>", default_opts)
vim.api.nvim_set_keymap("n", "q:", "<Nop>", default_opts)

-- Emulate windows copy/cut
vim.api.nvim_set_keymap("v", "<LeftRelease>", '"+y<LeftRelease"', default_opts)
vim.api.nvim_set_keymap("v", "<C-c>", '"+y<CR>', default_opts)
vim.api.nvim_set_keymap("v", "<C-x>", '"+d<CR>', default_opts)
vim.api.nvim_set_keymap("n", "<leader>p", "o<Esc>p", default_opts)
vim.api.nvim_set_keymap("n", "<leader>P", "O<Esc>p", default_opts)

-- Fast escape
vim.api.nvim_set_keymap("i", "jk", "<Esc>", default_opts)

-- Fast search / and ?
vim.api.nvim_set_keymap("n", "<space>", "/", default_opts)

-- Redo with 'U'
vim.api.nvim_set_keymap("n", "U", "<C-r>", default_opts)

-- DiffView
vim.api.nvim_set_keymap("n", "<leader>i", "<cmd>DiffviewOpen<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<leader>I", "<cmd>DiffviewClose<CR>", default_opts)

-- Format entire buffer
vim.api.nvim_set_keymap("n", "<Leader>gj", "ggvGgq", default_opts)

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set({ "n", "v" }, "<leader>d", vim.lsp.buf.definition)
