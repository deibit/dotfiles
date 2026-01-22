-- Create user group and register
local user_group = "UserGroup"
vim.api.nvim_create_augroup(user_group, {})

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
    group = user_group,
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

-- Remember cursor last position when enter a buffer
-- from: https://github.com/creativenull/dotfiles/blob/9ae60de4f926436d5682406a5b801a3768bbc765/config/nvim/init.lua#L70-L86
vim.api.nvim_create_autocmd("BufReadPost", {
    group = user_group,
    callback = function(args)
        local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
        local not_commit = vim.b[args.buf].filetype ~= "commit"

        if valid_line and not_commit then
            vim.cmd([[normal! g`"]])
        end
    end,
})
