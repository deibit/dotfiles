return {
    name = "taplo",
    cmd = { "taplo", "lsp", "stdio" },
    filetypes = { "toml" },
    root_markers = { "Cargo.toml", "pyproject.toml", ".git" },

    settings = {
        evenBetterToml = {
            schema = {
                enabled = true,
                repositoryEnabled = true, -- usa el repo público de esquemas de Taplo
            },
            formatter = {
                reorderKeys = true, -- ordena claves en bloques al formatear
                alignEntries = false,
                indentTables = true,
            },
            validation = {
                enabled = true,
                schema = true,
            },
        },
    },
}
