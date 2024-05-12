return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>1", "<cmd>Neotree toggle<cr>", desc = "Neotree" },
    },
    opts = {
        window = {
            mappings = {
                ["<cr>"] = "open_with_window_picker",
                ["S"] = "split_with_window_picker",
                ["s"] = "vsplit_with_window_picker",
                ["w"] = "open_with_window_picker",
            },
        },
    },
}
