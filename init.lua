--
--
--
--
require("plugins/plugins-setup")

require("core.options")
require("core.keymaps")

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

require("leap").add_default_mappings()
