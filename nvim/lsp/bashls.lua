return {
    name = "bashls",
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_dir = vim.fs.root(0, {
        ".git",
        ".bashrc",
        ".bash_profile",
        ".bash_aliases",
        "shell.nix",
        "flake.nix",
    }),

    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)", -- archivos reconocidos
            shellcheckPath = "shellcheck", -- binario de shellcheck (opcional)
            explainShell = {
                enable = true, -- activa "Explain Shell" si lo tienes instalado
            },
            backgroundAnalysisMaxFiles = 500,
        },
    },
}
