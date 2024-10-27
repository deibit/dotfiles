return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            signs = {
                -- icons / text used for a diagnostic
                error = "",
                warning = "",
                hint = "",
                information = "",
                other = "",
            },
            opts = {
                auto_close = true,
                auto_open = true,
            },
            modes = {
                float_symbols = {
                    mode = "symbols",
                    focus = true,
                    win = {
                        type = "float",
                        relative = "editor",
                        size = { width = 0.4, height = 0.5 },
                        border = "rounded",
                        title = "Symbols",
                        title_pos = "center",
                        position = { 0.5, 0.5 },
                        zindex = 200,
                    },
                },
            },
        })
    end,
    lazy = false,
    keys = {
        {
            "<leader>t",
            "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
            desc = "Diagnostic (trouble)",
        },
        { "<leader>sS", "<cmd>Trouble float_symbols toggle<cr>", desc = "Symbols (trouble)" },
    },
}
