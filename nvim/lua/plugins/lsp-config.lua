return {
	{
		"williamboman/mason.nvim",
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "djlsp", "jedi_language_server", "tsserver", "jdtls", "cssls" },
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test" },
				handlers = {},
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
			"ray-x/lsp_signature.nvim",
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			vim.list_extend(keys, {
				{
					"gd",
					function()
						require("telescope.builtin").lsp_definitions({ reuse_win = false })
					end,
					desc = "Goto Definition",
					has = "definition",
				},
			})

			opts.on_attach = function(client, bufnr)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })

				vim.api.nvim_create_autocmd("CursorHold", {
					buffer = bufnr,
					callback = function()
						local params = vim.lsp.util.make_position_params()
						vim.lsp.buf_request(bufnr, "textDocument/hover", params, function(err, result, ctx, config)
							if err or not result then
								return
							end
							vim.lsp.util.focusable_float("hover", function()
								vim.lsp.util.open_floating_preview(result.contents, "markdown", config)
							end)
						end)
					end,
				})
			end

			vim.o.updatetime = 2000
		end,
	},
}
