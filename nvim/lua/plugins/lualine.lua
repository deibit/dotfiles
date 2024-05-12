local colors = require("catppuccin.palettes.macchiato")

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local navic = require("nvim-navic")

        local function get_venv(variable)
            local venv = os.getenv(variable)
            if venv ~= nil and string.find(venv, "/") then
                local orig_venv = venv
                for w in orig_venv:gmatch("([^/]+)") do
                    venv = w
                end
                venv = string.format("%s", venv)
            end
            return venv
        end

        require("lualine").setup({
            options = {
                theme = "auto",
                -- theme = {
                -- 	-- We are going to use lualine_c an lualine_x as left and
                -- 	-- right section. Both are highlighted by c theme .  So we
                -- 	-- are just setting default looks o statusline
                -- 	normal = { c = { fg = colors.fg, bg = colors.bg } },
                -- 	inactive = { c = { fg = colors.fg, bg = colors.bg } },
                -- },
                component_separators = "",
                section_separators = "",
                disabled_filetypes = {
                    statusline = { "neo-tree", "trouble" },
                    winbar = { "neo-tree", "trouble" },
                },
                globalstatus = true,
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { "mode", right_padding = 2 },
                    { "branch", color = { fg = colors.peach } },
                    { "diff" },
                    { "filename", path = 1 },
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                        color = { fg = colors.blue },
                    },
                },
                lualine_x = {
                    "filetype",
                    {
                        function()
                            local venv = get_venv("CONDA_DEFAULT_ENV") or get_venv("VIRTUAL_ENV") or "no env"
                            return venv
                        end,
                        cond = function()
                            return vim.bo.filetype == "python"
                        end,
                        color = { fg = colors.green },
                    },
                    {
                        "diagnostics",

                        -- Table of diagnostic sources, available sources are:
                        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                        -- or a function that returns a table as such:
                        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                        sources = { "nvim_diagnostic" },
                        -- Displays diagnostics for the defined severity types
                        sections = { "error", "warn", "info", "hint" },

                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = { fg = colors.red }, -- Changes diagnostics' error color.
                            warn = { fg = colors.peach }, -- Changes diagnostics' warn color.
                            info = { fg = colors.blue }, -- Changes diagnostics' info color.
                            hint = { fg = colors.yellow }, -- Changes diagnostics' hint color.
                        },
                        colored = true, -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false, -- Show diagnostics even if there are none.
                    },
                    "progress",
                    "searchcount",
                    {
                        "location",
                        left_padding = 2,
                    },
                },
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {
                lualine_a = { { "filename", path = 1 } },
            },
            inactive_winbar = { lualine_a = { { "filename", path = 1 } } },
            extensions = {
                "aerial",
                "fugitive",
                "fzf",
                "lazy",
                "mason",
                "neo-tree",
                "nvim-tree",
                "quickfix",
                "trouble",
            },
        })
    end,
}
