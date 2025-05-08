local typescript_lsp_path =
    vim.fn.expand("$MASON/packages/typescript-language-server/node_modules/typescript-language-server/")

vim.g.lsp_servers = {
    volar = {
        init_options = {
            typescript = {
                tsdk = typescript_lsp_path,
            },
            vue = { hybridMode = false },
        },
        filetypes = { "vue" },
    },
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
}

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "mason-org/mason.nvim", lazy = false },
        { "mason-org/mason-lspconfig.nvim", lazy = false },
        "saghen/blink.cmp",
    },
    config = function()
        -- Change icons from letters (default) to true icons
        -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = "" }
        -- for type, icon in pairs(signs) do
        --     local hl = "DiagnosticSign" .. type
        --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        -- end

        -- Make a table for lps's install and vim.lsp.config
        local lsp_server_names = {}
        for lsp_server_name, _ in pairs(vim.g.lsp_servers) do
            local lsp_server_settings = vim.g.lsp_servers[lsp_server_name] or {}
            vim.lsp.config(lsp_server_name, lsp_server_settings)
            table.insert(lsp_server_names, lsp_server_name)
        end

        -- Ensure install and enable installed lsp's
        require("mason-lspconfig").setup({
            ensure_installed = lsp_server_names,
            automatic_enable = true,
        })

        local capabilities = require("blink.cmp").get_lsp_capabilities()
        vim.lsp.config("*", { capabilities = capabilities })
    end,
}
