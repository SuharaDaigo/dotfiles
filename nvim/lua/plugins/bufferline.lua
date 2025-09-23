return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile", "BufEnter" },
	config = function()
		-- キャッシュ用変数
		local git_info = {
			repo_name = nil,
			branch = nil,
			is_dirty = nil,
			last_check = nil,
		}

		-- キャッシュをクリアする関数
		local function clear_git_cache()
			git_info.repo_name = nil
			git_info.branch = nil
			git_info.is_dirty = nil
			git_info.last_check = nil
		end

		-- バッファが切り替わったときにキャッシュをクリアする
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = clear_git_cache,
		})

		local function git_repo_name()
			if git_info.repo_name then
				return git_info.repo_name
			end

			local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null")
			if vim.v.shell_error ~= 0 then
				git_info.repo_name = ""
			else
				git_info.repo_name = vim.fn.fnamemodify(git_root, ":t"):gsub("^%s*(.-)%s*$", "%1")
			end

			git_info.last_check = os.time()
			return git_info.repo_name
		end

		local function git_branch()
			if git_info.branch then
				return git_info.branch
			end

			local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
			if vim.v.shell_error ~= 0 then
				git_info.branch = ""
			else
				git_info.branch = branch:gsub("^%s*(.-)%s*$", "%1")
			end

			git_info.last_check = os.time()
			return git_info.branch
		end

		local function git_is_dirty()
			if git_info.is_dirty ~= nil then
				return git_info.is_dirty
			end

			local status = vim.fn.system("git status --porcelain 2>/dev/null")
			git_info.is_dirty = #status > 0
			git_info.last_check = os.time()

			return git_info.is_dirty
		end

		require("bufferline").setup({
			highlights = {
				fill = {
					fg = "#546546",
					bg = "",
				},
				buffer_selected = {
					bg = "#458588",
					bold = true,
				},
				buffer = {
					fg = "#546546",
					bg = "",
					bold = true,
				},
			},
			options = {
				indicator = {},
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				diagnostics = "none",
				separator_style = {},
				max_name_lengh = 14,
				show_buffer_icons = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_tab_indicators = false,
				persist_buffer_sort = true,
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				offsets = {},
				custom_areas = {
					right = function()
						-- `result` を関数内で初期化
						local result = {}

						-- 表示される内容を定義
						table.insert(result, { text = git_repo_name(), fg = "#7EA9A7" })
						table.insert(result, { text = " " })
						table.insert(result, { text = git_branch(), fg = "#EC5241" })
						if git_is_dirty() then
							table.insert(result, { text = " " })
							table.insert(result, { text = "✗", fg = "#EFB839" })
						end
						return result
					end,
				},
			},
		})

		vim.keymap.set("n", "<leader>wp", "<CMD>BufferLinePickClose<CR>", { desc = "タブを選択して閉じる" })
		vim.keymap.set("n", "<leader>wa", "<CMD>BufferLineCloseOthers<CR>", { desc = "他のタブを閉じる" })
		vim.keymap.set("n", "<leader>ws", "<CMD>BufferLineSortByDirectory<CR>", { desc = "タブをソートする" })
		vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>")
	end,
}
