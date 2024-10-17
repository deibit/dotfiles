-- OPTIONS

local cmd = vim.cmd
local api = vim.api
local g = vim.g
local opt = vim.opt

g.mapleader = ","

opt.autoindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu,menuone,noselect" }
opt.cursorline = true
opt.expandtab = true
opt.emoji = true
opt.foldmethod = "marker"
opt.hidden = true
opt.history = 1000
opt.hlsearch = false
opt.ignorecase = true
opt.lazyredraw = true
opt.linebreak = true
opt.mouse = "a"
opt.number = true
opt.shiftwidth = 2
opt.shortmess:append("sI")
opt.showmatch = true
opt.showcmd = false
opt.smarttab = true
opt.smartcase = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.synmaxcol = 240
opt.tabstop = 4
opt.title = true
opt.termguicolors = true
opt.undofile = true

-- g.python3_host_prog = os.getenv("PYENV_ROOT") .. "/versions/pynvim/bin/python"

-- Do not automcomment new lines
api.nvim_create_autocmd("FileType", {
    command = "setlocal formatoptions-=cro",
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
    end,
})

-- lint
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

-- 2 spaces for selected filetypes
cmd([[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]])
-- open a terminal pane on the right using :Term
cmd([[command Term :botright vsplit term://$SHELL]])
-- Terminal visual tweaks
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
cmd([[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]])

-- disable builtins plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

g.go_template_autocreate = 0

-- Set width in python, markdown
vim.cmd([[autocmd BufRead,BufNewFile *.md setlocal textwidth=80]])
vim.cmd([[autocmd BufRead,BufNewFile *.py setlocal textwidth=80]])

-- For 'tiny-inline-diagnostic'
vim.diagnostic.config({ virtual_text = false })
