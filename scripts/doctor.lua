local repo = vim.env.DOTFILES_REPO
local fat = vim.env.DOTFILES_PROFILE == "fat"
local errors = {}
local function check(condition, message)
    if not condition then table.insert(errors, message) end
end
local version = fat and "0.12" or "0.10"
check(vim.fn.has("nvim-" .. version) == 1, "Neovim debe ser >= " .. version)
print("Neovim: " .. tostring(vim.version()))
if fat then
    local data = vim.fn.stdpath("data")
    local lock = vim.json.decode(table.concat(vim.fn.readfile(repo .. "/nvim/lazy-lock.json"), "\n"))
    for name in pairs(lock) do
        check(vim.fn.isdirectory(data .. "/lazy/" .. name) == 1, "Plugin ausente: " .. name)
    end
    local tooling = dofile(repo .. "/nvim/lua/config/tooling.lua")
    for _, name in ipairs(tooling.mason) do
        check(vim.fn.isdirectory(data .. "/mason/packages/" .. name) == 1, "Herramienta Mason ausente: " .. name)
    end
    for _, name in ipairs(tooling.parsers) do
        check(vim.fn.filereadable(data .. "/site/parser/" .. name .. ".so") == 1, "Parser ausente: " .. name)
    end
end
if #errors > 0 then
    table.sort(errors)
    for _, message in ipairs(errors) do print("FALLO " .. message) end
    vim.cmd("cquit 1")
end
