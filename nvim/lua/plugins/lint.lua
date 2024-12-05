return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            markdown = { "vale" },
            c = { "clangtidy", "cppcheck" },
            cpp = { "clangtidy", "cppcheck" },
            javascript = { "eslint" },
            python = { "ruff" },
        }
    end,
}
