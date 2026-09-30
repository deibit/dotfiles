return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    init = function()
        vim.api.nvim_create_user_command("ConformToggle", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            print("Conform " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
        end, {
            desc = "Toggle format on save",
        })
    end,
    opts = {
        formatters_by_ft = {
            c = { "clang_format", lsp_format = "fallback" },
            cpp = { "clang_format", lsp_format = "fallback" },
            go = { lsp_format = "prefer" },
            javascript = { "prettier", lsp_format = "fallback" },
            json = { "prettier", lsp_format = "fallback" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "isort", "ruff_format" },
            rust = { lsp_format = "prefer" },
            sh = { "shfmt" },
            sql = { "sqlfmt" },
            toml = { "taplo" },
            typescript = { "prettier", lsp_format = "fallback" },
            vue = { "prettier", lsp_format = "fallback" },
            yaml = { "yamlfmt" },
            html = { "djlint", "prettier" },
            jinja = { "djlint" },
        },

        format_after_save = function()
            if vim.g.disable_autoformat then
                return
            end
            return { lsp_format = "fallback" }
        end,

        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
            prettier = {
                prepend_args = { "--tab-width", "4" },
            },
        },
    },
}
