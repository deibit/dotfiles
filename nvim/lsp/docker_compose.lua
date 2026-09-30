return {
    name = "docker_compose",
    cmd = { "docker-compose-langserver", "--stdio" },
    filetypes = { "yaml.docker-compose" },
    root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },

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
