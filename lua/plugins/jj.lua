return {
	"nicolasgb/jj.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		require("jj").setup({
			highlights = {
				modified = { fg = "#89ddff" },
			},
			describe_editor = "buffer",
		})

		local cmd = require("jj.cmd")

		-- peak right here??
		vim.keymap.set("n", "<leader>jd", cmd.describe, { desc = "JJ describe" })
		vim.keymap.set("n", "<leader>jl", cmd.log, { desc = "JJ log" })
		vim.keymap.set("n", "<leader>je", cmd.edit, { desc = "JJ edit" })
		vim.keymap.set("n", "<leader>jn", cmd.new, { desc = "JJ new" })
		vim.keymap.set("n", "<leader>js", cmd.status, { desc = "JJ status" })
		vim.keymap.set("n", "<leader>dj", cmd.diff, { desc = "JJ diff" })
		vim.keymap.set("n", "<leader>sj", cmd.squash, { desc = "JJ squash" })

		local picker = require("jj.picker")
		vim.keymap.set("n", "<leader>gj", picker.status, { desc = "JJ Picker status" })
		vim.keymap.set("n", "<leader>gl", picker.file_history, { desc = "JJ Picker file history" })

		vim.keymap.set("n", "<leader>jL", function()
			cmd.log({ revisions = "all()" })
		end, { desc = "JJ log all" })

		vim.keymap.set("n", "<leader>jt", function()
			cmd.j("tug")
			cmd.log({})
		end, { desc = "JJ tug" })
	end,
}
