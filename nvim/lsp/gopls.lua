return {
    name = "gopls",
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),

    settings = {
        gopls = {
            -- Análisis y sugerencias del lenguaje
            analyses = {
                unusedparams = true,
                nilness = true,
                shadow = true,
                unusedvariable = true,
                unusedwrite = true,
                useany = true,
            },
            staticcheck = true, -- activa comprobaciones avanzadas (ineffassign, etc.)
            gofumpt = true, -- usa gofumpt para un estilo más estricto

            -- Configuración de imports
            codelenses = {
                generate = true, -- permite ejecutar "go generate"
                gc_details = true, -- detalles del GC
                test = true, -- ejecutar tests desde el editor
                tidy = true, -- `go mod tidy`
                upgrade_dependency = true,
                vendor = true,
            },

            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },

            -- Manejo de entorno
            directoryFilters = {
                "-node_modules",
                "-vendor",
            },

            -- Compleción y navegación
            usePlaceholders = true, -- añade placeholders en snippets
            completeUnimported = true,
            semanticTokens = true,
        },
    },
}
