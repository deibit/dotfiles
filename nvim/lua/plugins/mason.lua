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
            ensure_installed = {
                "autotools-language-server",
                "basedpyright",
                "bash-language-server",
                "clang-format",
                "clangd",
                "css-lsp",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "html-lsp",
                "intelephense",
                "isort",
                "json-lsp",
                "lua-language-server",
                "prettier",
                "ruff",
                "shfmt",
                "stylelint",
                "stylua",
                "typescript-language-server",
                "vue-language-server",
                "yaml-language-server",
                "yamlfmt",
                "marksman",
                "taplo",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
