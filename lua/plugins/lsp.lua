return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.declaration,
					{ desc = "[G]o [D]eclaration", buffer = ev.buf })

				vim.keymap.set("n", "<leader>fb", function()
					vim.lsp.buf.format({ async = true })
				end, { desc = "[F]ormat [B]uffer", buffer = ev.buf })
			end
		})

		local signature_opts = {
			hint_prefix = "",
		}

		local caps = require('cmp_nvim_lsp').default_capabilities()
		require("mason").setup()
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = {}
					server.capabilities = vim.tbl_deep_extend("force", {}, caps,
						server.capabilities or {})

					server.on_attach = function(client, buffer)
						require("lsp_signature").on_attach(signature_opts, buffer)
					end
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
