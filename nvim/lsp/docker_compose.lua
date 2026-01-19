return {
    name = "docker_compose",
    cmd = { "docker-compose-langserver", "--stdio" },
    filetypes = { "yaml.docker-compose" },
    root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },

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
