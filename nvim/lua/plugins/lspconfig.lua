-- Partially taken from https://github.com/scottmckendry/Windots/blob/main/nvim/lua/plugins/lspconfig.lua
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", lazy = false },
        { "williamboman/mason-lspconfig.nvim", lazy = false },
        "saghen/blink.cmp",
    },
    config = function()
        -- Change icons from letters (default) to true icons
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = "" }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        local no_config_servers = {
            "autotools_ls",
            "bashls",
            "clangd",
            "cssls",
            "docker_compose_language_service",
            "dockerls",
            "html",
            "jsonls",
            "yamlls",
            "intelephense",
            "basedpyright",
            "zls",
        }

        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local lspconfig = require("lspconfig")

        -- Run setup for no_config_servers
        for _, server in pairs(no_config_servers) do
            lspconfig[server].setup({ capabilities = capabilities })
        end

        local vue_lsp_path = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server/")
        local typescript_lsp_path =
            vim.fn.expand("$MASON/packages/typescript-language-server/node_modules/typescript-language-server/")

        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vue_lsp_path,
                        languages = { "vue" },
                    },
                },
            },
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        })

        lspconfig.volar.setup({
            capabilities = capabilities,
            init_options = {
                typescript = {
                    tsdk = typescript_lsp_path,
                },
            },
        })

        -- Lua
        require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
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
        })
    end,
}
