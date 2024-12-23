local M = {}

-- 存储分支和缓冲区的映射
M.branch_buffers = {}
-- 存储浮动窗口 ID
M.float_win = nil

-- 创建或获取与分支关联的缓冲区
function M.get_branch_buffer()
	local current_branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")

	if M.branch_buffers[current_branch] then
		return M.branch_buffers[current_branch]
	else
		local bufnr = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(bufnr, "GitNotes: " .. current_branch)

		vim.api.nvim_buf_set_option(bufnr, "buftype", "acwrite")
		vim.api.nvim_buf_set_option(bufnr, "bufhidden", "hide")

		M.branch_buffers[current_branch] = bufnr

		vim.api.nvim_create_autocmd("BufWriteCmd", {
			buffer = bufnr,
			callback = function()
				M.save_buffer_content(bufnr, current_branch)
			end,
		})

		M.load_buffer_content(bufnr, current_branch)

		return bufnr
	end
end

-- 保存缓冲区内容
function M.save_buffer_content(bufnr, branch)
	local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local file_path = vim.fn.expand("~/.vim/git_notes/" .. branch .. ".txt")
	vim.fn.mkdir(vim.fn.fnamemodify(file_path, ":h"), "p")
	vim.fn.writefile(content, file_path)
	print("Saved notes for branch: " .. branch)
end

-- 加载缓冲区内容
function M.load_buffer_content(bufnr, branch)
	local file_path = vim.fn.expand("~/.vim/git_notes/" .. branch .. ".txt")
	if vim.fn.filereadable(file_path) == 1 then
		local content = vim.fn.readfile(file_path)
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
	end
end

-- 创建浮动窗口
function M.create_float_win(bufnr)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	}

	M.float_win = vim.api.nvim_open_win(bufnr, true, win_opts)

	-- 设置窗口选项
	vim.api.nvim_win_set_option(M.float_win, "winblend", 10)
	vim.api.nvim_win_set_option(M.float_win, "cursorline", true)

	-- 添加关闭浮动窗口的键映射
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"q",
		':lua require("git_branch_buffers").close_float_win()<CR>',
		{ noremap = true, silent = true }
	)

	-- 设置自动命令以在窗口关闭时重置 M.float_win
	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(M.float_win),
		callback = function()
			M.float_win = nil
		end,
	})
end

-- 关闭浮动窗口
function M.close_float_win()
	if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
		vim.api.nvim_win_close(M.float_win, true)
		M.float_win = nil
	end
end

-- 切换到与当前 Git 分支关联的浮动窗口
function M.toggle_branch_notes()
	if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
		M.close_float_win()
	else
		local bufnr = M.get_branch_buffer()
		M.create_float_win(bufnr)
	end
end

-- 设置自动命令以在 Git 分支变化时更新缓冲区
vim.api.nvim_create_autocmd("User", {
	pattern = "GitBranchChanged",
	callback = function()
		if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
			local bufnr = M.get_branch_buffer()
			vim.api.nvim_win_set_buf(M.float_win, bufnr)
		end
	end,
})

return M
