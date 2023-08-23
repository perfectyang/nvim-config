require("nvim-treesitter.configs").setup({
	-- 添加不同语言
	ensure_installed = {
		"vim",
		-- "help",
		"bash",
		"c",
		"cpp",
		"javascript",
		"json",
		"lua",
		"python",
		"typescript",
		"tsx",
		"css",
		"rust",
		"markdown",
		"markdown_inline",
		"vim",
		"dockerfile",
		"gitignore",
		"html",
	}, -- one of "all" or a list of languages

	highlight = { enable = false },
	indent = { enable = true },

	-- 不同括号颜色区分
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	context_commentstring = {
		enable = true,
		config = {
			typescript = { __default = "// %s", __multiline = "/* %s */" },
			-- __default = '// %s',
			__default = "/* %s */",
			jsx_element = "{/* %s */}",
			jsx_fragment = "{/* %s */}",
			jsx_attribute = "// %s",
			comment = "/* %s */",
		},
	},
})
