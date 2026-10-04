-- Un editor para editar y ejecutar: sin descargas ni herramientas de lenguaje.
vim.env.NVIM_APPNAME = "nvim-slim"
vim.g.mapleader = ","
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.inccommand = "split"
opt.splitbelow = true
opt.splitright = true
opt.mouse = "a"
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.swapfile = false
opt.synmaxcol = 240
opt.grepprg = "rg --vimgrep --smart-case"
opt.grepformat = "%f:%l:%c:%m"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.statusline = " %f %m%r %= %l:%c %P "
vim.cmd("syntax enable")

local map = vim.keymap.set
local function key(lhs, rhs, desc)
    map("n", lhs, rhs, { silent = true, desc = desc })
end
for _, direction in ipairs({ "h", "j", "k", "l" }) do
    key("<C-" .. direction .. ">", "<C-w>" .. direction, "Cambiar de panel")
end
key("<leader>w", "<cmd>write<cr>", "Guardar")
key('<leader>"', "<cmd>vsplit<cr>", "Split vertical")
key("<leader>%", "<cmd>split<cr>", "Split horizontal")
key("<leader>X", "<C-w>c", "Cerrar panel")
key("<leader>x", "<cmd>bdelete<cr>", "Cerrar búfer")
key("n", "nzzzv", "Siguiente coincidencia")
key("N", "Nzzzv", "Coincidencia anterior")
key("j", "gj", "Bajar línea visual")
key("k", "gk", "Subir línea visual")
key("U", "<C-r>", "Rehacer")
key("[q", "<cmd>cprevious<cr>", "Quickfix anterior")
key("]q", "<cmd>cnext<cr>", "Quickfix siguiente")
key("<leader>q", "<cmd>copen<cr>", "Abrir quickfix")
key("<leader>P", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
end, "Copiar ruta absoluta")
key("<leader>C", '<cmd>%yank +<cr>', "Copiar contenido")
map("i", "jj", "<Esc>", { desc = "Salir de inserción" })
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Salir del modo terminal" })
vim.api.nvim_create_user_command("Term", "botright vsplit | terminal", {})
key("<leader>T", "<cmd>Term<cr>", "Abrir terminal")

local group = vim.api.nvim_create_augroup("DotfilesSlim", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function() vim.opt_local.formatoptions:remove({ "c", "r", "o" }) end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function(args)
        local line = vim.api.nvim_buf_get_mark(args.buf, '"')[1]
        if line > 0 and line <= vim.api.nvim_buf_line_count(args.buf) then
            pcall(vim.api.nvim_win_set_cursor, 0, { line, 0 })
        end
        -- Logs y volcados: evitar resaltado costoso en archivos grandes.
        local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(args.buf))
        if size > 2 * 1024 * 1024 then
            vim.bo[args.buf].syntax = "OFF"
            vim.bo[args.buf].undofile = false
        end
    end,
})
vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.cmd("startinsert")
    end,
})

-- Ruta aislada incluso si se abre la configuración slim con `nvim` directamente.
local plugin = vim.fn.stdpath("data") .. "/site/pack/dotfiles/start/mini.nvim"
if vim.fn.isdirectory(plugin) == 1 then
    vim.opt.rtp:prepend(plugin)
    -- Preview acotada con sintaxis tradicional; no consulta Tree-sitter.
    require("mini.pick").setup({ source = { preview = function(buf, item)
        local path, line, source_buf
        if type(item) == "table" then
            path, line, source_buf = item.path, item.lnum, item.bufnr
        elseif type(item) == "string" then
            local parts = vim.split(item, "\0", { plain = true })
            path, line = parts[1], tonumber(parts[2])
        end
        line = line or 1
        local lines
        if source_buf and vim.api.nvim_buf_is_loaded(source_buf) then
            path = vim.api.nvim_buf_get_name(source_buf)
            lines = vim.api.nvim_buf_get_lines(source_buf, 0, math.min(line + 100, vim.api.nvim_buf_line_count(source_buf)), false)
        elseif path and vim.fn.filereadable(path) == 1 then
            if vim.fn.getfsize(path) > 2 * 1024 * 1024 then
                lines = { "Archivo grande: abre el archivo para consultarlo." }
                line = 1
            else
                lines = vim.fn.readfile(path, "", line + 100)
            end
        end
        lines = lines or { path or vim.inspect(item) }
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        local ft = path and vim.filetype.match({ filename = path })
        vim.bo[buf].syntax = ft or ""
        local win = vim.fn.bufwinid(buf)
        if win ~= -1 then
            vim.api.nvim_win_set_cursor(win, { math.min(line, math.max(#lines, 1)), 0 })
        end
    end } })
    require("mini.files").setup()
    require("mini.surround").setup()
    require("mini.align").setup()
    require("mini.ai").setup()
    key("<leader>f", function() MiniPick.builtin.files() end, "Buscar archivos")
    key("<leader>F", function()
        MiniPick.start({ source = { name = "Recientes", items = vim.v.oldfiles } })
    end, "Archivos recientes")
    key("<space>", function() MiniPick.builtin.buffers() end, "Buscar búferes")
    key("<leader>S", function() MiniPick.builtin.grep_live() end, "Buscar texto")
    key("<leader>sw", function()
        MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
    end, "Buscar palabra")
    key("<leader>e", function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" or not (vim.uv or vim.loop).fs_stat(path) then
            local parent = path ~= "" and vim.fn.fnamemodify(path, ":h") or vim.fn.getcwd()
            path = vim.fn.isdirectory(parent) == 1 and parent or vim.fn.getcwd()
        end
        MiniFiles.open(path, false)
    end, "Explorar archivos")
else
    -- --link-only sigue ofreciendo un editor utilizable sin descargar plugins.
    key("<leader>e", "<cmd>Explore<cr>", "Explorar archivos (netrw)")
    key("<space>", "<cmd>buffers<cr>", "Listar búferes")
    vim.schedule(function()
        vim.notify("Mini no está instalado. Ejecuta install.sh --slim o --fat para preparar búsqueda y edición.", vim.log.levels.WARN)
    end)
end
