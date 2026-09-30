---@module "lazy"
---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        if vim.env.DOTFILES_BOOTSTRAP ~= "1" then
            require("nvim-treesitter").install(require("config.tooling").parsers)
        end
    end,
}
