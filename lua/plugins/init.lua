return {
	{
		"github/copilot.vim",
		config = function()
			-- Disable Tab mapping
			vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

			-- Cycle suggestions safely
			vim.api.nvim_set_keymap("i", "<C-j>", "copilot#Next()", { silent = true, expr = true })
			vim.api.nvim_set_keymap("i", "<C-k>", "copilot#Previous()", { silent = true, expr = true })

			-- Dismiss
			vim.api.nvim_set_keymap("i", "<C-\\>", "copilot#Dismiss()", { silent = true, expr = true })
		end,
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},

	{ "folke/tokyonight.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },

	{ "stevearc/conform.nvim" },

	{
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vesper").setup({
				transparent = false,
				italics = {
					comments = true,
					keywords = true,
					functions = true,
					strings = true,
					variables = true,
				},
				overrides = {},
				palette_overrides = {},
			})

			vim.cmd("colorscheme vesper")
		end,
	},
}
