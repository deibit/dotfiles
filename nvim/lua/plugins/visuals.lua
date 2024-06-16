return {
    { "nvim-tree/nvim-web-devicons", config = true },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
        },
        keys = { { "<leader>h", ":Gitsigns preview_hunk<cr>", desc = "Gitsigns prev hunk" } },
    },
}
