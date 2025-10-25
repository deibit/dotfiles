return {
    name = "rust-analyzer",
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = vim.fs.root(0, { "Cargo.toml", "rust-project.json", ".git" }),

    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                autoreload = true,
                buildScripts = {
                    enable = true,
                },
            },
            check = {
                command = "clippy", -- usa `cargo clippy` para diagnósticos más completos
            },
            completion = {
                autoself = { enable = true },
                postfix = { enable = true },
                callable = { snippets = "fill_arguments" },
            },
            diagnostics = {
                enable = true,
                disabled = { "unresolved-proc-macro" },
                enableExperimental = true,
            },
            inlayHints = {
                enable = true,
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisionHints = { enable = "skip_trivial" },
                parameterHints = { enable = true },
                reborrowHints = { enable = "always" },
                typeHints = { enable = true },
                expressionAdjustmentHints = { enable = "reborrow" },
            },
            imports = {
                granularity = { group = "module" },
                prefix = "self",
            },
            lens = {
                enable = true,
                references = { enable = true },
                methodReferences = { enable = true },
                implementations = { enable = true },
                enumVariantReferences = { enable = true },
            },
            procMacro = {
                enable = true,
            },
            hover = {
                actions = {
                    references = { enable = true },
                    implementations = { enable = true },
                },
            },
        },
    },
}
