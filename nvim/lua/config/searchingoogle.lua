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

    local save_reg = vim.fn.getreg('"')
    vim.cmd('normal! "vy')
    local selected_text = vim.fn.getreg('"')
    vim.fn.setreg('"', save_reg)

    return selected_text
end

local function get_url_launcher()
    local uname = jit.os
    if uname == "OSX" then
        return "open"
    else
        return "xdg-open"
    end
end

local function google_search()
    local query = get_visual_selection() or vim.fn.expand("<cword>")
    query = vim.trim(query or "")

    if query == "" then
        vim.notify("No hay texto para buscar", vim.log.levels.WARN)
        return
    end

    local url = "https://www.google.com/search?q=" .. urlencode(query)
    local launcher = get_url_launcher()

    vim.fn.jobstart({ launcher, url }, { detach = true })
end

vim.keymap.set({ "n", "v" }, "<leader>sg", google_search, { desc = "Buscar en Google" })
