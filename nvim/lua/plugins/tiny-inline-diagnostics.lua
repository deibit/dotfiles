return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
        require("tiny-inline-diagnostic").setup()
    end,
    opts = {
        virt_texts = {
            priority = 50000,
        },
    },
}
