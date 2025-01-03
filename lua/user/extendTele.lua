local telescope_status, telescope_builtin = pcall(require, "telescope.builtin")

-- local pickers = require("telescope.pickers")
-- local finders = require("telescope.finders")
-- local conf = require("telescope.config").values
--
-- local colors = function(opts)
-- 	opts = opts or {}
-- 	pickers
-- 		.new(opts, {
-- 			prompt_title = "大帅哥",
-- 			finder = finders.new_table({
-- 				results = { "red", "green", "blue" },
-- 			}),
-- 			sorter = conf.generic_sorter(opts),
-- 		})
-- 		:find()
-- end
--
-- -- colors()
--

-- vim.keymap.set({ "n", "t", "i" }, "<leader>ll", colors)

function get_project_root()
	local git_dir = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
	return git_dir ~= "" and git_dir or vim.fn.getcwd()
end

local function f_live_grep()
	-- local config_data = vim.g.scratch_config
	if not telescope_status then
		vim.notify("ScrachOpenFzf needs telescope.nvim")
		return
	end

	telescope_builtin.live_grep({
		cwd = get_project_root(),
	})
end

local function f_find_files()
	if not telescope_status then
		vim.notify(
			'ScrachOpen needs telescope.nvim or you can just add `"use_telescope: false"` into your config file ot use native select ui'
		)
		return
	end
	telescope_builtin.find_files({
		cwd = get_project_root(),
	})
end

-- telescope
-- local builtin = require("telescope.builtin")
-- keymap.set("n", "<leader>ff", builtin.find_files, {}) -- find files within current working directory, respects .gitignore
-- keymap.set("n", "<leader>fc", builtin.live_grep, {}) -- 环境里要安装ripgrep find string in current working directory as you type
-- keymap.set("n", "<leader>fs", builtin.grep_string, {}) -- find string under cursor in current working directory
-- keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- list available help tags

vim.keymap.set({ "n", "t", "i" }, "<leader>fc", f_live_grep)
vim.keymap.set({ "n", "t", "i" }, "<leader>ff", f_find_files)
vim.keymap.set({ "n", "t", "i" }, "<leader>fb", telescope_builtin.buffers, {}) -- list open buffers in current neovim instance
