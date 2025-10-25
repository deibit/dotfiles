return {
    name = "yamlls",
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
    root_dir = vim.fs.root(0, { ".git", "docker-compose.yml", "docker-compose.yaml" }),

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
