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

vim.api.nvim_set_keymap("n", "<leader>gw", ":lua SearchGoogle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>gw", ":<C-U>lua SearchGoogle(true)<CR>", { noremap = true, silent = true })

function SearchGoogle(is_visual)
    local search_term = ""
    if is_visual then
        -- Obtener la selección visual
        vim.cmd('normal! "vy')
        search_term = vim.fn.getreg("v")
    else
        -- Obtener la palabra bajo el cursor en modo normal
        search_term = vim.fn.expand("<cword>")
    end
    -- Reemplazar espacios con '+'
    search_term = search_term:gsub(" ", "+")
    -- Construir la URL de búsqueda
    local url = "https://www.google.com/search?q=" .. search_term
    print(url)
    -- Abrir la URL en el navegador
    os.execute('open "' .. url .. '"')
end
