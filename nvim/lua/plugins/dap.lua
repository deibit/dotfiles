return {

    -- ======================
    -- Core DAP
    -- ======================
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- UI
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
            },

            -- Virtual text
            {
                "theHamsta/nvim-dap-virtual-text",
            },

            -- Python helper
            {
                "mfussenegger/nvim-dap-python",
            },

            -- Mason integration
            {
                "jay-babu/mason-nvim-dap.nvim",
            },
        },

        config = function()
            local dap = require("dap")

            -- ======================
            -- Mason DAP
            -- ======================
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "lldb", -- C / C++ / Rust
                    "python", -- debugpy
                },
                automatic_installation = true,
            })

            -- ======================
            -- LLDB adapter
            -- ======================
            dap.adapters.lldb = {
                type = "executable",
                command = "lldb-vscode", -- Mason lo pone en PATH
                name = "lldb",
            }

            -- ======================
            -- C / C++ / Rust configs
            -- ======================
            local lldb_config = {
                name = "Launch (LLDB)",
                type = "lldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path al ejecutable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            }

            dap.configurations.c = { lldb_config }
            dap.configurations.cpp = { lldb_config }
            dap.configurations.rust = { lldb_config }

            -- ======================
            -- Python (debugpy)
            -- ======================
            require("dap-python").setup("python") -- usa venv activa si existe

            -- Opcional: pytest
            -- require("dap-python").test_runner = "pytest"

            -- ======================
            -- DAP UI
            -- ======================
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- ======================
            -- Virtual text
            -- ======================
            require("nvim-dap-virtual-text").setup({
                commented = true,
            })

            -- ======================
            -- Keymaps
            -- ======================
            local map = vim.keymap.set
            map("n", "<F5>", dap.continue, { desc = "dap: continue" })
            map("n", "<F10>", dap.step_over, { desc = "dap: step over" })
            map("n", "<F11>", dap.step_into, { desc = "dap: step into" })
            map("n", "<F12>", dap.step_out, { desc = "dap: step out" })

            map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "dap: toggle bp" })
            map("n", "<Leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "dap: bp condition" })

            map("n", "<Leader>dr", dap.repl.open, { desc = "dap: open repl" })
            map("n", "<Leader>dl", dap.run_last, { desc = "dap: run last" })
        end,
    },
}
