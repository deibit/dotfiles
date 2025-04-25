vim.keymap.set("n", "<leader>z", function()
    vim.diagnostic.open_float(nil, {
        focusable = true,
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
    })
end, { desc = "Show diagnostic in float" })
