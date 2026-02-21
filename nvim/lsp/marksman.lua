return {
    name = "marksman",
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "mdx" },
    root_dir = vim.fs.root(0, { ".git", ".marksman.toml" }),

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
