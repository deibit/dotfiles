-- 2 spaces for selected filetypes
vim.cmd([[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
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
