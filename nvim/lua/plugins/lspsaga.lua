return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({
            ui = {
                code_action = "",
            },
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>lp",
            "<cmd>Lspsaga peek_definition<cr>",
            desc = "Peek definition",
        },
        {
            "<leader>lc",
            "<cmd>Lspsaga incoming_calls<cr>",
            desc = "Incomming calls",
        },
        {
            "<leader>lC",
            "<cmd>Lspsaga outgoing_calls<cr>",
            desc = "Outgoing calls",
        },
        {
            "<leader>lf",
            "<cmd>Lspsaga finder tyd+ref+imp+def<cr>",
            desc = "lspsaga finder",
        },
        {
            "K",
            "<cmd>Lspsaga hover_doc<cr>",
            desc = "Hover doc",
        },
        {
            "<leader>lo",
            "<cmd>Lspsaga outline<cr>",
            desc = "Outline",
        },
    },
}
