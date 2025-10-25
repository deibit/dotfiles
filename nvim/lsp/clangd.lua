return {
    name = "clangd",
    cmd = {
        "clangd",
        "--background-index", -- indexa el proyecto en segundo plano
        "--clang-tidy", -- activa análisis con clang-tidy
        "--header-insertion=iwyu", -- sugerencias de includes automáticos
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm", -- estilo de formato por defecto
        "--cross-file-rename=true",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_dir = vim.fs.root(0, {
        "compile_commands.json",
        "compile_flags.txt",
        ".clangd",
        ".git",
    }),

    settings = {
        clangd = {
            fallbackFlags = { "-std=c++20" },
        },
    },

    init_options = {
        clangdFileStatus = true, -- muestra el estado de los archivos en background
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
    },
}
