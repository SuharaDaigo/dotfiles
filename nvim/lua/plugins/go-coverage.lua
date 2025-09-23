return {
	"kyoh86/vim-go-coverage",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>Tc", ":GoCover<CR>", { desc = "カバレッジを表示" })
		vim.keymap.set("n", "<leader>TC", ":GoCoverClearAll<CR>", { desc = "カバレッジを消去" })
	end,
}
