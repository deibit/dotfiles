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
