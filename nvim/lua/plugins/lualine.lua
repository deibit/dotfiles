return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            theme = "auto",
            -- theme = {
            -- 	-- We are going to use lualine_c an lualine_x as left and
            -- 	-- right section. Both are highlighted by c theme .  So we
            -- 	-- are just setting default looks o statusline
            -- 	normal = { c = { fg = colors.fg, bg = colors.bg } },
            -- 	inactive = { c = { fg = colors.fg, bg = colors.bg } },
            -- },
            icons_enabled = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = { "neo-tree", "trouble" },
                winbar = { "neo-tree", "trouble" },
            },
            globalstatus = true,
            ignore_focus = {},
            always_divide_middle = true,
        },

        config = function()
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

            local colors = require("catppuccin.palettes.macchiato")

            local modecolor = {
                n = colors.sky,
                i = colors.green,
                v = colors.mauve,
                [""] = colors.mauve,
                V = colors.mauve,
                c = colors.yellow,
                no = colors.red,
                s = colors.yellow,
                S = colors.yellow,
                [""] = colors.yellow,
                ic = colors.yellow,
                R = colors.green,
                Rv = colors.mauve,
                cv = colors.red,
                ce = colors.red,
                r = colors.mauve,
                rm = colors.sky,
                ["r?"] = colors.sky,
                ["!"] = colors.red,
                t = colors.green,
            }

            local space = {
                function()
                    return " "
                end,
                color = { bg = colors.base, fg = colors.blue },
                separator = {},
            }

            local filename = {
                "filename",
                color = { bg = colors.blue, fg = colors.surface0, gui = "bold" },
                separator = { left = "", right = "" },
                path = 1,
            }

            local filetype = {
                "filetype",
                icons_enabled = true,
                color = { bg = colors.gray2, fg = colors.blue, gui = "italic,bold" },
                separator = { left = "", right = "" },
            }

            local branch = {
                "branch",
                icon = "",
                source = "b:gitsigns_head",
                color = { bg = colors.mauve, fg = colors.base, gui = "bold" },
                separator = { left = "", right = "" },
            }

            local location = {
                "location",
                color = { bg = colors.peach, fg = colors.surface0, gui = "bold" },
                separator = { left = "", right = "" },
            }

            local progress = {
                "progress",
                color = { bg = colors.sapphire, fg = colors.surface0, gui = "bold" },
                separator = { left = "", right = "" },
            }

            local function diff_source()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed,
                    }
                end
            end

            local diff = {
                "diff",
                source = diff_source,
                color = { bg = colors.gray1, fg = colors.teal, gui = "bold" },
                separator = { left = "", right = "" },
                symbols = { added = " ", modified = " ", removed = " " },

                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.yellow },
                    removed = { fg = colors.red },
                },
            }

            local mode_map = {
                ["NORMAL"] = "NORM",
                ["O-PENDING"] = "N?",
                ["INSERT"] = "INS",
                ["VISUAL"] = "V",
                ["V-BLOCK"] = "VB",
                ["V-LINE"] = "VL",
                ["V-REPLACE"] = "VR",
                ["REPLACE"] = "R",
                ["COMMAND"] = "$",
                ["SHELL"] = "",
                ["TERMINAL"] = "",
                ["EX"] = "X",
                ["S-BLOCK"] = "SB",
                ["S-LINE"] = "SL",
                ["SELECT"] = "S",
                ["CONFIRM"] = "Y?",
                ["MORE"] = "M",
            }

            local modes = {
                "mode",
                fmt = function(s)
                    return mode_map[s] or s
                end,
                color = function()
                    local mode_color = modecolor
                    return { bg = mode_color[vim.fn.mode()], fg = colors.base, gui = "bold" }
                end,
                separator = { left = "", right = "" },
            }

            local function getLspName()
                -- local bufnr = vim.api.nvim_get_current_buf()
                local buf_clients = vim.lsp.get_clients()
                -- local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
                -- local buf_ft = vim.bo.filetype
                if next(buf_clients) == nil then
                    return "  No servers"
                end
                local buf_client_names = {}

                for _, client in pairs(buf_clients) do
                    table.insert(buf_client_names, client.name)
                end
                local hash = {}
                local unique_client_names = {}

                for _, v in ipairs(buf_client_names) do
                    if not hash[v] then
                        unique_client_names[#unique_client_names + 1] = v
                        hash[v] = true
                    end
                end
                local language_servers = table.concat(unique_client_names, ", ")

                return "  " .. language_servers
            end

            local dia = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                diagnostics_color = {
                    error = { fg = colors.red },
                    warn = { fg = colors.yellow },
                    info = { fg = colors.maeve },
                    hint = { fg = colors.sapphire },
                },
                color = { bg = colors.base, fg = colors.blue, gui = "bold" },
                separator = { left = "", right = "" },
            }

            local lsp = {
                function()
                    return getLspName()
                end,
                separator = { left = "", right = "" },
                color = { bg = colors.rosewater, fg = colors.bg, gui = "italic,bold" },
            }

            local python = {
                function()
                    local python_version = get_venv("PYTHON_VERSION")
                    local venv_name = get_venv("VIRTUAL_ENV_NAME")
                    return string.format("%s (%s)", python_version, venv_name)
                end,
                cond = function()
                    return vim.bo.filetype == "python"
                end,
                color = { fg = colors.surface0, bg = colors.green, gui = "bold" },
                icon = "",
                separator = { left = "", right = "" },
            }

            require("lualine").setup({
                sections = {
                    lualine_a = { modes },
                    lualine_b = { space },
                    lualine_c = {
                        branch,
                        filetype,
                        filename,
                    },
                    lualine_x = {
                        "overseer",
                        "searchcount",
                        "selectioncount",
                    },
                    lualine_y = { diff },
                    lualine_z = { dia, lsp, python },
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
                    "mason",
                    "fugitive",
                    "fzf",
                    "lazy",
                    "neo-tree",
                    "nvim-tree",
                    "quickfix",
                    "trouble",
                },
            })
        end,
    },
}
