local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.commands")
require("config.keymaps")
require("config.functions")

-- Lazy configuration
require("lazy").setup("plugins")

vim.cmd([[colorscheme tokyonight-storm]])
