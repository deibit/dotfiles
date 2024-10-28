return {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true,
    keys = {
        { "<leader>v", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", desc = "Preview definition" },
        {
            "<leader>V",
            "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
            desc = "Preview implementation",
        },
        {
            "<leader>D",
            "<cmd>lua require('goto-preview').goto_preview_declaration()<cr>",
            desc = "Preview declaration",
        },
    },
}
