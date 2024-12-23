local M = {}

-- 存储创建的窗口
M.windows = {}

-- 创建一个新的浮动窗口
function M.create_window(content)
	-- 创建一个新的缓冲区
	local buf = vim.api.nvim_create_buf(false, true)

	-- 设置缓冲区的内容
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, content)

	-- 获取编辑器的宽度和高度
	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	-- 计算浮动窗口的大小和位置
	local win_height = math.ceil(height * 0.8 - 4)
	local win_width = math.ceil(width * 0.8)
	local row = math.ceil((height - win_height) / 2 - 1)
	local col = math.ceil((width - win_width) / 2)

	-- 设置窗口选项
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "rounded",
	}

	-- 创建浮动窗口
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- 将窗口添加到列表中
	table.insert(M.windows, win)

	return win
end

-- 切换到下一个窗口
function M.next_window()
	if #M.windows == 0 then
		print("No windows to switch to.")
		return
	end

	local current = vim.api.nvim_get_current_win()
	local index = 1
	for i, win in ipairs(M.windows) do
		if win == current then
			index = i
			break
		end
	end

	local next_index = (index % #M.windows) + 1
	vim.api.nvim_set_current_win(M.windows[next_index])
end

-- 关闭所有创建的窗口
function M.close_all_windows()
	for _, win in ipairs(M.windows) do
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end
	M.windows = {}
end

vim.api.nvim_create_user_command("CreateWindow", function(opts)
	M.create_window(vim.split(opts.args, "\n"))
end, { nargs = "*" })

vim.api.nvim_create_user_command("NextWindow", function()
	M.next_window()
end, {})

vim.api.nvim_create_user_command("CloseAllWindows", function()
	M.close_all_windows()
end, {})

-- 设置快捷键
vim.keymap.set("n", "<leader>1", ":CreateWindow", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>2", ":NextWindow<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>3", ":CloseAllWindows<CR>", { noremap = true, silent = true })
