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
    event = "BufReadPre",
    config = function()
        vim.g.disable_autoformat = false
        require("conform").setup({
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                css = { "prettier" },
                html = { "prettier" },
                javascript = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                sh = { "shfmt" },
                toml = { "taplo" },
                yaml = { "yamlfmt" },
                python = { "black", "isort" },
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
            },
        })

        -- Override stylua's default indent type
        require("conform").formatters.stylua = {
            prepend_args = { "--indent-type", "Spaces" },
        }

        -- Override prettier's default indent type
        require("conform").formatters.prettier = {
            prepend_args = { "--tab-width", "4" },
        }

        -- Toggle format on save
        vim.api.nvim_create_user_command("ConformToggle", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            print("Conform " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
        end, {
            desc = "Toggle format on save",
        })
    end,
}
