return {
	"nvimdev/lspsaga.nvim",
	lazy = false,
	keys = {
		{
			"<leader>sd",
			"<cmd>Lspsaga hover_doc<CR>",
			noremap = true,
			desc = "カーソル下の変数/関数の情報を表示",
		},
		-- {
		-- 	"<leader>sf",
		-- 	"<cmd>Lspsaga lsp_finder<CR>",
		-- 	noremap = true,
		-- 	desc = "変数/関数の一覧を表示",
		-- },
		{
			"<leader>sa",
			"<cmd>Lspsaga code_action<CR>",
			noremap = true,
			desc = "実行可能な修正の候補を表示",
		},
		{
			"<leader>sp",
			"<cmd>Lspsaga peek_definition<CR>",
			noremap = true,
			desc = "変数/関数の定義元を表示",
		},
		{
			"<leader>sg",
			"<cmd>Lspsaga goto_definition<CR>",
			noremap = true,
			desc = "変数/関数の定義元へ移動",
		},
		{
			"<leader>sn",
			"<cmd>Lspsaga rename<CR>",
			noremap = true,
			desc = "変数/関数の名前を一括変更",
		},
		{
			"<leader>se",
			"<cmd>Lspsaga show_line_diagnostics<CR>",
			noremap = true,
			desc = "Error/Warmを表示",
		},
		{
			"<leader>sn",
			"<cmd>Lspsaga diagnostice_jump_next<CR>",
			noremap = true,
			desc = "Error/Warmに移動",
		},
		{
			"<leader>sn",
			"<cmd>Lspsaga diagnostice_jump_next<CR>",
			noremap = true,
			desc = "Error/Warmに移動",
		},
	},
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enable = false,
			},
			ui = {
				border = "rounded",
				title = true,
				devicon = true,
			},
			lightbulb = {
				enable = false,
			},
			show_outline = {
				--win_width = 50,
				auto_preview = false,
				layout = "float",
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
