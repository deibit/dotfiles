return {
    "saghen/blink.cmp",
    dependencies = { "onsails/lspkind.nvim" },
    build = "cargo +nightly build --release",
    event = "InsertEnter",
    -- optional: provides snippets for the snippet source
    -- dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = {
            preset = "none", -- IMPORTANTE: desactiva presets por defecto

            -- Navegación del menú
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },

            -- Confirmar selección
            ["<CR>"] = { "accept", "fallback" },

            -- Opcional pero recomendable
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<Esc>"] = { "hide", "fallback" },
        },
        -- cmdline = {
        --     keymap = {
        --         preset = "default",
        --         ["<Tab>"] = { "select_next", "fallback" },
        --         ["<S-Tab>"] = { "select_prev", "fallback" },
        --         ["<CR>"] = { "accept_and_enter", "fallback" },
        --         ["<C-c>"] = { "cancel" },
        --     },
        -- },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        signature = { enabled = false, window = { border = "single" } },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "lazydev" },

            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
                path = {
                    opts = {
                        get_cwd = function(_)
                            return vim.fn.getcwd()
                        end,
                    },
                },
                lsp = { fallbacks = {} },
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
                        -- { "source_name" },
                    },
                    treesitter = { "lsp" },
                    -- from https://main.cmp.saghen.dev/recipes#nvim-web-devicons-lspkin
                    -- later, from: https://github.com/onsails/lspkind.nvim/issues/90#issuecomment-2547614143
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, {
                                        mode = "symbol",
                                    })
                                end

                                return icon .. ctx.icon_gap
                            end,

                            -- Optionally, use the highlight groups from nvim-web-devicons
                            -- You can also add the same function for `kind.highlight` if you want to
                            -- keep the highlight groups in sync with the icons.
                            highlight = function(ctx)
                                local hl = "BlinkCmpKind" .. ctx.kind
                                    or require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
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
