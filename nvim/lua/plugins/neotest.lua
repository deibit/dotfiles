return {
    "nvim-neotest/neotest",
    ft = { "go", "python" },
    dependencies = {
        "nvim-neotest/neotest-go",
        "nvim-neotest/neotest-python",
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
        return {
            adapters = {
                require("neotest-go"),
                require("neotest-python"),
            },
        }
    end,
    config = function(_, opts)
        local neotest_ns = vim.api.nvim_create_namespace("neotest")
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                    return message
                end,
            },
        }, neotest_ns)
        require("neotest").setup(opts)
    end,
}
