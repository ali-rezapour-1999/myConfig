return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "nn", ":Neotree filesystem reveal toggle left<CR>", {})
		vim.keymap.set("n", "fb", ":Neotree buffers reveal toggle float<CR>", {})
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				require("neo-tree").show("filesystem")
			end,
		})
	end,
}
