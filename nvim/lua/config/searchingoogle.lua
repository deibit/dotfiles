local function urlencode(str)
    if not str then
        return ""
    end
    str = str:gsub("\n", " ")
    str = str:gsub("([^%w%-_.~ ])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
    return str:gsub(" ", "+")
end

local function get_visual_selection()
    local mode = vim.fn.mode()
    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
        return nil
    end

    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), {
        type = mode,
        exclusive = vim.o.selection == "exclusive",
    })
    return table.concat(lines, "\n")
end

local function google_search()
    local query = get_visual_selection() or vim.fn.expand("<cword>")
    query = vim.trim(query or "")

    if query == "" then
        vim.notify("No hay texto para buscar", vim.log.levels.WARN)
        return
    end

    local url = "https://www.google.com/search?q=" .. urlencode(query)
    local _, err = vim.ui.open(url)
    if err then
        vim.notify(err, vim.log.levels.ERROR)
    end
end

vim.keymap.set({ "n", "v" }, "<leader>sg", google_search, { desc = "Buscar en Google" })
