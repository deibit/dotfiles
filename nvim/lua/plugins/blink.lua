return {
    "saghen/blink.cmp",
    event = "InsertEnter",

    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "none",

            ["<Down>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },

            ["<Tab>"] = { "accept", "fallback" },
            ["<CR>"] = { "accept", "fallback" },

            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-c>"] = { "hide", "fallback" },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },

        signature = { enabled = false, window = { border = "single" } },

        sources = {
            default = { "path", "snippets", "buffer" },

            providers = {
                path = {
                    opts = {
                        get_cwd = function(_)
                            return vim.fn.getcwd()
                        end,
                    },
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "single" } },
            list = { selection = { preselect = true, auto_insert = false } },
            menu = {
                draw = {
                    columns = {
                        { "label", gap = 1 },
                        { "kind_icon", "kind", gap = 1 },
                        { "label_description", gap = 1, width = "fill" },
                    },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                return kind_icon
                            end,
                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                        kind = {
                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                    },
                },
                border = "single",
            },
        },
    },
    opts_extend = { "sources.default" },
}
