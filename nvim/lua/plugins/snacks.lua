-- local explorer_window_picker = { win = { list = { keys = { ["w"] = { { "pick_win", "jump" } } } } } }

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true, line_length = 100000 },
        bufdelete = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        notify = { enabled = true },
        rename = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        toggle = { enabled = true },
        picker = {
            enabled = true,
            sources = { explorer = { git_status = false } },
        },
    },
    keys = {
        -- Common
        {
            "<leader>E",
            function()
                Snacks.picker.cliphist()
            end,
            desc = "system clipboard hist.",
        },

        {
            "<leader>e",
            function()
                Snacks.explorer({ follow_file = false })
            end,
            desc = "Explorer",
        },
        {
            "<leader>x",
            function()
                Snacks.bufdelete()
            end,
            desc = "Buffer delete",
        },

        -- Picker buffer and files

        {
            "<space>",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffer picker",
        },
        {
            "<leader>f",
            function()
                Snacks.picker.files({ hidden = true })
            end,
            desc = "File picker",
        },
        {
            "<leader>F",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent file picker",
        },

        -- Picker Search

        {
            "<leader>S",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep picker",
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader><leader>",
            function()
                Snacks.picker.lines()
            end,
            desc = "Search lines",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },
        {
            "<leader>sk",
            function()
                Snacks.picker.man()
            end,
            desc = "Man Pages",
        },

        {
            "<leader>lt",
            function()
                Snacks.picker.treesitter()
            end,
            desc = "Treesitter picker",
        },

        -- Picker others

        {
            "<leader>m",
            function()
                Snacks.picker.marks()
            end,
            desc = "Marks",
        },
        {
            "<leader>c",
            function()
                Snacks.picker.commands()
            end,
            desc = "Commands",
        },
        {
            "<leader>j",
            function()
                Snacks.picker.jumps()
            end,
            desc = "Jumps",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>H",
            function()
                Snacks.picker.help()
            end,
            desc = "Help Pages",
        },
        {
            "<leader>r",
            function()
                Snacks.picker.registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>k",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>U",
            function()
                Snacks.picker.undo()
            end,
            desc = "Undo search",
        },
    },
}
