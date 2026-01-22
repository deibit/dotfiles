return {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView file" },
        { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "DiffView open" },
        { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "DiffView close" },
    },
}
