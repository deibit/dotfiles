return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        bufdelete = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        gitbrowse = { enabled = true },
        input = { enabled = true },
        lazygit = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        rename = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enabled = true },
        toggle = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        {
            "<leader>e",
            function()
                Snacks.explorer()
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
        {
            "<leader>b",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffer picker",
        },
        {
            "<leader>S",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep picker",
        },
        {
            "<leader><leader>",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader>sl",
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
            "<leader>F",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent file picker",
        },
        {
            "<leader>f",
            function()
                Snacks.picker.files()
            end,
            desc = "File picker",
        },
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
            "<leader>d",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Diagnostics (buffer)",
        },
        {
            "<leader>D",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostics",
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
            "<leader>K",
            function()
                Snacks.picker.man()
            end,
            desc = "Man Pages",
        },
        {
            "<leader>R",
            function()
                Snacks.picker.registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>rd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "<leader>rr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "<leader>rI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "<leader>re",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto T[y]pe Definition",
        },
        {
            "<leader>rs",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>k",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>lg",
            function()
                Snacks.lazygit.open()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>t",
            function()
                Snacks.terminal.open()
            end,
            desc = "Toggle terminal",
        },
    },
}
