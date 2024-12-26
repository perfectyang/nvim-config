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

	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
	-- vim.api.nvim_buf_set_keymap(buf, "n", "<leader>rr", [[<cmd>lua selfPrint()<CR>]], { noremap = true, silent = true })

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)
	vim.api.nvim_win_set_option(win, "relativenumber", true)
	local _win = { buf = buf, win = win }
	state.floating = _win
	table.insert(M.windows, _win)
	return _win
end

function show_all_registers()
	-- 创建一个新的缓冲区
	local bufnr = vim.api.nvim_create_buf(false, true)

	-- 初始化行内容
	local lines = {}
	local regContent = {}

	-- 定义要检查的寄存器列表
	local registers = {
		number = {
			"0",
			"1",
			"2",
			"3",
			"4",
			"5",
			"6",
			"7",
			"8",
			"9", -- 数字寄存器
		},
		aphabet = {
			"a",
			"b",
			"c",
			"d",
			"e",
			"f",
			"g",
			"h",
			"i",
			"j",
			"k",
			"l",
			"m",
			"n",
			"o",
			"p",
			"q",
			"r",
			"s",
			"t",
			"u",
			"v",
			"w",
			"x",
			"y",
			"z", -- 命名寄存器
		},
		special = {
			'"', -- 未命名寄存器
			"*",
			"+", -- 系统剪贴板
			"-", -- 小删除寄存器
			":", -- 最后执行的命令
			"?", -- 搜索模式
		},
	}

	function actionReg(r)
		vim.fn.system("pbcopy", regContent[r])
		-- local ns = vim.api.nvim_create_namespace("myLight")
		-- 获取当前行号
		-- local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
		-- vim.api.nvim_buf_add_highlight(bufnr, ns, "ErrorMsg", 3, 0, -1)

		-- print("复制到剪贴板成功", regContent[r], { silent = true })
		-- vim.cmd("sleep " .. "100ms")
		toggle_window()
	end

	local function travseRegContent(register)
		-- 遍历所有寄存器
		for index, reg in ipairs(register) do
			local contents = vim.fn.getreg(reg, 1, true) -- 获取为列表形式
			local _line = ""
			if #contents > 0 then
				for _, line in ipairs(contents) do
					_line = _line .. line
				end
				regContent[reg] = _line
				table.insert(lines, reg .. ": " .. _line)
			end
		end
	end

	table.insert(lines, "Number------------------>")
	travseRegContent(registers.number)
	table.insert(lines, "")
	table.insert(lines, "字母------------------>")
	travseRegContent(registers.aphabet)
	table.insert(lines, "")
	table.insert(lines, "特殊------------------>")
	travseRegContent(registers.special)

	-- 将内容写入缓冲区
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

	local function registerFunc(reg)
		for _, v in ipairs(reg) do
			if v ~= "k" and v ~= "j" then
				vim.api.nvim_buf_set_keymap(bufnr, "n", v, ":lua actionReg('" .. v .. "')<CR>", {
					nowait = true,
					noremap = true,
					silent = true,
				})
			end
		end
	end

	registerFunc(registers.number)
	registerFunc({ "a", "b", "c", "d", "f", "g" })
	registerFunc(registers.special)

	-- 设置缓冲区选项
	vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
	vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile")
	vim.api.nvim_buf_set_option(bufnr, "swapfile", false)

	return bufnr
end

function toggle_window()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = show_all_registers() })
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

-- Create a floating window with default dimensions
-- vim.keymap.set({ "n", "t", "i" }, "<leader>gn", toggle_terminal)
vim.keymap.set({ "n", "t", "i" }, "<leader>l", toggle_window)

-- function printL()
-- 	local buf = vim.api.nvim_create_buf(false, true)
-- 	local opts = {
-- 		relative = "editor",
-- 		width = 100,
-- 		height = 80,
-- 		col = 0,
-- 		row = 1,
-- 		style = "minimal", -- No borders or extra UI elements
-- 		border = "rounded",
-- 	}
-- 	vim.api.nvim_open_win(buf, true, opts)
-- end

-- vim.keymap.set({ "n", "t", "i" }, "<leader>pr", printL)
