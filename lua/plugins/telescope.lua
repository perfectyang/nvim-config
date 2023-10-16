local builtin = require("telescope.builtin")

-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了

-- telescope
vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- find files within current working directory, respects .gitignore
vim.keymap.set("n", "<leader>fc", builtin.live_grep, {}) -- 环境里要安装ripgrep find string in current working directory as you type
vim.keymap.set("n", "<leader>fb", builtin.buffers, {}) -- list open buffers in current neovim instance
vim.keymap.set("n", "<leader>fs", builtin.grep_string, {}) -- find string under cursor in current working directory
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- list available help tags
--
--
--
-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

-- import telescope-ui-select safely
local themes_setup, themes = pcall(require, "telescope.themes")
if not themes_setup then
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
	},
	extensions = {
		["ui-select"] = {
			themes.get_dropdown({}),
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
