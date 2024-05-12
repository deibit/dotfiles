return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("aerial")
    end,
    opts = {
        pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
        },
        extensions = {
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure

            ["ui-select"] = {
                require("telescope.themes").get_dropdown({
                    -- even more opts
                }),

                -- pseudo code / specification for writing custom displays, like the one
                -- for "codeactions"
                -- specific_opts = {
                --   [kind] = {
                --     make_indexed = function(items) -> indexed_items, width,
                --     make_displayer = function(widths) -> displayer
                --     make_display = function(displayer) -> function(e)
                --     make_ordinal = function(e) -> string
                --   },
                --   -- for example to disable the custom builtin "codeactions" display
                --      do the following
                --   codeactions = false,
                -- }
            },

            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    },
    lazy = false,
    keys = {
        -- finders
        { "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Telescope grep under cursor" },
        { "<leader>R", "<cmd>Telescope registers<cr>", desc = "Telescope registers" },
        { "<leader>f", "<cmd>Telescope find_files theme=dropdown<cr>", desc = "Telescope find files" },
        { "<leader>i", "<cmd>Telescope git_files theme=dropdown<cr>", desc = "Telescope find git files" },
        { "<leader>G", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
        { "<leader>z", '<cmd>Telescope grep_string search="" <cr>', desc = "Telescope live fuzzy grep" },
        {
            "<leader><leader>",
            "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            desc = "Telescope fuzzy find buffer",
        },
        -- pickers
        { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
        { "<leader>c", "<cmd>Telescope commands<cr>", desc = "Telescope commands" },
        { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
        { "<leader>k", "<cmd>Telescope man_pages<cr>", desc = "Telescope man pages" },
        { "<leader>m", "<cmd>Telescope keymaps<cr>", desc = "Telescope keymaps" },
        { "<leader>o", "<cmd>Telescope oldfiles<cr>", desc = "Telescope old files" },
        -- lsp
        { "<leader>sa", "<cmd>Telescope aerial<cr>", desc = "Telescope Aerial" },
        { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Telescope Diagnostic" },
        { "<leader>sc", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Telescope lsp incoming calls" },
        { "<leader>sf", "<cmd>Telescope lsp_definitions<cr>", desc = "Telescope lsp definitions" },
        { "<leader>si", "<cmd>Telescope lsp_implementations<cr>", desc = "Telescope lsp implementations" },
        { "<leader>so", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Telescope lsp outgoing calls" },
        { "<leader>sr", "<cmd>Telescope treesitter<cr>", desc = "Telescope treesitter" },
        { "<leader>st", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Telescope lsp type definitions" },
        { "<leader>sx", "<cmd>Telescope lsp_references<cr>", desc = "Telescope lsp references" },
        { "<leader>sw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Telescope lsp workspace symbols" },
        { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope lsp document symbols" },
        -- git
        { "<leader>gt", "<cmd>Telescope git_stash<cr>", desc = "Telescope git stash" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Telescope git branches" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Telescope git commits" },
        { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Telescope git ls files" },
        { "<leader>go", "<cmd>Telescope git_bcommits<cr>", desc = "Telescope git buffer commits" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Telescope git status" },
    },
}
