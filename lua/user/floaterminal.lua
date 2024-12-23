local M = {}

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	floating = {
		buf = -1, -- 缓冲区
		win = -1, -- 窗口id
	},
}

-- 存储创建的窗口
M.windows = {}

local function create_floating_window(opts)
	-- 获取当前 Git 分支
	local current_branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")

	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	-- Calculate the position to center the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal", -- No borders or extra UI elements
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	local _win = { buf = buf, win = win }
	state.floating = _win
	table.insert(M.windows, _win)
	return _win
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

local toggle_window = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

local open_wind = function()
	local current_buf = vim.api.nvim_get_current_buf()
	create_floating_window({
		buf = -1,
	})
end

-- 切换到下一个窗口
local next_window = function()
	if #M.windows == 0 then
		print("No windows to switch to.")
		return
	end

	local current = vim.api.nvim_get_current_win()
	local index = 1
	for i, floatWin in ipairs(M.windows) do
		if floatWin.win == current then
			index = i
			break
		end
	end

	local next_index = (index % #M.windows) + 1
	vim.api.nvim_set_current_win(M.windows[next_index].win)
	-- vim.api.nvim_win_set_buf(M.windows[next_index].win, M.windows[next_index].buf)
end

local close_all_windows = function()
	for _, it in ipairs(M.windows) do
		if vim.api.nvim_win_is_valid(it.win) then
			vim.api.nvim_win_close(it.win, true)
		end
	end
	M.windows = {}
	state.floating = { buf = -1, win = -1 }
end

-- Create a floating window with default dimensions
-- vim.keymap.set({ "n", "t", "i" }, "<leader>gn", toggle_terminal)
vim.keymap.set({ "n", "t", "i" }, "<leader>cw", close_all_windows)
-- vim.keymap.set({ "n", "t", "i" }, "<F4>", toggle_window)
vim.keymap.set({ "n", "t", "i" }, "<leader>to", toggle_terminal)
vim.keymap.set({ "n", "t", "i" }, "<leader>wn", next_window)
