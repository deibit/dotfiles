return {
    "folke/trouble.nvim",
    opts = {},
    lazy = false,
    cmd = "Trouble",
    keys = {
        {
            "<leader>i",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Diagnostic buf (trouble)",
        },
        { "<leader>I", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics all (trouble)" },
    },
}
