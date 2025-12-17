return -- Using Lazy
{
    {
        "navarasu/onedark.nvim",
        enabled = false,
        config = function()
            require("onedark").setup({
                style = "dark",
                code_style = {
                    keywords = "bold",
                },
            })
            require("onedark").load()
        end,
    },

    { "folke/tokyonight.nvim", enabled = false },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("kanagawa").setup({
                theme = "lotus",
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
            })
        end,
    },
    { "catppuccin/nvim", enabled = false },
}
