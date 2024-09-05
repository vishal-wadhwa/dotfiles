set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- x-ray/go.nvim
--  local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
--  vim.api.nvim_create_autocmd("BufWritePre", {
--    pattern = "*.go",
--    callback = function()
--     require('go.format').goimports()
--    end,
--    group = format_sync_grp,
--  })
-- 
--  require('go').setup()
-- 
--  local protocol = require'vim.lsp.protocol'
EOF
