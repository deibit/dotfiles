return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")

		toggleterm.setup()

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			vim.keymap.set("t", "<C-left>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-down>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-up>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-right>", [[<Cmd>wincmd l<CR>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		-- Example command to spawn a new terminal and executing an external programs
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "double",
			},
			-- function to run on opening the terminal
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			-- function to run on closing the terminal
			on_close = function(term)
				vim.cmd("startinsert!")
			end,
		})
		function _lazygit_toggle()
			lazygit:toggle()
		end
	end,
	keys = {
		{ "<C-t>", "<cmd>ToggleTerm<CR>", desc = "ToogleTerm", noremap = true, silent = true },
		{
			"<leader>T",
			"<cmd>ToggleTerm direction=float size=80<CR>",
			desc = "ToggleTerm float",
			noremap = true,
			silent = true,
		},
		{
			"<leader>l",
			"<cmd>lua _lazygit_toggle()<cr>",
			desc = "Lazygit",
			noremap = true,
			silent = true,
		},
	},
	lazy = false,
}
