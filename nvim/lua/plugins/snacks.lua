local function pick(source)
    return function()
        Snacks.picker[source]()
    end
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
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
        -- General
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

        -- Files and buffers
        { "<space>", pick("buffers"), desc = "Buffer picker" },
        {
            "<leader>f",
            function()
                Snacks.picker.files({ hidden = true })
            end,
            desc = "File picker",
        },
        { "<leader>F", pick("recent"), desc = "Recent file picker" },

        -- Search
        { "<leader>S", pick("grep"), desc = "Grep picker" },
        { "<leader>ss", pick("grep_buffers"), desc = "Grep Open Buffers" },
        { "<leader><leader>", pick("lines"), desc = "Search lines" },
        { "<leader>sw", pick("grep_word"), desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>sk", pick("man"), desc = "Man Pages" },

        -- Editor navigation
        { "<leader>lt", pick("treesitter"), desc = "Treesitter picker" },
        { "<leader>m", pick("marks"), desc = "Marks" },
        { "<leader>c", pick("commands"), desc = "Commands" },
        { "<leader>j", pick("jumps"), desc = "Jumps" },
        { "<leader>:", pick("command_history"), desc = "Command History" },
        { "<leader>H", pick("help"), desc = "Help Pages" },
        { "<leader>r", pick("registers"), desc = "Registers" },
        { "<leader>k", pick("keymaps"), desc = "Keymaps" },
        { "<leader>U", pick("undo"), desc = "Undo search" },
    },
}
