local M = {}

M.branch_buffers = {}
M.float_win = nil

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

function M.save_buffer_content(bufnr, branch)
	local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local file_path = vim.fn.expand("~/.vim/git_notes/" .. branch .. ".txt")
	vim.fn.mkdir(vim.fn.fnamemodify(file_path, ":h"), "p")
	vim.fn.writefile(content, file_path)
	vim.api.nvim_buf_set_option(bufnr, "modified", false)
end

function M.load_buffer_content(bufnr, branch)
	local file_path = vim.fn.expand("~/.vim/git_notes/" .. branch .. ".txt")
	if vim.fn.filereadable(file_path) == 1 then
		local content = vim.fn.readfile(file_path)
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
		vim.api.nvim_buf_set_option(bufnr, "modified", false)
	end
end

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

	vim.api.nvim_win_set_option(M.float_win, "winblend", 10)
	vim.api.nvim_win_set_option(M.float_win, "cursorline", true)

	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"q",
		':lua require("user.note.note").close_float_win()<CR>',
		{ noremap = true, silent = true }
	)

	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(M.float_win),
		callback = function()
			local current_branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
			M.save_buffer_content(bufnr, current_branch)
			M.float_win = nil
		end,
	})
end

function M.close_float_win()
	if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
		local bufnr = vim.api.nvim_win_get_buf(M.float_win)
		local current_branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
		M.save_buffer_content(bufnr, current_branch)
		vim.api.nvim_win_close(M.float_win, true)
		M.float_win = nil
	end
end

function M.toggle_branch_notes()
	if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
		M.close_float_win()
	else
		local bufnr = M.get_branch_buffer()
		M.create_float_win(bufnr)
	end
end

vim.api.nvim_create_autocmd("User", {
	pattern = "GitBranchChanged",
	callback = function()
		if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
			local old_bufnr = vim.api.nvim_win_get_buf(M.float_win)
			local old_branch = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(old_bufnr), ":t:r")
			M.save_buffer_content(old_bufnr, old_branch)

			local new_bufnr = M.get_branch_buffer()
			vim.api.nvim_win_set_buf(M.float_win, new_bufnr)
		end
	end,
})

return M
