vim.g.mapleader = ","

-- Package manager
vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Move through panes
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>l", { noremap = true })
-- Alternate keys
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- Fast saving
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Write buffer to file" })

-- Splits and Buffers
vim.api.nvim_set_keymap("n", '<leader>"', ":vsplit<CR>", { noremap = true, silent = true, desc = "Vertical split" })
vim.api.nvim_set_keymap("n", "<leader>%", ":split<CR>", { noremap = true, silent = true, desc = "Horizontal split" })
vim.api.nvim_set_keymap("n", "<leader>X", "<C-w>c", { noremap = true, silent = true, desc = "Close pane" })

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
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "fast escape / write" })

-- Fast search / and ?
vim.api.nvim_set_keymap("n", "<space>", "/", { noremap = true, silent = true, desc = "fast /" })

-- Redo with 'U'
vim.api.nvim_set_keymap("n", "U", "<C-r>", { noremap = true, silent = true, desc = "redo" })

-- LSP
-- vim.api.nvim_set_keymap(
--     "n",
--     "gd",
--     "",
--     { callback = vim.lsp.buf.definition, noremap = true, silent = true, desc = "Goto definition" }
-- )

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

-- Delete buffer and paste clipboard
vim.api.nvim_set_keymap(
    "n",
    "<leader>B",
    "<cmd>1,$d | 0put +<cr>",
    { noremap = true, silent = true, desc = "Delete buffer and paste clipboard" }
)

-- Delete inside "<content>" and replace it with the clipboard
vim.api.nvim_set_keymap(
    "n",
    '<leader>r"',
    '"_di"P',
    { noremap = true, silent = true, desc = 'Replace "<txt>" with clipboard' }
)

-- Space as /, Space as #
vim.api.nvim_set_keymap("n", "<space>", "/", { noremap = true, silent = true, desc = "<space> as /" })
vim.api.nvim_set_keymap("n", "<C-space>", "?", { noremap = true, silent = true, desc = "C-<space> as #" })

-- Better QuickFix navigation
vim.api.nvim_set_keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true, desc = "QF prev" })
vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true, desc = "QF next" })

-- Open symbol definition on a split
local function open_definition_on_split(split_type)
    vim.cmd(split_type)
    vim.lsp.buf.definition()
end

vim.keymap.set("n", "gv", function()
    open_definition_on_split("vsplit")
end, { desc = "Definición en split vertical" })
vim.keymap.set("n", "gs", function()
    open_definition_on_split("split")
end, { desc = "Definición en split horizontal" })

