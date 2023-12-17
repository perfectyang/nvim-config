require("plugins/plugins-setup")

require("core.options")
require("core.keymaps")

-- require("nvim-treesitter.install").prefer_git = true

-- 插件
require("plugins/lualine")
require("plugins/treesitter")
require("plugins/nvim-tree")
require("plugins/icon")
require("plugins/surround")
require("plugins/comment")
require("plugins/cmp")
require("plugins/autopairs")
require("plugins/bufferline")
require("plugins/gitsigns")
require("plugins/telescope")
require("plugins/lsp/mason")
require("plugins/lsp/lspconfig")
require("plugins/lsp/null-ls")
require("plugins/colorschme")
require("plugins/code-runner")
require("plugins/goto-preview")
require("plugins/indent-blankline")
require("plugins/lazygit")
require("plugins/pluginconfigs")

require("leap").add_default_mappings()

require("core.autocmd")
