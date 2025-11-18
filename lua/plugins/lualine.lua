return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "tokyonight",
				component_separators = "",
				section_separators = "",
				icons_enabled = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "filename" },
				lualine_x = { "diagnostics" },
				lualine_y = { "filetype" },
				lualine_z = { "location" },
			},
		})
	end,
}
