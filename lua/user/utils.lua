local Path = require("plenary.path")
local popup = require("plenary.popup")

local M = {}

function M.project_key()
	return vim.loop.cwd()
end

function M.normalize_path(item)
	return Path:new(item):make_relative(M.project_key())
end

function M.getBuf_name()
	local str = M.normalize_path(vim.api.nvim_buf_get_name(0))
	print(str)
	return str
end

function M.create()
	-- local width = 60
	-- local height = 10
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local bufnr = vim.api.nvim_create_buf(false, false)

	popup.create(bufnr, {
		title = "测试",
		highlight = "HarpoonWindow",
		-- line = vim.o.lines,
		-- col = vim.o.columns,
		-- line = math.floor(((vim.o.lines - height) / 2) - 1),
		-- col = math.floor((vim.o.columns - width) / 2),
		minwidth = vim.o.columns - 10,
		minheight = vim.o.lines - 5,
		borderchars = borderchars,
	})
end

-- vim.keymap.set("n", "ll", M.create, { noremap = true, silent = true })
