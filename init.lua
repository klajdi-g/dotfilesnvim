vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.opt.clipboard = "unnamedplus"

require("lazy").setup("plugins")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
-- vim.opt.guifont = "JetBrainsMono Nerd Font:h13"

-- vim.cmd("colorscheme enough")

vim.defer_fn(function()
	require("lsp")
	require("cmpconfig")
	require("keymaps")
end, 10)
