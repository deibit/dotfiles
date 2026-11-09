local M = {}

local modes = {
    n = "%#DiagnosticOk#NORMAL%*",
    i = "%#DiagnosticError#INSERT%*",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",
    R = "REPLACE",
    c = "COMMAND",
    t = "TERMINAL",
}

function M.mode()
    local mode = vim.fn.mode()
    return modes[mode] or mode
end

vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.statusline = " %{%v:lua.require'config.statusline'.mode()%}  %<%f%( %m%r%h%w%)%=%l:%c  %P "

return M
