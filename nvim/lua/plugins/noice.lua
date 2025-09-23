return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTranjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("notify").setup({
			background_colour = "#000000",
		})
		require("noice").setup({
			messages = {
				view = "mini",
				view_search = "mini",
			},
			notify = {
				view = "mini",
			},
			lsp = {
				view = "notify",
				progress = {
					view = "mini",
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 1000 / 30, -- frequency to update lsp progress message
				},
			},
		})
	end,
}
