return {
    name = "dotls",
    cmd = { "dotenv-lsp", "--stdio" },
    filetypes = { "env" },
    root_dir = vim.fs.root(0, { ".env", ".git" }),

    settings = {
        dotenv = {
            completion = true,
            diagnostics = true,
            hover = true,
            schema = {
                enabled = false, -- no usa esquemas externos, solo validación básica
            },
        },
    },
}
