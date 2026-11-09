return {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
        require("mini.basics").setup({ autocommands = { basic = false } })
        require("mini.ai").setup()
        require("mini.align").setup()
        require("mini.comment").setup()
        require("mini.cursorword").setup()
        require("mini.extra").setup()
        require("mini.fuzzy").setup()
        require("mini.pairs").setup()
        require("mini.splitjoin").setup()
        require("mini.surround").setup()
        require("mini.trailspace").setup()
    end,
}
