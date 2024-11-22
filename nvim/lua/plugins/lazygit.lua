return {
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("lazygit").setup()
		end,
		keys = {
			{ "gl", ":LazyGit<CR>", desc = "Open Lazygit" },
		},
	},
}
