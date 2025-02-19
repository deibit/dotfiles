return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Files" },
        { "<leader>F", "<cmd>FzfLua oldfiles<cr>", desc = "Files (history)" },
        { "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
        { "<leader>k", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
        { "<leader>c", "<cmd>FzfLua commands<cr>", desc = "Commands" },
        { "<leader>m", "<cmd>FzfLua marks<cr>", desc = "Marks" },
        { "<leader>j", "<cmd>FzfLua jumps<cr>", desc = "Jumps" },
        { "<leader>K", "<cmd>FzfLua manpages<cr>", desc = "Man pages" },
        { "<leader>r", "<cmd>FzfLua registers<cr>", desc = "Registers" },
        { "<leader>T", "<cmd>TodoFzfLua<cr>", desc = "View TODOs" },
        -- Search
        { "<leader>S", "<cmd>FzfLua live_grep_native<cr>", desc = "Grep (dir)" },
        { "<leader>ss", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Grep (buffer)" },
        { "<leader>sL", "<cmd>FzfLua lines<cr>", desc = "Lines (buffers)" },
        { "<leader>sl", "<cmd>FzfLua blines<cr>", desc = "Buffer lines" },
        { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word" },
        -- Git
        { "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "Git files" },
        { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
        { "<leader>gc", "<cmd>FzfLua git_bcommits<cr>", desc = "Git commits (buffer)" },
        { "<leader>gC", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
        { "<leader>gb", "<cmd>FzfLua git_blame<cr>", desc = "Git blame" },
        -- <leader>gl is LazyGit on snacks
        -- Diagnostic and LSP
        {
            "<leader>d",
            "<cmd>FzfLua diagnostics_document winopts.preview.layout='vertical' diag_source=true<cr> ",
            desc = "Diagnostic (buffer)",
        },
        {
            "<leader>D",
            "<cmd>FzfLua diagnostics_workspace winopts.preview.layout='vertical' diag_source=true<cr>",
            desc = "Diagnostic",
        },
        { "<leader>r", "<cmd>FzfLua lsp_references<cr>", desc = "lsp references" },
        { "<leader>rd", "<cmd>FzfLua lsp_definitions<cr>", desc = "lsp definitions" },
        { "<leader>re", "<cmd>FzfLua lsp_declarations<cr>", desc = "lsp declarations" },
        { "<leader>ri", "<cmd>FzfLua lsp_implementations<cr>", desc = "lsp implementations" },
        { "<leader>rs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "lsp document symbols" },
        { "<leader>rS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "lsp workspace symbols" },
        { "<leader>rt", "<cmd>FzfLua lsp_typedefs<cr>", desc = "lsp typedefs" },
        { "<leader>rc", "<cmd>FzfLua lsp_incoming_calls<cr>", desc = "lsp incoming calls" },
        { "<leader>rC", "<cmd>FzfLua lsp_outgoing_calls<cr>", desc = "lsp outgoing calls" },
        { "<leader>ra", "<cmd>FzfLua lsp_code_actions<cr>", desc = "lsp code actions" },
        -- Misc
        { "<leader>H", "<cmd>FzfLua helptags<cr>", desc = "Help tags" },
        { "<leader>jp", "<cmd>FzfLua complete_path<cr>", desc = "Complete path" },
        { "<leader>jf", "<cmd>FzfLua complete_file<cr>", desc = "Complete file" },
        { "<leader>l", "<cmd>FzfLua complete_bline<cr>", desc = "Complete buffer line" },
        { "<leader>L", "<cmd>FzfLua complete_line<cr>", desc = "Complete line" },
    },
}
