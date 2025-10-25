return {
    name = "tailwindcss",
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
    },
    root_dir = vim.fs.root(0, {
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "package.json",
        ".git",
    }),

    settings = {
        tailwindCSS = {
            classAttributes = { "class", "className", "ngClass" },
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidScreen = "error",
                invalidVariant = "error",
                invalidConfigPath = "error",
                invalidTailwindDirective = "error",
                recommendedVariantOrder = "warning",
            },
            experimental = {
                classRegex = {
                    "tw`([^`]*)", -- soporte para tw`...`
                    'tw="([^"]*)',
                    'tw={"([^"}]*)',
                    "tw\\.\\w+`([^`]*)", -- tw.sm`...`
                },
            },
            validate = true,
        },
    },
}
