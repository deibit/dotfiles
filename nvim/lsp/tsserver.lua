return {
    name = "tsserver",
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_dir = vim.fs.root(0, {
        "package.json",
        "tsconfig.json",
        "jsconfig.json",
        ".git",
    }),

    settings = {
        typescript = {
            preferences = {
                importModuleSpecifier = "relative", -- rutas relativas para imports
                includeCompletionsForModuleExports = true,
                includeCompletionsWithSnippetText = true,
                quotePreference = "auto",
            },
            suggest = {
                completeFunctionCalls = true, -- completa llamadas con paréntesis
            },
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
            format = {
                enable = true,
            },
        },
        javascript = {
            preferences = {
                importModuleSpecifier = "relative",
                includeCompletionsForModuleExports = true,
                includeCompletionsWithSnippetText = true,
                quotePreference = "auto",
            },
            suggest = {
                completeFunctionCalls = true,
            },
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
            format = {
                enable = true,
            },
        },
    },
}
