-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了

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
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				height = 0.9,
				preview_cutoff = 120,
				prompt_position = "bottom",
				width = 0.9,
			},
			bottom_pane = {
				height = 25,
				preview_cutoff = 120,
				prompt_position = "bottom",
			},

			cursor = {
				height = 0.9,
				preview_cutoff = 50,
				width = 0.9,
			},
			center = {
				height = 0.4,
				preview_cutoff = 40,
				prompt_position = "top",
				width = 0.5,
			},
			vertical = {
				height = 0.9,
				preview_cutoff = 40,
				prompt_position = "bottom",
				width = 0.8,
			},
			-- width = { padding = 0 },
			-- height = { padding = 0 },
		},
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
