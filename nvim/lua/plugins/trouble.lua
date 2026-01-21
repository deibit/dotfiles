return {
    "folke/trouble.nvim",
    opts = {},
    lazy = false,
    cmd = "Trouble",
    keys = {
        {
            "<leader>td",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Trouble (buffer)",
        },
        { "<leader>tD", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble (project)" },
    },
}
