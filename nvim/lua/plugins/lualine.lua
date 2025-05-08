-- colors

local colors = {
    red = "#A52A2A",
    green = "#7FFF00",
    purple = "#8A2BE2",
    yellow = "#FFD700",
    blue = "#1E90FF",
    teal = "#20B2AA",
    bg = "#242640",
    fg = "#A9A9A9",
}

local theme = {
    normal = { a = { bg = colors.bg }, b = { bg = colors.bg }, c = { bg = colors.bg } },
    insert = { a = { bg = colors.bg }, b = { bg = colors.bg }, c = { bg = colors.bg } },
    inactive = { a = { bg = colors.bg }, b = { bg = colors.bg }, c = { bg = colors.bg } },
    command = { a = { bg = colors.bg }, b = { bg = colors.bg }, c = { bg = colors.bg } },
    visual = { a = { bg = colors.bg }, b = { bg = colors.bg }, c = { bg = colors.bg } },
    replace = { a = { bg = colors.bg }, b = { bg = colors.bg }, c = { bg = colors.bg } },
}

return {
    {
        "nvim-lualine/lualine.nvim",
        options = { theme = theme },
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

            -- separators

            -- local right_separator = ""
            -- local left_separator = ""
            local right_separator = ""
            local left_separator = ""

            -- git branch

            local branch = {
                "branch",
                icon = "",
                color = { bg = colors.bg },
                separator = { right = right_separator },
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
                separator = { right_separator },
            }

            -- filename

            local filename = {
                "filename",
                color = { bg = colors.blue, fg = colors.bg, gui = "" },
                separator = { right_separator },
                path = 1,
            }

            -- location and progress

            local location = {
                "location",
                color = { bg = colors.bg, fg = colors.teal },
                separator = { right_separator },
            }

            local progress = {
                "progress",
                color = { bg = colors.bg, fg = colors.orange },
                separator = { right_separator },
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
                separator = { right_separator },
                color = { bg = colors.bg },
                symbols = { added = " ", modified = " ", removed = " " },

                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.yellow },
                    removed = { fg = colors.red },
                },
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
                separator = { right_separator },
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
                separator = { left_separator },
                color = { bg = colors.bg, fg = colors.purple, gui = "italic" },
            }

            -- diagnostics

            local dia = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                color = { bg = colors.bg },
                diagnostics_color = {
                    error = { fg = colors.red },
                    warn = { fg = colors.warning },
                    info = { fg = colors.info },
                    hint = { fg = colors.hint },
                },
                separator = { left_separator },
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
                color = { bg = colors.bg, fg = colors.green, gui = "" },
                icon = "",
                separator = { right_separator },
            }

            -- macro recording
            local function macro_recording()
                local recording_register = vim.fn.reg_recording()
                if recording_register == "" then
                    return ""
                else
                    return "🔴 @" .. recording_register
                end
            end

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
                    lualine_a = { macro_recording, modes },
                    lualine_b = {},
                    lualine_c = {
                        branch,
                        diff,
                        filetype,
                        -- filename,
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
                    "mason",
                    "fugitive",
                    "fzf",
                    "lazy",
                    "quickfix",
                    "trouble",
                },
            })
        end,
    },
}
