return {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_dir = vim.fs.root(0, { ".luarc.json", ".luacheckrc", ".git" }),

    settings = {
        Lua = {
            runtime = {
                -- Usamos LuaJIT, que es lo que Neovim emplea internamente
                version = "LuaJIT",
                -- Añade tus rutas personalizadas (opcional)
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                -- Reconoce las variables globales de Neovim y tus propias globales
                globals = { "vim", "require" },
                -- Desactiva warnings por variables no usadas, si lo prefieres
                unusedLocalExclude = { "_*" },
            },
            workspace = {
                -- Aumenta la precisión de la autocompletación y saltos
                library = vim.api.nvim_get_runtime_file("", true),
                -- Evita que el servidor escanee todo tu sistema
                checkThirdParty = false,
            },
            completion = {
                callSnippet = "Replace", -- mejora los snippets de funciones
            },
            telemetry = {
                enable = false,
            },
            hint = {
                enable = true, -- activa hints en línea
                setType = true, -- muestra tipos inferidos
                arrayIndex = "Auto",
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                space = true,
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    continuation_indent_size = "4",
                    quote_style = "double",
                },
            },
        },
    },
}
