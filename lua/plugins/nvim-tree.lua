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

-- local api = require("nvim-tree.api")

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")
	-- local function opts(desc)
	-- 	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	-- end

	api.config.mappings.default_on_attach(bufnr)
	-- custom mappings
	vim.keymap.del("n", "e", { buffer = bufnr })
	vim.keymap.del("n", "x", { buffer = bufnr })
end

-- configure nvim-tree
nvimtree.setup({
	open_on_tab = false,
	sync_root_with_cwd = true,
	reload_on_bufenter = true,
	on_attach = my_on_attach,

	-- change folder arrow icons
	-- renderer = {
	-- 	icons = {
	-- 		glyphs = {
	-- 			folder = {
	-- 				arrow_closed = "+", -- arrow when folder is closed
	-- 				arrow_open = "-", -- arrow when folder is open
	-- 			},
	-- 		},
	-- 	},
	-- },
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
		side = "left",
		number = false,
		relativenumber = true,
		width = 30,
		-- float = {
		-- 	enable = true,
		-- 	quit_on_focus_loss = true,
		-- 	open_win_config = {
		-- 		relative = "editor",
		-- 		border = "rounded",
		-- 		width = 40,
		-- 		height = 40,
		-- 		row = 1,
		-- 		col = 1,
		-- 	},
		-- },
		-- mappings = {
		-- 	list = {
		-- 		{ key = "e", action = "" },
		-- 		{ key = "x", action = "" },
		-- 		-- { key = "A", action = "copyName", action_cb = copyName },
		-- 	},
		-- },
	},

	-- view = {
	--   centralize_selection = false,
	--   cursorline = true,
	--   debounce_delay = 15,
	--   preserve_window_proportions = false,
	--   number = false,
	--   relativenumber = false,
	--   signcolumn = "yes",
	--   width = 30,
	--   float = {
	--     enable = false,
	--     quit_on_focus_loss = true,
	--     open_win_config = {
	--       relative = "editor",
	--       border = "rounded",
	--       width = 30,
	--       height = 30,
	--       row = 1,
	--       col = 1,
	--     },
	--   },
	-- },

	hijack_directories = {
		enable = true,
		auto_open = true,
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

	-- quit_on_open = 1,
	git = {
		enable = true,
		ignore = false,
		timeout = 400,
	},
})
