-- 默认不开启nvim-tree
-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_auto_close = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

local api = require("nvim-tree.api")
local function copyName()
	api.fs.copy.filename()
end

-- configure nvim-tree
nvimtree.setup({
	open_on_tab = false,
	sync_root_with_cwd = true,
	reload_on_bufenter = true,
	-- change folder arrow icons
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},
	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = true,
			},
		},
	},
	view = {
		mappings = {
			list = {
				{ key = "e", action = "" },
				{ key = "x", action = "" },
				-- { key = "A", action = "copyName", action_cb = copyName },
			},
		},
	},

	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},

	filters = {
		dotfiles = false,
		-- git_clean = false,
		-- no_buffer = false,
		-- custom = {},
		-- exclude = {},
	},

	-- quit_on_open = 0,
	git = {
		enable = true,
		ignore = false,
		timeout = 400,
	},
})
