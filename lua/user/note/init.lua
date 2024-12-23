local git_buffers = require("user.note.note")

-- 创建一个命令来切换 Git 分支笔记的浮动窗口
vim.api.nvim_create_user_command("GitNotes", function()
	git_buffers.toggle_project_branch_notes()
end, {})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local current_branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")
		if current_branch ~= "" and current_branch ~= vim.b.last_git_branch then
			vim.b.last_git_branch = current_branch
			vim.cmd("doautocmd User GitBranchChanged")
		end
	end,
})

-- 设置一个快捷键
vim.api.nvim_set_keymap("n", "<F4>", ":GitNotes<CR>", { noremap = true, silent = true })
