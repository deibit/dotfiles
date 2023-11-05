local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keymaps")

-- Lazy configuration
require("lazy").setup({
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"andymass/vim-matchup",
		setup = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"deibit/tmux.nvim",
		config = function()
			require("tmux").setup({})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("plugins.lint")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("plugins.toggleterm")
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
	},
	{ "sainnhe/edge" }, -- colorscheme
	{
		"famiu/bufdelete.nvim",
		keys = {
			{ "<leader>d", "<cmd>Bdelete<cr>", desc = "bufdelete" },
		},
	},
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{ "kylechui/nvim-surround", config = true },
	{ "tpope/vim-obsession" },
	{ "onsails/lspkind.nvim" },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{ "kyazdani42/nvim-web-devicons", config = true },
	{
		"mhartington/formatter.nvim",
		config = function()
			require("plugins.formatter")
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			require("plugins.trouble")
		end,
		lazy = false,
		keys = {
			{ "<leader>tt", "<cmd>TroubleToggle<cr>" },
			{ "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>" },
			{ "<leader>td", "<cmd>Trouble document_diagnostics<cr>" },
			{ "<leader>tl", "<cmd>Trouble loclist<cr>" },
			{ "<leader>tq", "<cmd>Trouble quickfix<cr>" },
			{ "<leader>tr", "<cmd>Trouble lsp_references<cr>" },
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		config = true,
		keys = {
			{ "<leader>2", "<cmd>SymbolsOutline<cr>", desc = "Toggle symbols outline window" },
		},
	},
	{
		"folke/tokyonight.nvim", -- colorscheme
		config = function()
			require("plugins.colorscheme")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp")
		end,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins.cmp")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
		lazy = false,
		keys = {
			-- finders
			{ "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Telescope grep under cursor" },
			{ "<leader>e", "<cmd>Telescope registers<cr>", desc = "Telescope registers" },
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Telescope ls" },
			{ "<leader>r", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
			{
				"<leader><leader>",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Telescope fuzzy find buffer",
			},
			-- pickers
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
			{ "<leader>c", "<cmd>Telescope commands<cr>", desc = "Telescope commands" },
			{ "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
			{ "<leader>k", "<cmd>Telescope man_pages<cr>", desc = "Telescope man pages" },
			{ "<leader>m", "<cmd>Telescope keymaps<cr>", desc = "Telescope keymaps" },
			{ "<leader>o", "<cmd>Telescope oldfiles<cr>", desc = "Telescope old files" },
			-- lsp
			{ "<leader>sa", "<cmd>Telescope diagnostics<cr>", desc = "Telescope diagnostic" },
			{ "<leader>sc", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Telescope lsp incoming calls" },
			{ "<leader>sd", "<cmd>Telescope lsp_definitions<cr>", desc = "Telescope lsp definitions" },
			{ "<leader>si", "<cmd>Telescope lsp_implementations<cr>", desc = "Telescope lsp implementations" },
			{ "<leader>so", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Telescope lsp outgoing calls" },
			{ "<leader>sr", "<cmd>Telescope treesitter<cr>", desc = "Telescope treesitter" },
			{ "<leader>st", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Telescope lsp type definitions" },
			{ "<leader>sx", "<cmd>Telescope lsp_references<cr>", desc = "Telescope lsp references" },
			{ "<leader>sw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Telescope lsp workspace symbols" },
			{ "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope lsp document symbols" },
			-- git
			{ "<leader>gt", "<cmd>Telescope git_stash<cr>", desc = "Telescope git stash" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Telescope git branches" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Telescope git commits" },
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Telescope git ls files" },
			{ "<leader>go", "<cmd>Telescope git_bcommits<cr>", desc = "Telescope git buffer commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Telescope git status" },
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>1", "<cmd>Neotree toggle<cr>", desc = "Neotree" },
		},
		lazy = false,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"chentoast/marks.nvim",
		config = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
		keys = {
			{ "<leader>n", "<cmd>Neogit<cr>", desc = "Neogit" },
		},
	},
})
