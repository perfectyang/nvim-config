print("欢迎-------->>>>>>>>>>> 杨帅哥,快乐打码!!!!!!!!!!!")

local api = vim.api
local buf, win
local position = 0

local function center(str)
	local width = api.nvim_win_get_width(0)
	local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
	return string.rep(" ", shift) .. str
end

local function open_window()
	buf = vim.api.nvim_create_buf(false, true)
	local border_buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "filetype", "whid")

	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	local win_height = math.ceil(height * 0.8 - 4)
	local win_width = math.ceil(width * 0.8)
	local row = math.ceil((height - win_height) / 2 - 1)
	local col = math.ceil((width - win_width) / 2)

	local border_opts = {
		style = "minimal",
		relative = "win",
		width = win_width + 2,
		height = win_height + 2,
		row = row - 1,
		col = col - 1,
		border = "rounded",
	}

	local opts = {
		style = "minimal",
		relative = "win",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
	}

	local border_lines = { "╔" .. string.rep("═", win_width) .. "╗" }
	local middle_line = "|" .. string.rep(" ", win_width) .. "|"
	for i = 1, win_height do
		table.insert(border_lines, middle_line)
	end
	table.insert(border_lines, "╚" .. string.rep("═", win_width) .. "╝")
	vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

	local border_win = vim.api.nvim_open_win(border_buf, true, border_opts)
	win = api.nvim_open_win(buf, true, opts)
	api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "' .. border_buf)

	vim.api.nvim_win_set_option(win, "cursorline", true)

	api.nvim_buf_set_lines(buf, 0, -1, false, { center("我想做什么?"), "", "" })
	-- api.nvim_buf_add_highlight(buf, -1, "WhidHeader", 0, 0, -1)
end

-- function Todo()
-- 	require("core/whid").whid()
-- end

function Test()
	print("test")
end

local M = {}

M.options = {
	width = 40,
	position = "right",
	indent_space_number = 2,
	header_prefix = "- ",
	default_display_level = 6,
	winopts = {
		number = false,
		relativenumber = false,
		wrap = false,
		winfixwidth = true,
		list = false,
		spell = false,
	},
	bufopts = {
		-- bufhidden = "wipe",
		filetype = "msnumber",
		modifiable = false,
	},
}
local move_tbl = {
	left = "H",
	right = "L",
}

local function create_side_window()
	vim.cmd("vsplit")
	-- vim.cmd("reg")
	local win = vim.api.nvim_get_current_win()
	local move_to = move_tbl[M.options.position]
	vim.api.nvim_command("wincmd " .. move_to)
	vim.ape.nvim_win_set_width(win, M.options.width)
	-- api.nvim_command("")
	vim.api.nvim_command("normal! gd")

	-- local buf = vim.api.nvim_create_buf(false, true)
	-- vim.api.nvim_win_set_buf(win, buf)
	-- for k, v in pairs(M.options.bufopts) do
	-- 	vim.api.nvim_buf_set_option(buf, k, v)
	-- end
	-- for k, v in pairs(M.options.winopts) do
	-- 	vim.opt_local[k] = v
	-- end
	return win, buf
end

-- vim.keymap.set("n", "<leader>l", create_side_window)
