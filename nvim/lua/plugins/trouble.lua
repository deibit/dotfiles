return {
    "folke/trouble.nvim",
    opts = {},
    lazy = false,
    cmd = "Trouble",
    keys = {
        {
            "<leader>i",
            "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
            desc = "Diagnostic (trouble)",
        },
        { "<leader>I", "<cmd>Trouble float_symbols toggle<cr>", desc = "Symbols (trouble)" },
    },
}
