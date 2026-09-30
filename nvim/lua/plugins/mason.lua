return {
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
        keys = { { "<leader>M", ":Mason<cr>", desc = "Mason" } },
        lazy = false,
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },

                keymaps = {
                    toggle_server_expand = "<CR>",
                    install_server = "i",
                    update_server = "u",
                    check_server_version = "c",
                    update_all_servers = "U",
                    check_outdated_servers = "C",
                    uninstall_server = "X",
                    cancel_installation = "<C-c>",
                },
            },
            ensure_installed = require("config.tooling").mason,
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() and not p:is_installing() then
                        p:install()
                    end
                end
            end
            if vim.env.DOTFILES_BOOTSTRAP ~= "1" then
                mr.refresh(function(success)
                    if success then
                        ensure_installed()
                    end
                end)
            end
        end,
    },
}
