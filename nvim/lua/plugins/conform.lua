-- Based on https://github.com/scottmckendry/Windots/blob/main/nvim/lua/plugins/conform.lua

local get_venv_command = function(command)
    if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. "/bin/" .. command
    else
        return command
    end
end

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    init = function()
        vim.g.autoformat = true
        vim.api.nvim_create_user_command("ConformToggle", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            print("Conform " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
        end, {
            desc = "Toggle format on save",
        })
    end,
    opts = {
        formatters_by_ft = {
            c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
            cpp = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
            go = { name = "gopls", timeout_ms = 500, lsp_format = "prefer" },
            javascript = { "prettier", timeout_ms = 500, lsp_format = "fallback" },
            json = { "prettier", timeout_ms = 500, lsp_format = "fallback" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "ruff_format", "isort" },
            rust = { name = "rust_analyzer", timeout_ms = 500, lsp_format = "prefer" },
            sh = { "shfmt" },
            sql = { "sqlfmt" },
            toml = { "taplo" },
            typescript = { "prettier", timeout_ms = 500, lsp_format = "fallback" },
            vue = { "prettier" },
            yaml = { "yamlfmt" },
        },

        format_after_save = function()
            if vim.g.disable_autoformat then
                return
            else
                return { lsp_fallback = true }
            end
        end,

        formatters = {
            black = {
                command = get_venv_command("black"),
            },
            goimports_reviser = {
                command = "goimports-reviser",
                args = { "-output", "stdout", "$FILENAME" },
            },
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
            prettier = {
                prepend_args = { "--tab-width", "4" },
            },
        },
    },
}
