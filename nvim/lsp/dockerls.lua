return {
    name = "dockerls",
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "dockerfile" },
    root_dir = vim.fs.root(0, { "Dockerfile", ".git" }),

    settings = {
        docker = {
            languageserver = {
                diagnostics = { enable = true },
                formatting = { enable = true },
            },
        },
    },
}
