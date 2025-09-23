-- ヘルパー関数を定義
local utils = {}

-- OSがWindowsかどうかを判定する関数
utils.is_windows = function()
	return vim.loop.os_uname().version:match("Windows") ~= nil
end

-- パスを結合する関数
utils.path_join = function(...)
	return table.concat({ ... }, utils.is_windows() and "\\" or "/")
end

-- 定数を定義
local constants = {}
constants.PLUGIN_NAME = "remote-nvim"

return {
	"amitds1997/remote-nvim.nvim",
	version = "*", -- GitHubのリリースにピン留め
	dependencies = {
		"nvim-lua/plenary.nvim", -- 標準関数
		"MunifTanjim/nui.nvim", -- プラグインのUI構築に使用
		"nvim-telescope/telescope.nvim", -- 複数のリモート方法を選択するために使用
	},
	event = { "VeryLazy" },
	keys = {
		{
			"<leader>rs",
			"<cmd>RemoteStart<CR>",
			noremap = true,
			desc = "リモート接続開始",
		},
	},

	config = function()
		-- Configuration for devpod connections
		local devpod_config = {
			binary = "devpod", -- DevPod用のバイナリ
			docker_binary = "docker", -- Docker関連のコマンドに使うバイナリ
			ssh_config_path = utils.path_join(vim.fn.stdpath("data"), constants.PLUGIN_NAME, "ssh_config"), -- DevPodのSSH設定ファイルの保存パス
			search_style = "current_dir_only", -- Devcontainersの検索方法
			tfiles = {
				path = nil, -- Devcontainerにコピーされるdotfilesのパス
				install_script = nil, -- dotfilesをインストールするスクリプト
			},
			gpg_agent_forwarding = false, -- GPGエージェントの転送
			container_list = "running_only", -- Dockerコンテナのリスト方法（"running_only" または "all"）
		}

		-- Configuration for SSH connections
		local ssh_config = {
			ssh_binary = "ssh", -- SSHコマンド用のバイナリ
			scp_binary = "scp", -- SCPコマンド用のバイナリ
			ssh_config_file_paths = { "$HOME/.ssh/config" }, -- SSHホスト設定を含むファイルパス
			ssh_prompts = {
				{
					match = "Enter passphrase for key",
					type = "secret", -- パスフレーズはシークレットとして扱う
					value_type = "static", -- 毎回新しいパスフレーズを入力する
					value = "", -- 初期値を空に設定
				},
				{
					match = "password:",
					type = "secret",
					value_type = "static",
					value = "",
				},
				{
					match = "continue connecting (yes/no/[fingerprint])?",
					type = "plain",
					value_type = "static",
					value = "",
				},
			},
		}

		-- プログレスビューの設定
		local progress_view = {
			type = "popup", -- プラグイン進捗表示の形式（"popup"または"split"）
		}

		-- オフラインモードの設定
		local offline_mode = {
			enabled = false, -- オフラインモードを有効にするかどうか
			no_github = false, -- GitHubへの接続を無効化
			cache_dir = utils.path_join(vim.fn.stdpath("cache"), constants.PLUGIN_NAME, "version_cache"),
		}

		-- リモート設定
		local remote_config = {
			app_name = "nvim", -- Neovimのアプリ名
			copy_dirs = {
				config = {
					base = vim.fn.stdpath("config"), -- ローカルの設定ディレクトリのパス
					dirs = "*", -- すべてのディレクトリをコピー
					compression = {
						enabled = false,
						additional_opts = {}, -- 圧縮のオプション
					},
				},
				data = {
					base = vim.fn.stdpath("data"),
					dirs = {},
					compression = {
						enabled = true,
					},
				},
				cache = {
					base = vim.fn.stdpath("cache"),
					dirs = {},
					compression = {
						enabled = true,
					},
				},
				state = {
					base = vim.fn.stdpath("state"),
					dirs = {},
					compression = {
						enabled = true,
					},
				},
			},
		}

		-- ローカルクライアントのコールバック
		local client_callback = function(port, _)
			require("remote-nvim.ui").float_term(
				("nvim --server localhost:%s --remote-ui"):format(port),
				function(exit_code)
					if exit_code ~= 0 then
						vim.notify(("Local client failed with exit code %s"):format(exit_code), vim.log.levels.ERROR)
					end
				end
			)
		end

		-- 全体の設定
		require("remote-nvim").setup({
			devpod = devpod_config,
			ssh_config = ssh_config,
			progress_view = progress_view,
			offline_mode = offline_mode,
			remote = remote_config,
			client_callback = client_callback,
		})
	end,
}
