return {
    name = "yamlls",
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
    root_markers = { ".git", "docker-compose.yml", "docker-compose.yaml" },

    settings = {
        yaml = {
            validate = true,
            hover = true,
            completion = true,
            format = { enable = true },

            -- Ajustes adicionales
            customTags = {
                "!Ref scalar",
                "!ImportValue scalar",
                "!Sub scalar",
                "!GetAtt scalar",
                "!Join sequence",
            },

            keyOrdering = false, -- permite reordenar claves sin warnings
        },
    },
}
