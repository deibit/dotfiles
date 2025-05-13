-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = { style = "storm" },
-- }

return -- Using Lazy
{
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("onedark").setup({
            style = "warm",
        })
        require("onedark").load()
    end,
}
