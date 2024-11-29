return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup()

		vim.keymap.set("n", "<C-.>", function()
			return vim.v.count == 0 and "gcc" or "gc" .. vim.v.count
		end, { expr = true, noremap = true, silent = true, desc = "Toggle comment" })

		vim.keymap.set("x", "<C-.>", "gc", { noremap = true, silent = true, desc = "Toggle comment (visual)" })
	end,
}
