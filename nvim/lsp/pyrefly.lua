---@type vim.lsp.Config
return {
    name = "pyrefly",
    cmd = { "pyrefly", "lsp" },
    filetypes = { "python" },
    root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
    root_markers = { "pyproject.toml", "setup.py", ".git" },
}
