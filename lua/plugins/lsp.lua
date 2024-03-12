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

		local my_on_attach = function(client, buffer)
			require("lsp_signature").on_attach(signature_opts, buffer)
		end

		local caps = require('cmp_nvim_lsp').default_capabilities()
		require("mason").setup()
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = {}
					server.capabilities = caps
					server.on_attach = my_on_attach
					require("lspconfig")[server_name].setup(server)
				end,
				["gopls"] = function()
					local server = {}
					server.capabilities = caps
					server.on_attach = my_on_attach
					server.settings = {
						gopls = {
							semanticTokens = true,
						},
					}
					require("lspconfig")["gopls"].setup(server)
				end,
			},
		})
	end,
}
