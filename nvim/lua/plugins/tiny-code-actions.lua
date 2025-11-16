return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "folke/snacks.nvim",
            opts = {
                terminal = {},
            },
        },
    },
    event = "LspAttach",
    opts = {},
    keys = {
        {
            "<leader>la",
            function()
                require("tiny-code-action").code_action()
            end,
            desc = "Code actions",
        },
    },
}
