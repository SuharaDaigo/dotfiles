-- Neovimの起動時に補完ウィンドウの色をカスタマイズする
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd([[
            highlight Pmenu ctermbg=darkgray guibg=#3C3836 guifg=#EBDBB2
            highlight PmenuSel ctermbg=gray guibg=#458588
            highlight PmenuSbar guibg=#3C3836
            highlight PmenuThumb guibg=#83a598

            " whichkeyの補完
            highlight NormalFloat guifg=#FFFFFF guibg=#00000000
            " lspSagaの詳細
            highlight FloatBorder guifg=#FFFFFF guibg=#00000000
        ]])
	end,
})
