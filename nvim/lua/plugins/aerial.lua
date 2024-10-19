return {
    "stevearc/aerial.nvim",
    opts = {
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set("n", "[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "]", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
        -- filter_kind = false,
        backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
    },
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>2", "<cmd>AerialToggle!<cr>", desc = "Aerial" },
    },
}
