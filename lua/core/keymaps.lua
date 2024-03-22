vim.g.mapleader = ";"
local keymap = vim.keymap
local G = vim.g
vim.g.skip_ts_context_commentstring_module = true

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jj", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
-- keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 窗口
-- ---------- 正常模式 ---------- ---
-- keymap.set("n", "<leader>q", ":q!<CR>") -- 垂直新增窗口
keymap.set("n", "<leader>;", ":w!<CR>")
keymap.set("n", "J", "5j")
keymap.set("n", "K", "5k")
keymap.set("v", "J", "5j")
keymap.set("v", "K", "5k")
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
keymap.set("n", "H", "^")
keymap.set("n", "L", "$")

keymap.set("n", "daf", "va{Vd")
keymap.set("n", "yaf", "va{Vy")
keymap.set("n", "mm", "mM")
keymap.set("n", "mn", "mN")
keymap.set("n", "mb", "mB")
keymap.set("n", "ma", "mA")
keymap.set("n", "`a", "`A")
keymap.set("n", "`b", "`B")
keymap.set("n", "`n", "`N")
keymap.set("n", "`m", "`M")
keymap.set("n", "cL", "c$")
keymap.set("n", "cH", "c0")
keymap.set("n", "dL", "d$")
keymap.set("n", "yp", "Yp")

-- keymap.set("n", "<Space>", "zc")

-- 分割窗口
keymap.set("n", "<leader>sc", ":close<CR>") -- 关闭窗口
keymap.set("n", "<leader>oy", ":only<CR>")
keymap.set("n", "<leader>sv", ":vsplit<CR>") -- 水平新增窗口
keymap.set("n", "<leader>sh", ":split<CR>") -- 垂直新增窗口

keymap.set("n", "gl", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
keymap.set("n", "glt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { noremap = true })
keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true })
-- keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true })

-- aff

vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

-- local keyset = vim.keymap.set
-- -- Autocomplete
-- function _G.check_back_space()
--     local col = vim.fn.col('.') - 1
--     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
-- local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
-- keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
-- keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
-- keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
-- keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
-- keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- 取消高亮
keymap.set("n", "<CR>", ":nohl<CR>")

-- 切换buffer
keymap.set("n", "<leader>n", ":bnext<CR>")
keymap.set("n", "<leader>b", ":bprevious<CR>")
keymap.set("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")
-- 清除所有buffer页
keymap.set("n", "<leader>c", ":bufdo bd<CR>")

-- ---------- 插件 ---------- ---
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- keymap.set("n", "<leader>gg", ":LazyGit<CR>")
-- keymap.set("n", "f", ":bp<bar>sp<bar>bn<bar>bd<CR>")

-- 浮动窗口

G.floaterm_keymap_kill = "<F7>"
G.floaterm_keymap_new = "<F8>"
G.floaterm_keymap_toggle = "<F9>"
G.floaterm_keymap_next = "<F10>"
G.floaterm_position = "bottomRight"
G.floaterm_title = "Perfectyang-$1/$2"
G.floaterm_width = 0.8
G.floaterm_height = 0.9
G.floaterm_giteditor = true
G.floaterm_opener = "edit"

-- -- git commit标记显示
G.blamer_enabled = 1
G.blamer_delay = 300
G.blamer_show_in_insert_modes = 0
G.blamer_date_format = "%y/%m/%d"
G.blamer_relative_time = 1
-- G.blamer_prefix = " > "

-- Harpoon Which-key mappings
-- local wk = require("which-key")
-- wk.register({
-- 	-- The first key you are pressing
-- 	h = {
-- 		name = "harpoon",
-- 		-- the second key
-- 		x = {
-- 			function()
-- 				require("harpoon.mark").add_file()
-- 			end,
-- 			"Mark file",
-- 		},
-- 	},
-- }, { prefix = "<leader>" })

-- flash
-- wk.register({
-- 	-- flash search
-- 	l = {
-- 		name = "flash",
-- 		s = {
-- 			function()
-- 				require("flash").jump()
-- 			end,
-- 			"Flash Jump",
-- 		},
-- 		t = {
-- 			function()
-- 				require("flash").treesitter()
-- 			end,
-- 			"Flash Treesitter",
-- 		},
-- 		r = {
-- 			function()
-- 				require("flash").treesitter_search()
-- 			end,
-- 			"Flash Treesitter Search",
-- 		},
-- 	},
-- }, { prefix = "<leader>" })

-- telescope
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>ff", builtin.find_files, {}) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fc", builtin.live_grep, {}) -- 环境里要安装ripgrep find string in current working directory as you type
keymap.set("n", "<leader>fb", builtin.buffers, {}) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fs", builtin.grep_string, {}) -- find string under cursor in current working directory
keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- list available help tags

-- harpoon
keymap.set("n", "<leader>mm", require("harpoon.mark").add_file)
keymap.set("n", "<leader>mn", require("harpoon.ui").nav_next)
keymap.set("n", "<leader>mb", require("harpoon.ui").nav_prev)
keymap.set("n", "<leader>fm", ":Telescope harpoon marks<CR>") -- list current changes per file with diff preview ["gs" for git status]
keymap.set("n", "<leader>me", ":lua require('harpoon.ui').toggle_quick_menu()<CR>") -- list current changes per file with diff preview ["gs" for git status]

-- inc-rename
-- vim.keymap.set("n", "<leader>rn", function()
-- 	return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true })
-- vim.keymap.set("n", "<leader>rn", ":IncRename ")

-- 文本替换
-- vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
-- 	desc = "Toggle Spectre",
-- })
vim.keymap.set("n", "<leader>se", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vim.keymap.set("v", "<leader>se", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

-- keymap.set("n", ":", "<cmd>FineCmdline<CR>")
--
-- function Todo()
-- 	require("core/whid").whid()
-- end
--
-- keymap.set("n", "<leader>l", Todo)
