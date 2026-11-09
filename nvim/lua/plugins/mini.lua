return {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
        require("mini.basics").setup()
        require("mini.ai").setup()
        require("mini.align").setup()
        -- require('mini.animate').setup()
        -- require("mini.bracketed").setup()
        -- require("mini.bufremove").setup()
        require("mini.comment").setup()
        -- require("mini.completion").setup()
        require("mini.cursorword").setup()
        -- require("mini.diff").setup()
        require("mini.extra").setup()
        require("mini.fuzzy").setup()
        -- require("mini.indentscope").setup({ draw = { animation = require("mini.indentscope").gen_animation.none() } })
        -- require("mini.jump").setup()
        -- require("mini.jump2d").setup()
        -- require("mini.move").setup()
        require("mini.notify").setup()
        -- require("mini.operators").setup()
        require("mini.pairs").setup()
        -- require("mini.pick").setup()
        require("mini.splitjoin").setup()
        -- require('mini.starter').setup()
        require("mini.surround").setup()
        require("mini.trailspace").setup()
        -- require("mini.visits").setup()
    end,
    -- keys = {
    --     -- mini.pick mappings
    --     { "<leader>f", ":Pick files<cr>", desc = "Pick files" },
    --     { "<leader>ff", ":Pick oldfiles<cr>", desc = "Pick old files" },
    --     { "<leader>c", ":Pick commands<cr>", desc = "Pick command" },
    --     { "<leader>cc", ":Pick history<cr>", desc = "Pick history" },
    --     { "<leader>E", ":Pick explorer<cr>", desc = "Pick explorer" },
    --     { "<leader>b", ":Pick buffers<cr>", desc = "Pick buffer" },
    --     { "<leader>l", ":Pick buf_lines<cr>", desc = "Pick buffer line" },
    --     { "<leader>S", ":Pick grep_live<cr>", desc = "Pick live grep" },
    --     { "<leader>sw", ":Pick grep pattern='<cword>'<cr>", desc = "Pick grep cword" },
    --     { "<leader>ss", ":Pick grep<cr>", desc = "Pick grep" },
    --     { "<leader>R", ":Pick registers<cr>", desc = "Pick registers" },
    --     { "<leader>k", ":Pick keymaps<cr>", desc = "Pick keymaps" },
    --     { "<leader>H", ":Pick help<cr>", desc = "Pick help" },
    --     { "<leader>m", ":Pick marks<cr>", desc = "Pick marks" },
    -- },
}
