return {
    name = "dockerls",
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "dockerfile" },
    root_markers = { "Dockerfile", ".git" },

    settings = {
        docker = {
            languageserver = {
                diagnostics = { enable = true },
                formatting = { enable = true },
            },
        },
    },
}
