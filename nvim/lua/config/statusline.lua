local M = {}

local modes = {
    n = "%#DiagnosticOk#NORMAL%*",
    i = "%#DiagnosticError#INSERT%*",
    v = "VISUAL",
    V = "VISUAL LÍNEA",
    ["\22"] = "VISUAL BLOQUE",
    s = "SELECCIÓN",
    S = "SELECCIÓN LÍNEA",
    ["\19"] = "SELECCIÓN BLOQUE",
    R = "REEMPLAZAR",
    c = "COMANDO",
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
