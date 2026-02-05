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

require("config.settings")
require("config.autocommands")
require("config.commands")
require("config.keymaps")
require("config.searchingoogle")
require("config.lspcommands") -- for Lsp*Commands*

-- Lazy configuration
require("lazy").setup("plugins")

-- vim.cmd([[colorscheme onedark]])
-- vim.cmd([[colorscheme catppuccin-macchiato]])
-- vim.cmd([[colorscheme tokyonight-storm]])
vim.cmd([[colorscheme kanagawa]])

-- LSP
vim.lsp.enable({
    "bashls",
    "rust_analyzer",
    "gopls",
    "lua_ls",
    -- "basedpyright",
    -- "ty",
    "pyrefly",
    "tsserver",
    "html",
    -- "jinja",
    "css",
    "tailwindcss",
    "clangd",
    "jsonls",
    "docker_compose",
    "dockerls",
    "yamlls",
    "taplo",
    "dotls",
})
