return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},

	{
		"hrsh7th/cmp-nvim-lsp",
	},

	{
		"petertriho/cmp-git",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("cmp_git").setup()
		end,
	},
	{
		"hrsh7th/cmp-emoji",
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"petertriho/cmp-git",
			"hrsh7th/cmp-emoji",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = {
					competeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "git" },
					{ name = "emoji" },
				}),
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
					{ name = "buffer" },
				}),
			})
		end,
	},
}
