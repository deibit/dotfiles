---@module "lazy"
---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter")

        configs.setup({
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            indent = { enable = false },

            ensure_installed = {
                -- Web Dev
                "html",
                "css",
                "scss",
                "javascript",
                "typescript",
                "svelte",
                "vue",
                "json",
                "yaml",
                "xml",
                -- System & Tools
                "bash",
                "python",
                "go",
                "rust",
                "cmake",
                "make",
                "dockerfile",
                "toml",
                -- Git & Utils
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "diff",
                -- Documentation
                "markdown",
                "markdown_inline",
                "comment",
                -- Neovim
                "lua",
                "luadoc",
                "vim",
                "vimdoc",
                "query",
            },
        })
    end,
}
