-- OPTIONS
vim.g.mapleader = ","

vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu,menuone,noselect" }
vim.opt.cursorline = true
vim.opt.emoji = true
vim.opt.expandtab = true
vim.opt.foldmethod = "marker"
vim.opt.grepprg = "rg --vimgrep --smart-case --follow"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.hidden = true
vim.opt.history = 1000
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("sI")
vim.opt.showcmd = false
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.statuscolumn = ""
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.synmaxcol = 240
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.undofile = true
vim.opt.wrap = true

vim.wo.relativenumber = true

-- disable builtins plugins
local disabled_built_ins = {
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
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
    vim.g["loaded_" .. plugin] = 1
end

-- Diagnostics
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
        },
    },
})

vim.cmd([[
  highlight DiagnosticUnderlineError gui=undercurl guisp=Red guibg=NONE
  highlight DiagnosticUnderlineWarn  gui=undercurl guisp=Orange guibg=NONE
  highlight DiagnosticUnderlineInfo  gui=undercurl guisp=LightBlue guibg=NONE
  highlight DiagnosticUnderlineHint  gui=undercurl guisp=Gray guibg=NONE
  highlight SignColumn guibg=NONE
]])

-- New UI (no more "Press Enter", from: https://jdhao.github.io/2026/04/02/nvim-v012-release/)
require("vim._core.ui2").enable({
    enable = true,
    msg = { -- Options related to the message module.
        ---@type 'cmd'|'msg' Default message target, either in the
        ---cmdline or in a separate ephemeral message window.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        ---or table mapping |ui-messages| kinds and triggers to a target.
        targets = "cmd",
        cmd = { -- Options related to messages in the cmdline window.
            height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
        },
        dialog = { -- Options related to dialog window.
            height = 0.5, -- Maximum height.
        },
        msg = { -- Options related to msg window.
            height = 0.5, -- Maximum height.
            timeout = 4000, -- Time a message is visible in the message window.
        },
        pager = { -- Options related to message window.
            height = 0.5, -- Maximum height.
        },
    },
})
