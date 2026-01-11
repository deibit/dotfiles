return {
    "lewis6991/gitsigns.nvim",
    config = true,
    lazy = false,
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        current_line_blame = true,
    },
    keys = {
        { "<leader>gn", ":Gitsigns preview_hunk<cr>", desc = "Gitsigns prev hunk" },
        { "<leader>ga", ":Gitsigns blame_line<cr>", desc = "Gitsigns blame line" },
    },
}
