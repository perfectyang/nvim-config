-- which-key

-- 		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
-- 		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
-- 		-- No actual key bindings are created
-- 		spelling = {
-- 			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
-- 			suggestions = 20, -- how many suggestions should be shown in the list?
-- 		},
-- 		presets = {
-- 			operators = true, -- adds help for operators like d, y, ...
-- 			motions = true, -- adds help for motions
-- 			text_objects = true, -- help for text objects triggered after entering an operator
-- 			windows = true, -- default bindings on <c-w>
-- 			nav = true, -- misc bindings to work with windows
-- 			z = true, -- bindings for folds, spelling and others prefixed with z
-- 			g = true, -- bindings for prefixed with g
-- 		},
-- 	},
-- 	operators = { gc = "Comments" },
-- 	icons = {
-- 		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
-- 		separator = "➜", -- symbol used between a key and it's label
-- 		group = "+", -- symbol prepended to a group
-- 	},
-- 	popup_mappings = {
-- 		scroll_down = "<c-d>", -- binding to scroll down inside the popup
-- 		scroll_up = "<c-u>", -- binding to scroll up inside the popup
-- 	},
-- 	window = {
-- 		border = "none", -- none, single, double, shadow
-- 		position = "bottom", -- bottom, top
-- 		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
-- 		padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
-- 		winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
-- 		zindex = 1000, -- positive value to position WhichKey above other floating windows.
-- 	},
-- })

-- require("flash").setup({
-- 	modes = {
-- 		char = {
-- 			jump_labels = true,
-- 		},
-- 	},
-- })

-- Harpoon telescope extension
require("telescope").load_extension("harpoon")

-- Harpoon
require("harpoon").setup({
	global_settings = {
		-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
		save_on_toggle = false,

		-- saves the harpoon file upon every change. disabling is unrecommended.
		save_on_change = true,

		-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
		enter_on_sendcmd = false,

		-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
		tmux_autoclose_windows = true,

		-- filetypes that you want to prevent from adding to the harpoon list menu.
		excluded_filetypes = { "harpoon" },

		-- set marks specific to each git branch inside git repository
		-- Each branch will have it's own set of marked files
		mark_branch = true,

		-- enable tabline with harpoon marks
		tabline = false,
		tabline_prefix = "   ",
		tabline_suffix = "   ",
	},
})

require("solarized-osaka").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.6, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors)
		colors.hint = colors.orange
		colors.error = colors.yellow500
	end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	---@param highlights Highlights
	---@param colors ColorScheme
	-- on_highlights = function(highlights, colors) end,
})

-- 文本替换
require("spectre").setup()

-- require("fine-cmdline").setup({
-- 	cmdline = {
-- 		enable_keymaps = true,
-- 		smart_history = true,
-- 		prompt = ":",
-- 	},
-- 	popup = {
-- 		position = {
-- 			row = "100%",
-- 			col = "50%",
-- 		},
-- 		size = {
-- 			width = "60%",
-- 		},
-- 		border = {
-- 			style = "rounded",
-- 		},
-- 		win_options = {
-- 			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
-- 		},
-- 	},
-- 	hooks = {
-- 		before_mount = function(input)
-- 			-- code
-- 		end,
-- 		after_mount = function(input)
-- 			-- code
-- 		end,
-- 		set_keymaps = function(imap, feedkeys)
-- 			-- code
-- 		end,
-- 	},
-- })

-- require("navigator").setup({
-- 	lsp = {
-- 		disable_lsp = { "pylsd", "sqlls" },
-- 	},
-- })
