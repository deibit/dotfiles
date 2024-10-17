return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            markdown = { "vale" },
            python = { "pylint" },
            c = { "clangtidy", "cppcheck" },
            cpp = { "clangtidy", "cppcheck" },
            javascript = { "eslint" },
        }
    end,
}
