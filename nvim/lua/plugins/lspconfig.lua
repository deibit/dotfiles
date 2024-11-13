-- Partially taken from https://github.com/scottmckendry/Windots/blob/main/nvim/lua/plugins/lspconfig.lua
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
        { "williamboman/mason.nvim", lazy = false },
        { "williamboman/mason-lspconfig.nvim", lazy = false },
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- Change icons from letters (default) to true icons
        local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        local no_config_servers = {
            "autotools_ls",
            "clangd",
            "cssls",
            "docker_compose_language_service",
            "dockerls",
            "html",
            "jsonls",
            "ts_ls",
            "yamlls",
            "intelephense",
        }

        -- Run setup for no_config_servers
        for _, server in pairs(no_config_servers) do
            require("lspconfig")[server].setup({})
        end

        -- Lua
        require("lspconfig").lua_ls.setup({
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

        require("lspconfig").pylsp.setup({
            settings = {
                pylsp = {
                    configurationSources = { "ruff" },
                    plugins = {
                        ruff = {
                            enabled = true,
                            formatEnabled = false,
                        },
                    },
                },
            },
        })
    end,
}
