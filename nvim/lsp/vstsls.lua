---@type vim.lsp.Config
return {
    cmd = { "vtsls", "--stdio" },
    init_options = {
        hostInfo = "neovim",
    },
    settings = {
        typescript = {
            tsdk = nil,
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
                parameterNames = { enabled = "all" },
                variableTypes = { enabled = true },
            },
        },
        vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
                completion = {
                    enableServerSideFuzzyMatch = true,
                },
            },
        },
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_dir = function(bufnr, on_dir)
        local root_markers = {
            "tsconfig.json",
            "jsconfig.json",
            "package.json",
            "bun.lockb",
            "bun.lock",
            "package-lock.json",
            "yarn.lock",
            "pnpm-lock.yaml",
        }

        root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
            or vim.list_extend(root_markers, { ".git" })

        -- Excluir Deno (importante para evitar conflictos de LSP)
        if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
            return
        end

        local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

        on_dir(project_root)
    end,
}
