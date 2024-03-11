vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.keymap.set("", "<Space>", "<Nop>")
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show [E]rror messages" })

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

require("lazy").setup("plugins")

vim.cmd("colorscheme kanagawa")

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({})
	end,
})

vim.keymap.set("n", "<leader>sv", function()
	vim.cmd("vsplit")
end, { desc = "[S]plit [V]ertical" })

vim.keymap.set("n", "<leader>sh", function()
	vim.cmd("split")
end, { desc = "[S]plit [H]orizontal" })

vim.keymap.set("n", "<A-up>", function()
	vim.cmd("m .-2")
end, {})

vim.keymap.set("n", "<A-down>", function()
	vim.cmd("m .+1")
end, {})
