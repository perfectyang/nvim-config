local M = {}

M.project_branch_buffers = {}
M.float_win = nil

function M.get_project_root()
	local git_dir = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
	return git_dir ~= "" and git_dir or vim.fn.getcwd()
end

function M.get_current_branch()
	return vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")
end

function M.get_project_branch_id()
	local project_root = M.get_project_root()
	local branch = M.get_current_branch()
	return project_root .. ":" .. branch
end

function M.get_project_branch_buffer()
	local project_branch_id = M.get_project_branch_id()

	if M.project_branch_buffers[project_branch_id] then
		return M.project_branch_buffers[project_branch_id]
	else
		local bufnr = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(bufnr, "GitNotes: " .. project_branch_id)

		vim.api.nvim_buf_set_option(bufnr, "buftype", "acwrite")
		vim.api.nvim_buf_set_option(bufnr, "bufhidden", "hide")

		M.project_branch_buffers[project_branch_id] = bufnr

		vim.api.nvim_create_autocmd("BufWriteCmd", {
			buffer = bufnr,
			callback = function()
				M.save_buffer_content(bufnr, project_branch_id)
			end,
		})

		M.load_buffer_content(bufnr, project_branch_id)

		return bufnr
	end
end

function M.save_buffer_content(bufnr, project_branch_id)
	local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local file_path = vim.fn.expand("~/.vim/git_notes/" .. vim.fn.sha256(project_branch_id) .. ".txt")
	vim.fn.mkdir(vim.fn.fnamemodify(file_path, ":h"), "p")
	vim.fn.writefile(content, file_path)
	vim.api.nvim_buf_set_option(bufnr, "modified", false)
end

function M.load_buffer_content(bufnr, project_branch_id)
	local file_path = vim.fn.expand("~/.vim/git_notes/" .. vim.fn.sha256(project_branch_id) .. ".txt")
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
			local project_branch_id = M.get_project_branch_id()
			M.save_buffer_content(bufnr, project_branch_id)
			M.float_win = nil
		end,
	})
end

function M.close_float_win()
	if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
		local bufnr = vim.api.nvim_win_get_buf(M.float_win)
		local project_branch_id = M.get_project_branch_id()
		M.save_buffer_content(bufnr, project_branch_id)
		vim.api.nvim_win_close(M.float_win, true)
		M.float_win = nil
	end
end

function M.cleanup_deleted_branches()
	local current_project = M.get_project_root()
	local current_branches = {}

	local branches = vim.fn.systemlist("git branch --format='%(refname:short)'")
	for _, branch in ipairs(branches) do
		current_branches[current_project .. ":" .. branch] = true
	end

	for project_branch_id, bufnr in pairs(M.project_branch_buffers) do
		local project, branch = project_branch_id:match("(.+):(.+)")
		if project == current_project and not current_branches[project_branch_id] then
			if vim.api.nvim_buf_is_valid(bufnr) then
				vim.api.nvim_buf_delete(bufnr, { force = true })
			end

			local file_path = vim.fn.expand("~/.vim/git_notes/" .. vim.fn.sha256(project_branch_id) .. ".txt")
			if vim.fn.filereadable(file_path) == 1 then
				vim.fn.delete(file_path)
			end

			M.project_branch_buffers[project_branch_id] = nil
		end
	end
end

function M.toggle_project_branch_notes()
	M.cleanup_deleted_branches()
	if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
		M.close_float_win()
	else
		local bufnr = M.get_project_branch_buffer()
		M.create_float_win(bufnr)
	end
end

vim.api.nvim_create_autocmd("User", {
	pattern = "GitBranchChanged",
	callback = function()
		M.cleanup_deleted_branches()
		if M.float_win and vim.api.nvim_win_is_valid(M.float_win) then
			local old_bufnr = vim.api.nvim_win_get_buf(M.float_win)
			local old_project_branch_id = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(old_bufnr), ":t:r")
			M.save_buffer_content(old_bufnr, old_project_branch_id)

			local new_bufnr = M.get_project_branch_buffer()
			vim.api.nvim_win_set_buf(M.float_win, new_bufnr)
		end
	end,
})
