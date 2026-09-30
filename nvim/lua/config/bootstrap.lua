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

    local registry = require("mason-registry")
    local refreshed = false
    local pending = 0
    local failures = {}
    registry.refresh(function(success, errors)
        if not success then
            failures.registry = vim.inspect(errors)
            refreshed = true
            return
        end
        local ok, err = pcall(function()
            for _, name in ipairs(tooling.mason) do
                local package = registry.get_package(name)
                if not package:is_installed() then
                    pending = pending + 1
                    package:install({}, function(installed, install_error)
                        if not installed then
                            failures[name] = tostring(install_error)
                        end
                        pending = pending - 1
                    end)
                end
            end
        end)
        if not ok then
            failures.registry = tostring(err)
            pending = 0
        end
        refreshed = true
    end)

    local finished = vim.wait(900000, function()
        return refreshed and pending == 0
    end, 200)
    assert(finished, "La instalación de herramientas de Mason agotó el tiempo de espera")
    for name, err in pairs(failures) do
        error("No se pudo instalar " .. name .. ": " .. err)
    end
    for _, name in ipairs(tooling.mason) do
        assert(registry.is_installed(name), "No se instaló la herramienta " .. name)
    end
end

return M
