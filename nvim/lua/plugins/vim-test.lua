return {
	"vim-test/vim-test",
	event = { "VeryLazy" },
	dependencies = {
		"tpope/vim-dispatch",
	},
	config = function()
		vim.keymap.set("n", "<leader>Tn", ":TestNearest<CR>", { desc = "カーソルのテストを実行" })
		vim.keymap.set("n", "<leader>Tf", ":TestFile<CR>", { desc = "テストファイルを実行" })
		vim.keymap.set("n", "<leader>Ts", ":TestSuite<CR>", { desc = "テストスイート全体を実行" })
		vim.keymap.set("n", "<leader>Tl", ":TestLast<CR>", { desc = "最後のテストを実行" })
		vim.keymap.set(
			"n",
			"<leader>Tg",
			":TestVisit<CR>",
			{ desc = "最後にテストを実行したファイルにアクセス" }
		)
		vim.cmd("let test#strategy = 'dispatch'")
	end,
}
