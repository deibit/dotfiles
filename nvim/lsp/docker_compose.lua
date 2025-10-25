return {
    name = "docker_compose",
    cmd = { "docker-compose-langserver", "--stdio" },
    filetypes = { "yaml", "yml", "docker-compose" },
    root_dir = vim.fs.root(0, { "docker-compose.yml", "docker-compose.yaml", ".git" }),

    settings = {
        dockerCompose = {
            files = {
                associations = {
                    ["docker-compose*.yml"] = "yaml",
                    ["docker-compose*.yaml"] = "yaml",
                },
            },
            format = { enable = true },
            validation = { enable = true },
        },
    },
}
