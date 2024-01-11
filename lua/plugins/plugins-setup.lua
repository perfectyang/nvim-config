-- 自动安装packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- 保存此文件自动更新安装软件
-- 注意PackerCompile改成了PackerSync
-- plugins.lua改成了plugins-setup.lua，适应本地文件名字
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerInstall
  augroup end
]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("folke/tokyonight.nvim") -- 主题
	use({
		"nvim-lualine/lualine.nvim", -- 状态栏
		requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- 状态栏图标
	})
	use({
		"nvim-tree/nvim-tree.lua", -- 文档树
		requires = {
			"nvim-tree/nvim-web-devicons", -- 文档树图标
		},
	})

	use("nvim-tree/nvim-web-devicons")

	use("christoomey/vim-tmux-navigator") -- 用ctl-hjkl来定位窗口
	use("nvim-treesitter/nvim-treesitter") -- 语法高亮
	use("p00f/nvim-ts-rainbow") -- 配合treesitter，不同括号颜色区分
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
		"neovim/nvim-lspconfig",
	})
	--  -- 自动补全
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path") -- 文件路径
	use("hrsh7th/cmp-buffer") -- 文件路径

	use("L3MON4D3/LuaSnip") -- snippets引擎，不装这个自动补全会出问题
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	use("numToStr/Comment.nvim") -- gcc和gc注释
	use("windwp/nvim-autopairs") -- 自动补全括号

	use("akinsho/bufferline.nvim") -- buffer分割线
	use("lewis6991/gitsigns.nvim") -- 左则git提示
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4", -- 文件检索
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope-ui-select.nvim" }) -- for showing lsp code actions

	use({ "neoclide/coc.nvim", branch = "release" })

	use("JoosepAlviste/nvim-ts-context-commentstring")

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
	})

	use({
		"ggandor/leap.nvim",
	})

	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
	-- use({
	-- 	"smjonas/inc-rename.nvim",
	-- 	config = function()
	-- 		require("inc_rename").setup()
	-- 	end,
	-- })
	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	use("voldikss/vim-floaterm")

	use("tomasiser/vim-code-dark")

	use("Mofiqul/vscode.nvim")
	-- code runner
	use({ "CRAG666/code_runner.nvim", requires = "nvim-lua/plenary.nvim" })

	use("rafi/awesome-vim-colorschemes")
	use("APZelos/blamer.nvim")
	use("mg979/vim-visual-multi")
	use({
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	})

	use("lukas-reineke/indent-blankline.nvim")
	use({
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	-- Merge Tool
	use("sindrets/diffview.nvim")

	-- which-key
	use({ "folke/which-key.nvim", tag = "v1.5.1" })

	-- flask
	use({ "folke/flash.nvim", tag = "v1.18.2" })

	use({ "ThePrimeagen/harpoon" })
	use({ "rlue/vim-barbaric" })

	use({ "craftzdog/solarized-osaka.nvim" })

	use({ "nvim-pack/nvim-spectre" })

	-- use({
	-- 	"VonHeikemen/fine-cmdline.nvim",
	-- 	requires = {
	-- 		{ "MunifTanjim/nui.nvim" },
	-- 	},
	-- })

	-- use({
	-- 	"ray-x/navigator.lua",
	-- 	requires = {
	-- 		{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
	-- 		{ "neovim/nvim-lspconfig" },
	-- 	},
	-- })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
