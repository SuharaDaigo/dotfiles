return {
	"hrsh7th/nvim-cmp",
	event = "VeryLazy",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for auto completion
		"rafamadriz/friendly-snippets", -- snippets
		"onsails/lspkind.nvim", -- vs_code like pictograms
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- 開いているファイルのスニペットを編集
		vim.keymap.set("n", "<leader>e", require("luasnip.loaders").edit_snippet_files, { desc = "Edit snippets" })

		require("luasnip.loaders.from_vscode").load({ paths = { "~/.config/nvim/my_snippets" } })

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "c" }),
				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "c" }),
			}),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					optinon = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(), -- 補完ウィンドウに枠線をつける
				documentation = cmp.config.window.bordered(), -- ドキュメントウィンドウに枠線をつける
			},
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),

			-- configure lspkind for vs_code like pictograms is completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "text",
					maxwidth = 70,
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default
					preset = "codicons",
					symbol_map = { Copilot = "" },
				}),
			},
		})
	end,
}
