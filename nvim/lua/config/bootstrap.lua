local M = {}

function M.run()
    local tooling = require("config.tooling")

    for _, plugin in pairs(require("lazy.core.config").plugins) do
        assert(plugin._.installed, "No se pudo instalar el plugin " .. plugin.name)
    end

    assert(
        require("nvim-treesitter").install(tooling.parsers):wait(900000),
        "No se pudieron instalar todos los analizadores de Tree-sitter"
    )
end

return M
