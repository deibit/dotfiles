return {
    name = "html",
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "htmldjango", "templ", "blade" },
    root_dir = vim.fs.root(0, { "index.html", ".git" }),

    settings = {
        html = {
            format = { enable = true },
            hover = { documentation = true, references = true },
            validate = { scripts = true, styles = true },
            suggest = { html5 = true },
        },
    },
}
