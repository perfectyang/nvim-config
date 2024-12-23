vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({})
	end,
})

-- -- 定义字母到短语的映射
-- local phrases = {
-- 	i = "const name = 'perfectyang'",
-- 	v = "Vim is awesome!",
-- 	n = "Neovim rocks!",
-- 	l = "Let's learn Lua!",
-- }
--
-- -- 输出短语的函数
-- local function output_phrase(letter)
-- 	local phrase = phrases[letter]
-- 	if phrase then
-- 		vim.api.nvim_put({ phrase }, "c", true, true)
-- 	else
-- 		print("No phrase defined for letter: " .. letter)
-- 	end
-- end
--
-- -- 设置命令的函数
-- vim.api.nvim_create_user_command("QuickPhrase", function(opts)
-- 	output_phrase(opts.args)
-- end, { nargs = 1 })
--
-- -- 为每个定义的字母创建键盘映射
-- for letter, _ in pairs(phrases) do
-- 	vim.keymap.set("n", "<leader>" .. letter, function()
-- 		output_phrase(letter)
-- 	end, { desc = "Output quick phrase for " .. letter })
-- end
