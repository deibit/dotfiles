return {
    name = "jsonls",
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_dir = vim.fs.root(0, { ".git", "package.json" }),

    settings = {
        json = {
            validate = { enable = true },
            format = { enable = true },
        },
    },
}
