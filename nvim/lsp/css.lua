return {
    name = "cssls",
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_dir = vim.fs.root(0, { "package.json", ".git" }),

    settings = {
        css = {
            validate = true,
            lint = {
                unknownAtRules = "ignore", -- evita errores por @tailwind o @apply
                important = "ignore",
                duplicateProperties = "warning",
            },
        },
        scss = { validate = true },
        less = { validate = true },
    },
}
