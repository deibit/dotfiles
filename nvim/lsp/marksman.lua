return {
    name = "marksman",
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "mdx" },
    root_markers = { ".marksman.toml", ".git" },

    settings = {
        marksman = {
            diagnostics = {
                enabled = true,
            },
            links = {
                validate = true,
                follow = true,
            },
        },
    },
}
