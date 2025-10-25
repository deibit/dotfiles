return {
    name = "marksman",
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "mdx" },
    root_dir = vim.fs.root(0, { ".git", ".marksman.toml" }),

    settings = {
        marksman = {
            diagnostics = {
                enabled = true,
                -- Puedes ignorar algunas reglas si lo prefieres:
                -- ignored = { "missing-link-target", "missing-heading" },
            },
            -- Activa vínculos entre archivos en tu workspace
            links = {
                validate = true,
                follow = true,
            },
            -- Si trabajas con notas interconectadas (tipo Obsidian)
            -- puedes cambiar la raíz del workspace con este archivo:
            -- workspaceRoot = "/ruta/a/tu/notes",
        },
    },
}
