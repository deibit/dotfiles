-- Simple wrappers for native LSP management in Neovim >= 0.11

local M = {}

local function get_lsp_client_names()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local names = vim.tbl_map(function(client)
        return client.name
    end, clients)
    return names
end

-- LspStart [name]
vim.api.nvim_create_user_command("LspStart", function(opts)
    local name = opts.args ~= "" and opts.args or nil
    if name then
        vim.lsp.enable({ name })
        print("Started LSP: " .. name)
    else
        local message = "configured LSP for this filetype: " .. table.concat(get_lsp_client_names(), ", ")
        print(message)
    end
end, {
    nargs = "?",
    complete = get_lsp_client_names,
})

-- LspStop [name]
vim.api.nvim_create_user_command("LspStop", function(opts)
    local clients = vim.lsp.get_clients()
    local name = opts.args
    for _, client in ipairs(clients) do
        if name == "" or client.name == name then
            vim.lsp.stop_client(client.id)
            print("Stopped LSP: " .. client.name)
        end
    end
end, {
    nargs = "?",
    complete = function()
        local clients = vim.lsp.get_clients()
        local names = {}
        for _, c in ipairs(clients) do
            table.insert(names, c.name)
        end
        return names
    end,
})

-- LspRestart [name]
vim.api.nvim_create_user_command("LspRestart", function(opts)
    local name = opts.args
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
        if name == "" or client.name == name then
            vim.lsp.stop_client(client.id)
            vim.defer_fn(function()
                vim.lsp.enable({ name })
            end, 200)
            print("Restarted LSP: " .. client.name)
        end
    end
end, {
    nargs = "?",
    complete = get_lsp_client_names,
})

-- LspInfo
vim.api.nvim_create_user_command("LspInfo", function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if vim.tbl_isempty(clients) then
        print("No active LSP clients for this buffer.")
        return
    end
    print("Active LSP clients:\n")
    for _, client in ipairs(clients) do
        print(string.format("  • %s (id=%d, root=%s)", client.name, client.id, client.config.root_dir or "?"))
    end
end, {})

-- LspStatus
vim.api.nvim_create_user_command("LspStatus", function()
    local clients = vim.lsp.get_clients()
    if vim.tbl_isempty(clients) then
        print("No LSP clients running.")
        return
    end
    for _, c in ipairs(clients) do
        print(string.format("[%s] attached to %d buffers", c.name, #c.attached_buffers))
    end
end, {})

return M
