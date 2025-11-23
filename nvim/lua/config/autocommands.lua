-- Do not autocomment new lines
vim.api.nvim_create_autocmd("FileType", {
    command = "setlocal formatoptions-=cro",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
    end,
})

-- Close with <q> certain windows
-- from: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/autocmds.lua
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("deibit/close_with_q", { clear = true }),
    desc = "Close with <q>",
    pattern = {
        "git",
        "help",
        "man",
        "qf",
        "scratch",
    },
    callback = function(args)
        if args.match ~= "help" or not vim.bo[args.buf].modifiable then
            vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
        end
    end,
})
