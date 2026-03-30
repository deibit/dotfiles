local M = {}

local function active_clients(bufnr)
    return vim.lsp.get_clients({ bufnr = bufnr })
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

vim.api.nvim_create_user_command("LspCapabilities", function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        print("No hay LSPs adjuntos a este buffer")
        return
    end

    for i, client in ipairs(clients) do
        print(string.format("\n=== %d. %s (id: %d) ===", i, client.name, client.id))
        print(vim.inspect(client.server_capabilities))
    end
end, {})

return M
