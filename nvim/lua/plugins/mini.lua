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
        require("mini.git").setup()
        -- require("mini.indentscope").setup({ draw = { animation = require("mini.indentscope").gen_animation.none() } })
        -- require("mini.jump").setup()
        -- require("mini.jump2d").setup()
        -- require("mini.move").setup()
        require("mini.notify").setup()
        -- require("mini.operators").setup()
        require("mini.pairs").setup()
        -- require("mini.pick").setup()
        require("mini.sessions").setup()
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
    --     { "<leader>F", ":Pick git_files<cr>", desc = "Pick git files" },
    --     { "<leader>c", ":Pick commands<cr>", desc = "Pick command" },
    --     { "<leader>cc", ":Pick history<cr>", desc = "Pick history" },
    --     { "<leader>E", ":Pick explorer<cr>", desc = "Pick explorer" },
    --     { "<leader>b", ":Pick buffers<cr>", desc = "Pick buffer" },
    --     { "<leader>l", ":Pick buf_lines<cr>", desc = "Pick buffer line" },
    --     { "<leader>S", ":Pick grep_live<cr>", desc = "Pick live grep" },
    --     { "<leader>sw", ":Pick grep pattern='<cword>'<cr>", desc = "Pick grep cword" },
    --     { "<leader>ss", ":Pick grep<cr>", desc = "Pick grep" },
    --     -- { "<leader>d", ":Pick diagnostic scope='current'<cr>", desc = "Pick diagnostic (buffer)" }, -- Use "Trouble" here
    --     -- { "<leader>D", ":Pick diagnostic<cr>", desc = "Pick diagnostic (workspace)" }, -- Use "Trouble" here
    --     { "<leader>R", ":Pick registers<cr>", desc = "Pick registers" },
    --     { "<leader>k", ":Pick keymaps<cr>", desc = "Pick keymaps" },
    --     { "<leader>H", ":Pick help<cr>", desc = "Pick help" },
    --     { "<leader>m", ":Pick marks<cr>", desc = "Pick marks" },
    --     -- Git
    --     { "<leader>gb", ":Pick git_branches<cr>", desc = "Pick git branches" },
    --     { "<leader>gb", ":Pick git_branches<cr>", desc = "Pick git branches" },
    --     { "<leader>gc", ":Pick git_commits<cr>", desc = "Pick git commits" },
    --     { "<leader>gu", ":Pick git_hunks<cr>", desc = "Pick git hunks" },
    --     -- LSP
    --     { "<leader>rD", ":Pick lsp scope='definition'<cr>", desc = "Pick symbol definition" },
    --     { "<leader>rd", ":Pick lsp scope='declaration'<cr>", desc = "Pick symbol declaration" },
    --     { "<leader>ri", ":Pick lsp scope='implementation'<cr>", desc = "Pick symbol implementation" },
    --     { "<leader>rr", ":Pick lsp scope='references'<cr>", desc = "Pick symbol references" },
    --     { "<leader>rs", ":Pick lsp scope='document_symbol'<cr>", desc = "Pick document symbol" },
    --     { "<leader>rt", ":Pick lsp scope='type_definition'<cr>", desc = "Pick symbol type" },
    --     { "<leader>rw", ":Pick lsp scope='workspace_symbol'<cr>", desc = "Pick workspace symbols" },
    -- },
}
