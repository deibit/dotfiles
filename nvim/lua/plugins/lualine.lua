return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },

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

            -- colors

            local colors = require("tokyonight.colors").setup({ style = "storm" })

            local modecolor = {
                n = colors.red,
                i = colors.green,
                v = colors.purple,
                [""] = colors.purple,
                V = colors.purple,
                c = colors.yellow,
                no = colors.red,
                s = colors.yellow,
                S = colors.yellow,
                [""] = colors.yellow,
                ic = colors.yellow,
                R = colors.green,
                Rv = colors.purple,
                cv = colors.red,
                ce = colors.red,
                r = colors.purple,
                rm = colors.blue,
                ["r?"] = colors.blue,
                ["!"] = colors.red,
                t = colors.green,
            }

            -- git branch

            local branch = {
                "branch",
                icon = "",
                source = "b:gitsigns_head",
                color = { bg = colors.blue1, fg = colors.bg, gui = "" },
                separator = { right = "" },
            }

            -- simple space

            local space = {
                function()
                    return " "
                end,
                color = { bg = colors.bg, fg = colors.blue },
                separator = {},
            }

            -- filetype

            local filetype = {
                "filetype",
                icons_enabled = true,
                color = { bg = colors.bg, fg = colors.blue, gui = "italic" },
                separator = { right = "" },
            }

            -- filename

            local filename = {
                "filename",
                color = { bg = colors.blue, fg = colors.bg, gui = "" },
                separator = { right = "" },
                path = 1,
            }

            -- location and progress

            local location = {
                "location",
                color = { bg = colors.bg, fg = colors.teal },
                separator = { right = "" },
            }

            local progress = {
                "progress",
                color = { bg = colors.bg, fg = colors.orange },
                separator = { right = "" },
            }

            -- git diff component

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
                color = { bg = "#414868", gui = "" },
                separator = { right = "" },
                symbols = { added = " ", modified = " ", removed = " " },

                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.yellow },
                    removed = { fg = colors.red },
                },
            }

            -- navic

            local navic = {
                "navic",
                color = { fg = colors.red },
                separator = { right = "" },
            }

            -- custom modes

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
                    return { bg = mode_color[vim.fn.mode()], fg = colors.bg, gui = "" }
                end,
                separator = { right = "" },
            }

            -- LSP

            local function getLspName()
                local bufnr = vim.api.nvim_get_current_buf()
                -- local buf_clients = vim.lsp.get_clients()
                local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
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

            local lsp = {
                function()
                    return getLspName()
                end,
                separator = { left = "" },
                color = { bg = colors.green1, fg = colors.bg, gui = "italic" },
            }

            -- diagnostics

            local dia = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                diagnostics_color = {
                    error = { fg = colors.red },
                    warn = { fg = colors.warning },
                    info = { fg = colors.info },
                    hint = { fg = colors.hint },
                },
                color = { bg = colors.bg, fg = colors.blue, gui = "" },
                separator = { left = "" },
            }

            -- python virtualenv name

            local python = {
                function()
                    local python_version = get_venv("PYTHON_VERSION")
                    local venv_name = get_venv("VIRTUAL_ENV_NAME")
                    return string.format("%s (%s)", python_version, venv_name)
                end,
                cond = function()
                    return vim.bo.filetype == "python"
                end,
                color = { fg = colors.bg, bg = colors.green, gui = "" },
                icon = "",
                separator = { right = "" },
            }

            -- treesitter info

            local ts = require("nvim-treesitter")
            local breadcrumb = {
                function()
                    local bc = ts.statusline(90)
                    return bc
                end,
                color = { fg = colors.bg, bg = colors.green, gui = "" },
                separator = { right = "" },
            }

            require("lualine").setup({
                options = {
                    theme = "tokyonight",
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
                        "neo-tree",
                        "trouble",
                        "snacks_picker_list",
                    },
                    globalstatus = false,
                    ignore_focus = { "neo-tree", "snacks_picker_list" },
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = { modes },
                    lualine_b = {},
                    lualine_c = {
                        branch,
                        diff,
                        filetype,
                        -- filename,
                        navic,
                    },
                    lualine_x = {
                        "overseer",
                        "searchcount",
                        "selectioncount",
                    },
                    lualine_y = { dia },
                    lualine_z = { lsp, python },
                },
                inactive_sections = {
                    -- lualine_a = { { "filename", path = 1 } },
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = { lualine_a = { { "filename", path = 1 } } },
                inactive_winbar = { lualine_a = { { "filename", path = 1 } } },
                extensions = {
                    "navic",
                    "mason",
                    "fugitive",
                    "fzf",
                    "lazy",
                    "neo-tree",
                    "quickfix",
                    "trouble",
                },
            })
        end,
    },
}
