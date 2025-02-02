vim.g.mapleader = ","

-- Fast saving
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Write buffer to file" })

-- Splits and Buffers
vim.api.nvim_set_keymap("n", '<leader>"', ":vsplit<CR>", { noremap = true, silent = true, desc = "Vertical split" })
vim.api.nvim_set_keymap("n", "<leader>%", ":split<CR>", { noremap = true, silent = true, desc = "Horizontal split" })
vim.api.nvim_set_keymap("n", "<leader>X", "<C-w>c", { noremap = true, silent = true, desc = "Close pane" })
vim.api.nvim_set_keymap(
    "n",
    "<leader>x",
    "<cmd>lua Snacks.bufdelete()<CR>",
    { noremap = true, silent = true, desc = "Remove buffer" }
)

-- Keep search matches in the middle of the window
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Keep match in the middle" })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Keep match in the middle" })
vim.api.nvim_set_keymap("n", "g;", "g;zz", { noremap = true, silent = true, desc = "Keep match in the middle" })

-- Move between wrapped lines
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true, desc = "Move between wrapped lines" })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true, desc = "Move between wrapped lines" })
vim.api.nvim_set_keymap("v", "j", "gj", { noremap = true, silent = true, desc = "Move between wrapped lines" })
vim.api.nvim_set_keymap("v", "k", "gk", { noremap = true, silent = true, desc = "Move between wrapped lines" })

-- Reselect visual block after indent/outdent
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true, desc = "Move visual selection to <-" })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true, desc = "Move visual selection to ->" })

-- In command mode, let home/end of line work
vim.api.nvim_set_keymap("c", "<C-a>", "<Home>", { noremap = true, silent = true, desc = "c-mode move to home" })
vim.api.nvim_set_keymap("c", "<C-e>", "<End>", { noremap = true, silent = true, desc = "c-mode move to end" })

-- Disable command line history
vim.api.nvim_set_keymap("n", "Q", "<Nop>", { noremap = true, silent = true, desc = "Q-nopped" })
vim.api.nvim_set_keymap("n", "q:", "<Nop>", { noremap = true, silent = true, desc = "q:-nopped" })

-- Emulate windows copy/cut
vim.api.nvim_set_keymap(
    "v",
    "<LeftRelease>",
    '"+y<LeftRelease"',
    { noremap = true, silent = true, desc = "clipboard ala Windows" }
)
vim.api.nvim_set_keymap("v", "<C-c>", '"+y<CR>', { noremap = true, silent = true, desc = "copy to clipboard" })
vim.api.nvim_set_keymap("v", "<C-x>", '"+d<CR>', { noremap = true, silent = true, desc = "cut to clipboard" })
vim.api.nvim_set_keymap("n", "<leader>p", "o<Esc>p", { noremap = true, silent = true, desc = "paste from clipboard" })

-- Fast escape
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "fast escape" })

-- Fast search / and ?
vim.api.nvim_set_keymap("n", "<space>", "/", { noremap = true, silent = true, desc = "fast /" })

-- Redo with 'U'
vim.api.nvim_set_keymap("n", "U", "<C-r>", { noremap = true, silent = true, desc = "redo" })

-- Format entire buffer
vim.api.nvim_set_keymap(
    "n",
    "<Leader>gj",
    "ggvGgq",
    { noremap = true, silent = true, desc = "Format the entire buffer" }
)

-- LSP
vim.api.nvim_set_keymap(
    "n",
    "<leader>ca",
    "",
    { callback = vim.lsp.buf.code_action, noremap = true, silent = true, desc = "Code action" }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>d",
    "",
    { callback = vim.lsp.buf.definition, noremap = true, silent = true, desc = "go to definition" }
)

-- Copy filepath to clipboard
vim.api.nvim_set_keymap(
    "n",
    "<leader>P",
    "<cmd>CopyAbsPath<cr>",
    { noremap = true, silent = true, desc = "Copy absolute filepath to clipboard" }
)

-- Copy buffer to clipboard
vim.api.nvim_set_keymap(
    "n",
    "<leader>C",
    "<cmd>%y*<cr>",
    { noremap = true, silent = true, desc = "Copy buffer to clipboard" }
)
