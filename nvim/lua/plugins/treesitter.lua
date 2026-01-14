---@module "lazy"
---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        require("nvim-treesitter.config").setup({ indent = { enable = false } })
        -- Enable indentation
        -- Install core parsers at startup
        ts.install({
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
        })

        local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

        local ignore_filetypes = {
            "checkhealth",
            "lazy",
            "mason",
            "snacks_dashboard",
            "snacks_notif",
            "snacks_win",
        }

        -- Auto-install parsers and enable highlighting on FileType
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            desc = "Enable treesitter highlighting and indentation",
            callback = function(event)
                if vim.tbl_contains(ignore_filetypes, event.match) then
                    return
                end

                local lang = vim.treesitter.language.get_lang(event.match) or event.match
                local buf = event.buf

                -- Start highlighting immediately (works if parser exists)
                pcall(vim.treesitter.start, buf, lang)

                -- Enable treesitter indentation
                -- vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                -- Install missing parsers (async, no-op if already installed)
                -- ts.install({ lang })
            end,
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
