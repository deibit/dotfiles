return -- Using Lazy
{
    -- "navarasu/onedark.nvim",
    -- config = function()
    --     require("onedark").setup({
    --         style = "dark",
    --         code_style = {
    --             keywords = "bold",
    --         },
    --     })
    --     require("onedark").load()
    -- end,

    -- "folke/tokyonight.nvim",
    "rebelot/kanagawa.nvim",
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
    -- "catppuccin/nvim",

    priority = 1000,
    lazy = false,
}
