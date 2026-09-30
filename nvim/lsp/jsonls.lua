return {
    name = "jsonls",
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git", "package.json" },

    settings = {
        json = {
            validate = { enable = true },
            format = { enable = true },
        },
    },
}
