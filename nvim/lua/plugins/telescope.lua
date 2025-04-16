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

            -- ["ui-select"] = {
            --     require("telescope.themes").get_dropdown({
            --         -- even more opts
            --     }),
            --
            --     -- pseudo code / specification for writing custom displays, like the one
            --     -- for "codeactions"
            --     -- specific_opts = {
            --     --   [kind] = {
            --     --     make_indexed = function(items) -> indexed_items, width,
            --     --     make_displayer = function(widths) -> displayer
            --     --     make_display = function(displayer) -> function(e)
            --     --     make_ordinal = function(e) -> string
            --     --   },
            --     --   -- for example to disable the custom builtin "codeactions" display
            --     --      do the following
            --     --   codeactions = false,
            --     -- }
            -- },

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
        { "<leader>F", "<cmd>Telescope oldfiles layout_strategy=vertical<cr>", desc = "Telescope find opened files" },
        { "<leader>G", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
        { "<leader>W", '<cmd>Telescope grep_string search="" <cr>', desc = "Telescope grep under cursor" },
        { "<leader>R", "<cmd>Telescope registers<cr>", desc = "Telescope registers" },
        { "<leader>f", "<cmd>Telescope find_files layout_strategy=vertical<cr>", desc = "Telescope find files" },
        { "<leader>j", "<cmd>Telescope jumplist<cr>", desc = "Telescope jumplist" },
        { "<leader>m", "<cmd>Telescope marks<cr>", desc = "Telescope marks" },
        {
            "<leader><leader>",
            "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            desc = "Telescope fuzzy find buffer",
        },
        -- pickers
        { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
        { "<leader>c", "<cmd>Telescope commands<cr>", desc = "Telescope commands" },
        { "<leader>H", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
        { "<leader>K", "<cmd>Telescope man_pages<cr>", desc = "Telescope man pages" },
        { "<leader>k", "<cmd>Telescope keymaps<cr>", desc = "Telescope keymaps" },
        -- lsp diagnostics
        {
            "<leader>d",
            "<cmd>Telescope diagnostics bufnr=0 layout_strategy=vertical<cr>",
            desc = "Telescope diagnostic buffer",
        },
        { "<leader>D", "<cmd>Telescope diagnostics layout_strategy=vertical<cr>", desc = "Telescope diagnostic" },
        -- lsp
        {
            "<leader>sd",
            "<cmd>Telescope lsp_definitions<cr>",
            desc = "Telescope lsp definitions",
        },
        {
            "<leader>si",
            "<cmd>Telescope lsp_incoming_calls<cr>",
            desc = "Telescope lsp incoming calls",
        },
        {
            "<leader>so",
            "<cmd>Telescope lsp_outgoing_calls<cr>",
            desc = "Telescope lsp outgoing calls",
        },
        {
            "<leader>sr",
            "<cmd>Telescope lsp_references<cr>",
            desc = "Telescope lsp references",
        },
        { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope lsp document symbols" },
        { "<leader>sw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Telescope lsp workspace symbols" },
        -- git
        { "<leader>gt", "<cmd>Telescope git_stash<cr>", desc = "Telescope git stash" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Telescope git branches" },
        { "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "Telescope git commits" },
        { "<leader>gc", "<cmd>Telescope git_bcommits<cr>", desc = "Telescope git buffer commits" },
        { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Telescope git ls files" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Telescope git status" },
        { "<leader>gi", "<cmd>Telescope git_files theme=dropdown<cr>", desc = "Telescope find git files" },
    },
}
