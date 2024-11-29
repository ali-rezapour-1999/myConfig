local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "nh", ":nohl<CR>")
keymap.set("n", ";;", ":w<Enter>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

keymap.set("n", "dw", 'vb"_d')

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>") -- increment
keymap.set("n", "-", "<C-x>") -- decrement

-- window management
keymap.set("n", "sv", "<C-w>v") -- split window vertically
keymap.set("n", "sh", "<C-w>s") -- split window horizontally
keymap.set("n", "se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "cl", ":q") -- close current split window

keymap.set("n", "to", ":tabnew<CR>") -- open new tab
keymap.set("n", "cl", ":q<Enter>") -- close current tab
keymap.set("n", "tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "tp", ":tabp<CR>") --  go to previous tab
keymap.set("n", "te", ":tabedit")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree

keymap.set("n", "<Space>", "<C-w>w")
keymap.set("n", "nm", ":Neotree filesystem reveal toggle left<CR>", {})

-- telescope
keymap.set("n", "ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "gfc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "gc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

keymap.set("n", "<C-k>", function()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
		if not result or vim.tbl_isempty(result) then
			print("No definition found!")
			return
		end

		local target = result[1] or result
		local uri = target.uri or target.targetUri
		local range = target.range or target.targetSelectionRange
		local current_uri = vim.uri_from_bufnr(0)

		if uri == current_uri then
			local row = range.start.line + 1
			local col = range.start.character + 1
			vim.api.nvim_win_set_cursor(0, { row, col })
		else
			vim.cmd("tabedit")
			vim.lsp.util.jump_to_location(target, "utf-8")
		end
	end)
end, { noremap = true, silent = true, desc = "Go to definition, open in new tab" })

keymap.set("n", "<C-kk>", function()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
		if not result or vim.tbl_isempty(result) then
			print("No definition found!")
			return
		end

		local target = result[1] or result
		local uri = target.uri or target.targetUri
		local range = target.range or target.targetSelectionRange
		local current_uri = vim.uri_from_bufnr(0)

		if uri == current_uri then
			local row = range.start.line + 1
			local col = range.start.character + 1
			vim.api.nvim_win_set_cursor(0, { row, col })
		else
			vim.cmd("vsplit")
			vim.lsp.util.jump_to_location(target, "utf-8")
		end
	end)
end, { noremap = true, silent = true, desc = "Go to definition, open in split" })

keymap.set("n", "<C-1>", ":split | terminal ./mvnw spring-boot:run<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-2>", ":split | terminal mvn clean install -DskipTests=true<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-3>", ":split | terminal ./mvnw spring-boot:run<CR>", { noremap = true, silent = true })

keymap.set("n", "rss", ":LspRestart<CR>")
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<C-CR>", function()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
		if not result or vim.tbl_isempty(result) then
			print("No definition found")
			return
		end

		local target = result[1]
		local uri = target.uri or target.targetUri
		local range = target.range or target.targetRange

		local path = vim.uri_to_fname(uri)

		vim.cmd("tabnew " .. path)

		vim.fn.cursor(range.start.line + 1, range.start.character + 1)
	end)
end, { desc = "Open module definition in a new tab if available" })
