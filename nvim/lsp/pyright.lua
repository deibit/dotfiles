-- local M = {}
--
-- function M.set_keymap(client, bufnr)
--     local opts = { noremap = true, silent = true }
--     local keymap = vim.api.nvim_buf_set_keymap
--
--     keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--     keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--     keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--     keymap(bufnr, "n", "<C-o>", "<C-o>", opts)
-- end

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
    -- on_attach = M.set_keymap,
}
