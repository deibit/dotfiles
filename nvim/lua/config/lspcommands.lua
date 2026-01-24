local M = {}

local function active_clients(bufnr)
    return vim.lsp.get_clients({ bufnr = bufnr })
end

local function client_names(bufnr)
    return vim.tbl_map(function(c)
        return c.name
    end, active_clients(bufnr))
end

vim.api.nvim_create_user_command("LspInfo", function()
    local clients = active_clients(0)
    if #clients == 0 then
        print("No active LSP clients for this buffer.")
        return
    end
    for _, c in ipairs(clients) do
        print(string.format("%s (id=%d, root=%s)", c.name, c.id, c.config.root_dir or "?"))
    end
end, {})

vim.api.nvim_create_user_command("LspStop", function(opts)
    local name = opts.args ~= "" and opts.args or nil
    for _, c in ipairs(vim.lsp.get_clients()) do
        if not name or c.name == name then
            vim.lsp.stop_client(c.id)
        end
    end
end, {
    nargs = "?",
    complete = function()
        return client_names(nil)
    end,
})

vim.api.nvim_create_user_command("LspRestart", function(opts)
    local name = opts.args ~= "" and opts.args or nil
    local stopped = false

    for _, c in ipairs(vim.lsp.get_clients()) do
        if not name or c.name == name then
            vim.lsp.stop_client(c.id)
            stopped = true
        end
    end

    if stopped then
        vim.defer_fn(function()
            vim.cmd("edit")
        end, 200)
    end
end, {
    nargs = "?",
    complete = function()
        return client_names(nil)
    end,
})

vim.api.nvim_create_user_command("LspStart", function()
    vim.cmd("edit")
end, {})

vim.api.nvim_create_user_command("LspStatus", function()
    local clients = vim.lsp.get_clients()
    if #clients == 0 then
        print("No LSP clients running.")
        return
    end
    for _, c in ipairs(clients) do
        print(string.format("%s attached to %d buffers", c.name, vim.tbl_count(c.attached_buffers)))
    end
end, {})

return M
