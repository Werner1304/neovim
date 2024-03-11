return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup()
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<leader>t", api.tree.toggle, { desc = "Open [T]ree" })
	end,
}
