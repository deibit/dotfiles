-- Do not autocomment new lines
vim.api.nvim_create_autocmd("FileType", {
    command = "setlocal formatoptions-=cro",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
    end,
})

-- 2 spaces for selected filetypes
vim.cmd([[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]])

-- open a terminal pane on the right using :Term
vim.cmd([[command Term :botright vsplit term://$SHELL]])
-- Terminal visual tweaks
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
vim.cmd([[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]])

-- Set width in python, markdown
vim.cmd([[autocmd BufRead,BufNewFile *.md setlocal textwidth=80]])
vim.cmd([[autocmd BufRead,BufNewFile *.py setlocal textwidth=80]])

-- Copy filepath to clipboard
vim.api.nvim_create_user_command("CopyAbsPath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
