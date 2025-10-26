return {
    name = "pyright",
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
    root_markers = { "pyproject.toml", "setup.py", ".git" },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic", -- Change to "strict" for stricter checks
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace", -- or "openFilesOnly"
            },
        },
    },
}
