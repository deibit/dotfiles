local diagnostics_layout = {
    layout = {
        backdrop = false,
        width = 0.9,
        min_width = 80,
        height = 0.8,
        min_height = 30,
        box = "vertical",
        border = "rounded",
        title = "{title} {live} {flags}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
    },
}

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
        gitbrowse = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        notify = { enabled = true },
        rename = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enabled = true },
        toggle = { enabled = true },
        words = { enabled = true },
        picker = {
            enabled = true,
        },
    },
    keys = {

        -- Git

        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git log picker",
        },
        {
            "<leader>gd",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Git diff picker",
        },
        {
            "<leader>gL",
            function()
                Snacks.picker.git_log_line()
            end,
            desc = "Git log line picker",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_log_file()
            end,
            desc = "Git log file picker",
        },
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git branches picker",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Gitstatus picker",
        },
        {
            "<leader>gu",
            function()
                Snacks.gitbrowse.open()
            end,
            desc = "Open line in browser",
        },
        {
            "<leader>gU",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Open file in browser",
        },

        -- Common
        {
            "<leader>E",
            function()
                Snacks.picker.cliphist()
            end,
            desc = "system clipboard hist.",
        },

        {
            "<leader>T",
            function()
                Snacks.terminal.open()
            end,
            desc = "Toggle terminal (float)",
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
            "<leader>b",
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

        -- Picker LSP

        {
            "<leader>ld",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "<leader>lr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "<leader>lI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "<leader>le",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto T[y]pe Definition",
        },
        {
            "<leader>ls",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>lt",
            function()
                Snacks.picker.treesitter()
            end,
            desc = "Treesitter picker",
        },

        -- Diagnostics
        {
            "<leader>lx",
            function()
                Snacks.picker.diagnostics_buffer({ layout = diagnostics_layout })
            end,
            desc = "Diagnostics (buffer)",
        },
        {
            "<leader>lX",
            function()
                Snacks.picker.diagnostics({ layout = diagnostics_layout })
            end,
            desc = "Diagnostics",
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
            "<leader>u",
            function()
                Snacks.picker.undo()
            end,
            desc = "Undo search",
        },
    },
}
