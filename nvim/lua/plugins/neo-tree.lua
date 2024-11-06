return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<C-t>", "<cmd>Neotree toggle<cr>", desc = "Neotree" },
    },
    opts = {
        close_if_last_window = true,
        filesystem = {
            visible = true,
            filtered_items = {
                hide_dotfiles = true,
                hide_gitignored = true,
                never_show = {
                    ".git",
                    ".DS_Store",
                    "thumbs.db",
                    ".venv",
                    ".ruff_cache",
                    "Session.vim",
                    "__pycache__",
                },
                always_show = {
                    ".gitignored",
                },
                always_show_by_pattern = {
                    ".env*",
                },
            },
            use_libuv_file_watcher = true,
        },
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
