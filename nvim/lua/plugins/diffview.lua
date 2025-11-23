return {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
        { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
    },
}
