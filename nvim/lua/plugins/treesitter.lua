---@module "lazy"
---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            auto_install = true,
            indent = { enable = false },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            ensure_installed = {
                "bash",
                "comment",
                "css",
                "diff",
                "cmake",
                "dockerfile",
                "dot",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "go",
                "html",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "rust",
                "regex",
                "scss",
                "svelte",
                "toml",
                "typescript",
                "yaml",
                "vim",
                "vimdoc",
                "vue",
                "xml",
            },
        })
    end,
}

-- Snippet for disable TS when buffer is too heavy
-- disable = function(lang, buf)
--     local max_filesize = 100 * 1024 -- 100 KB
--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--     if ok and stats and stats.size > max_filesize then
--         return true
--     end
-- end,
--
