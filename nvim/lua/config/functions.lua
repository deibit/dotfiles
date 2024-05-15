-- Search in google word under cursor (pending visual selection)
vim.api.nvim_set_keymap("n", "<Leader>sg", ":lua SearchGoogle()<CR>", { noremap = true, silent = true })

function SearchGoogle()
    local word = vim.fn.expand("<cword>")
    local google_search_url = '"https://www.google.com/search?q=' .. vim.fn.escape(word, "&") .. '"'
    if vim.fn.has("mac") then
        vim.cmd("silent !open " .. google_search_url)
    elseif vim.fn.has("unix") then
        vim.cmd("silent !xdg-open " .. google_search_url)
    else
        print("Cannot open a browser")
    end
    print(word)
end

-- Autosave
vim.api.nvim_create_augroup("autosave_buffer", { clear = true })
vim.api.nvim_create_autocmd({ "BufLeave", "BufUnload", "FocusLost", "WinLeave" }, {

    group = "autosave_buffer",

    callback = function()
        vim.cmd("update")
    end,
})
