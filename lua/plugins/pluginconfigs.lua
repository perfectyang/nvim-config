-- which-key

local G = vim.g
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
-- require("spectre").setup()

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

-- G.peekup_open = "<leader>l"
require("nvim-peekup.config").on_keystroke["delay"] = "100ms"
require("nvim-peekup.config").geometry["title"] = "<<<<<<------来了老弟----->>>>>"

require("auto-save").setup({
	enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
	-- execution_message = {
	-- 	enabled = true,
	-- 	message = function() -- message to print on save
	-- 		return ("保存时间:" .. vim.fn.strftime("%H-%M-%S"))
	-- 	end,
	-- 	dim = 0.18, -- dim the color of `message`
	-- 	cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
	-- },
	trigger_events = { -- See :h events
		immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
		defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
		cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
	},
	-- function that takes the buffer handle and determines whether to save the current buffer or not
	-- return true: if buffer is ok to be saved
	-- return false: if it's not ok to be saved
	-- if set to `nil` then no specific condition is applied
	condition = nil,
	write_all_buffers = false, -- write all buffers when the current one meets `condition`
	noautocmd = false, -- do not execute autocmds when saving
	debounce_delay = 1500, -- delay after which a pending save is executed
	-- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
	debug = false,
})

require("ts_context_commentstring").setup({
	typescript = { __default = "// %s", __multiline = "/* %s */" },
	__default = "/* %s */",
	jsx_element = "{/* %s */}",
	jsx_fragment = "{/* %s */}",
	jsx_attribute = "// %s",
	comment = "/* %s */",
})

require("colorizer").setup()

require("typescript-tools").setup({
	handlers = {},
	settings = {
		-- spawn additional tsserver instance to calculate diagnostics on it
		separate_diagnostic_server = true,
		-- "change"|"insert_leave" determine when the client asks the server about diagnostic
		publish_diagnostic_on = "insert_leave",
		-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
		-- "remove_unused_imports"|"organize_imports") -- or string "all"
		-- to include all supported code actions
		-- specify commands exposed as code_actions
		expose_as_code_action = {},
		-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
		-- not exists then standard path resolution strategy is applied
		tsserver_path = nil,
		-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
		-- (see 💅 `styled-components` support section)
		tsserver_plugins = {},
		-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
		-- memory limit in megabytes or "auto"(basically no limit)
		tsserver_max_memory = "auto",
		-- described below
		tsserver_format_options = {},
		tsserver_file_preferences = {},
		-- locale of all tsserver messages, supported locales you can find here:
		-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
		tsserver_locale = "en",
		-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
		complete_function_calls = false,
		include_completions_with_insert_text = true,
		-- CodeLens
		-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
		-- possible values: ("off"|"all"|"implementations_only"|"references_only")
		code_lens = "off",
		-- by default code lenses are displayed on all referencable values and for some of you it can
		-- be too much this option reduce count of them by removing member references from lenses
		disable_member_code_lens = true,
		-- JSXCloseTag
		-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
		-- that maybe have a conflict if enable this feature. )
		jsx_close_tag = {
			enable = false,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
	},
})

local oil = require("oil")
oil.setup()
vim.keymap.set("n", "-", oil.toggle_float, {})

-- require("noice").setup({
-- 	lsp = {
-- 		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
-- 		override = {
-- 			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 			["vim.lsp.util.stylize_markdown"] = true,
-- 			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
-- 		},
-- 	},
-- 	-- you can enable a preset for easier configuration
-- 	presets = {
-- 		bottom_search = true, -- use a classic bottom cmdline for search
-- 		command_palette = true, -- position the cmdline and popupmenu together
-- 		long_message_to_split = true, -- long messages will be sent to a split
-- 		inc_rename = false, -- enables an input dialog for inc-rename.nvim
-- 		lsp_doc_border = false, -- add a border to hover docs and signature help
-- 	},
-- 	cmdline = {
-- 		view = "cmdline_popup",
-- 		opts = {
-- 			position = {
-- 				row = "100%", -- 距离顶部的行数
-- 				col = "50%", -- 水平居中
-- 			},
-- 			size = {
-- 				width = 60,
-- 				height = "auto",
-- 			},
-- 		},
-- 		format = {
-- 			-- 只为 cmdline 模式（以 : 开始的命令）配置弹出窗口
-- 			cmdline = { pattern = "^:", icon = "", lang = "vim", conceal = false },
--
-- 			-- 其他模式保持默认设置（不使用弹窗）
-- 			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
-- 			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
-- 			filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
-- 			lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
-- 			help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
-- 			input = {}, -- 用于 vim.ui.input
-- 		},
-- 	},
-- })

require("dashboard").setup({
	theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		-- shortcut = {
		-- 	{ desc = " Update", group = "@property", action = "Lazy update", key = "u" },
		-- 	{
		-- 		desc = " Files",
		-- 		group = "Label",
		-- 		action = "Telescope find_files",
		-- 		key = "f",
		-- 	},
		-- 	{
		-- 		desc = " Apps",
		-- 		group = "DiagnosticHint",
		-- 		action = "Telescope app",
		-- 		key = "a",
		-- 	},
		-- 	{
		-- 		desc = " dotfiles",
		-- 		group = "Number",
		-- 		action = "Telescope dotfiles",
		-- 		key = "d",
		-- 	},
		-- },
		packages = { enable = true },
		project = { enable = true, limit = 12 },
		mru = { limit = 12 },
		footer = {},
	},
})
