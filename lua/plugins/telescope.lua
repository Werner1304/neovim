return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local t = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", t.find_files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader><space>", t.buffers, { desc = "[F]ind Buffer" })
	end,
}
