vim.opt.termguicolors = true

require("bufferline").setup({
	-- options = {
	-- 	-- mode = "tabs",
	-- 	numbers = "none",
	-- 	close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
	-- 	--- right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
	-- 	--left_mouse_command = "bdelete %d",    -- can be a string | function, see "Mouse actions"
	--
	-- 	-- 使用 nvim 内置lsp
	-- 	diagnostics = "nvim-lsp",
	-- 	-- 左侧让出 nvim-tree 的位置
	-- 	offsets = {
	-- 		{
	-- 			filetype = "NvimTree",
	-- 			text = "File Explorer",
	-- 			highlight = "Directory",
	-- 			text_align = "left",
	-- 		},
	-- 	},
	-- 	hover = {
	-- 		enabled = true,
	-- 		delay = 100,
	-- 		reveal = { "close" },
	-- 	},
	-- },

	options = {

		-- 使用 nvim 内置lsp
		diagnostics = "nvim-lsp",
		-- 左侧让出 nvim-tree 的位置
		hover = {
			enabled = true,
			delay = 100,
			reveal = { "close" },
		},

		buffer_close_icon = "",
		close_command = "bdelete %d",
		close_icon = "",
		indicator = {
			style = "icon",
			icon = " ",
		},
		left_trunc_marker = "",
		modified_icon = "●",
		offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
		right_mouse_command = "Bdelete! %d",
		right_trunc_marker = "",
		show_close_icon = false,
		show_tab_indicators = true,
	},
	highlights = {
		fill = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLineNC" },
		},
		background = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLine" },
		},
		buffer_visible = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		buffer_selected = {
			-- fg = { attribute = "fg", highlight = "Normal" },
			-- fg = { attribute = "fg", highlight = "#ff6161" },
			fg = "#ff6161",
			-- bg = "#000000",
			bg = { attribute = "bg", highlight = "Normal" },
		},
		separator = {
			fg = { attribute = "bg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLine" },
		},
		separator_selected = {
			fg = { attribute = "fg", highlight = "Special" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		separator_visible = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLineNC" },
		},
		close_button = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLine" },
		},
		close_button_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		close_button_visible = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
	},
})
