-- ファイル
vim.opt.fileencoding = "utf-8" -- UTF-8に設定
vim.opt.swapfile = false
vim.opt.hidden = true -- バッファ切り替え時にファイルの保存不要

-- クリップボード共有
vim.opt.clipboard = "unnamedplus"

-- メニューとコマンド
vim.opt.cmdheight = 1 -- コマンドラインの表示行数
vim.opt.showcmd = true -- コマンドラインに入力されたコマンドを表示

-- ステータス系非表示に
vim.opt.laststatus = 0 -- 下部にステータスラインを表示
vim.opt.fillchars = { stl = "─", stlnc = "─" }
vim.opt.statusline = "─"
vim.o.ruler = false

-- 検索・置換え
vim.opt.hlsearch = false -- ハイライト検索を有効
vim.opt.incsearch = true -- インクリメンタルサーチを有効
vim.opt.matchtime = 1 -- 入力された文字列がマッチするまでにかかる時間

-- カラースキーム
vim.opt.termguicolors = true -- 24 ビットカラーを使用

-- インデント

vim.opt.shiftwidth = 4 -- シフト幅を4に設定する
vim.opt.tabstop = 4 -- タブ幅を4に設定する
vim.opt.expandtab = true -- タブ文字をスペースに置き換える
vim.opt.autoindent = true -- 自動インデントを有効にする
vim.opt.smartindent = true -- インデントを言語に合わせて調整する

-- 表示
vim.opt.number = true -- 行番号を表示
vim.opt.cursorline = false -- 現在行ハイライト無効
vim.opt.relativenumber = false -- 相対行番号を非表示
vim.opt.wrap = false -- テキストの自動折り返しを無効に
vim.opt.showtabline = 2 -- タブラインを表示
vim.opt.visualbell = true -- ビープ音を表示する代わりに画面をフラッシュ
vim.opt.showmatch = true -- 対応する括弧をハイライト表示
vim.opt.list = true -- 不可視文字を表示
vim.opt.scrolloff = 15 -- 上下から15行まで行ったら自動でスクロール

-- インタフェース
vim.opt.winblend = 5 -- ウィンドウの不透明度
vim.opt.pumblend = 5 -- ポップアップメニューの不透明度
vim.opt.signcolumn = "yes" -- 行数の横にサインカラムを表示
