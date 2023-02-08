vim.g.mapleader = ";"
local keymap = vim.keymap
local G = vim.g

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jj", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
-- keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 窗口
-- ---------- 正常模式 ---------- ---
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>sh", "<Cnw>s") -- 垂直新增窗口
-- keymap.set("n", "<leader>q", ":q!<CR>") -- 垂直新增窗口
keymap.set("n", "<leader>;", ":w<CR>") -- 垂直新增窗口
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
keymap.set("n", "`b", "`B")
keymap.set("n", "`n", "`N")
keymap.set("n", "`m", "`M")

-- keymap.set("n", "<Space>", "zc")

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

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fc", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- 取消高亮
keymap.set("n", "<CR>", ":nohl<CR>")

-- 切换buffer
keymap.set("n", "<leader>n", ":bnext<CR>")
keymap.set("n", "<leader>b", ":bprevious<CR>")

keymap.set("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")

-- ---------- 插件 ---------- ---
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- 浮动窗口

G.floaterm_keymap_kill = "<F7>"
G.floaterm_keymap_new = "<F8>"
G.floaterm_keymap_toggle = "<F9>"
G.floaterm_keymap_next = "<F10>"
G.floaterm_position = "bottomRight"
-- G.floaterm_title = "杨国唯大帅哥"
G.floaterm_width = 0.8
G.floaterm_height = 0.9

-- git commit标记显示
G.blamer_enabled = 1
G.blamer_delay = 1000
G.blamer_show_in_insert_modes = 0
G.blamer_date_format = "%y/%m/%d"
G.blamer_relative_time = 1
-- G.blamer_prefix = " > "
