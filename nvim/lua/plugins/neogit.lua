return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration
        "folke/snacks.nvim", -- optional
    },

    keys = {
        { "<leader>gg", "<cmd>Neogit kind=split_below<cr>", desc = "Neo Git" },
    },
}
