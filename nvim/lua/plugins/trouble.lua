return {
    "folke/trouble.nvim",
    opts = {},
    lazy = false,
    cmd = "Trouble",
    keys = {
        {
            "<leader>dd",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Trouble (buffer)",
        },
        { "<leader>dD", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble (project)" },
    },
}
