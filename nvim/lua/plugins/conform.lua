return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
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
        notify_no_formatters = true,
        formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            go = { "gofmt" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "isort", "ruff_format" },
            rust = { "rustfmt" },
            sh = { "shfmt" },
            sql = { "sqlfmt" },
            toml = { "taplo" },
            typescript = { "prettier" },
            vue = { "prettier" },
            yaml = { "yamlfmt" },
            html = { "djlint", "prettier" },
            jinja = { "djlint" },
        },

        format_after_save = function()
            if vim.g.disable_autoformat then
                return
            end
            return {}
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
