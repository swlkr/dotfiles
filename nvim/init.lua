local opt = vim.opt

opt.syntax = "ON"
opt.expandtab = true
opt.relativenumber = true
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.showcmd = true
opt.smarttab = true
opt.incsearch = true
opt.list = true
opt.listchars = "tab:>-,space:·"
opt.clipboard = "unnamed"
opt.termguicolors = true

vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 30

-- plugins
require('plugins')

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    -- ..
    file_ignore_patterns = {
      "node_modules", ".git"
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      -- vim.fn["vsnip#anonymous"](args.body)

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = {
    { name = 'nvim_lsp' },

    -- For vsnip user.
    -- { name = 'vsnip' },

    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

    { name = 'buffer' },
  }
})

require('nvim-treesitter.configs').setup {
  ensure_installed = {"ruby", "javascript", "css", "html", "rust", "go", "tsx", "typescript"},
  highlight = {
    enable = true,
    disable = {"css"}
  },
  incremental_selection = {
    enable = true
  },
  textobjects = {
    enable = true
  },
  indent = {
    enable = true
  },
  -- endwise = {
  --  enable = true
 -- }
}

-- autocomplete
-- language servers
lspconfig = require('lspconfig')

-- html
lspconfig.html.setup{}

-- css
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup {
  capabilities = capabilities,
}

lspconfig.tsserver.setup{}

-- lspconfig.crystalline.setup()
-- lspconfig.denols.setup{}

lspconfig.solargraph.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- lspconfig.steep.setup {}

lspconfig.gopls.setup {
  lspconfig.gopls.setup {
    cmd = { "gopls", "serve" },
    settings = {
      analyses = {
        unusedparams = true
      },
      staticcheck = true
    }
  }
}

lspconfig.sqls.setup {
  settings = {
    sqls = {
      lowercaseKeywords = true,
      connections = {}
    }
  },
  on_attach = function(client, buffer)
    require('sqls').on_attach(client, buffer)
  end
}

--  local path_to_elixirls = vim.fn.expand("~/Projects/elixir-ls/release/language_server.sh")
--
--  lspconfig.elixirls.setup {
--    cmd = {path_to_elixirls},
--    settings = {
--      elixirLS = {
--      }
--    }
--  }

-- require('lspconfig').sorbet.setup {
--  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--  }

--local servers = { 'rust_analyzer' }
--for _, lsp in pairs(servers) do
--  lspconfig[lsp].setup {
--    on_attach = on_attach,
--    flags = {
--      -- This will be the default in neovim 0.7+
--      debounce_text_changes = 150,
--    }
--  }
--end

--lspconfig.tailwindcss.setup {
--  filetypes = { "gohtmltmpl" }
--}

 -- colorscheme
require('lualine').setup {
  options = {
    theme = 'everforest'
  }
}
vim.g.everforest_background = 'hard'
vim.opt.background = 'dark'
vim.cmd 'colorscheme everforest'

-- change the leader key from "\" to ";"
vim.g.mapleader = ';'

vim.opt.wildignore = '*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/.bundle_cache,*/bin/*,app/css/*'

-- nnoremap <nowait><silent> <C-l> :noh<CR>
vim.keymap.set('n', 'Y', 'y$', { remap = true })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>ft', '<cmd>Telescope tags<cr>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope current_buffer_tags<cr>')
vim.keymap.set('n', '<leader>fa', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
vim.keymap.set('i', '<silent><expr> <Tab>', '<Plug>luasnip-expand-or-jump')

-- move selected lines up one line
-- select line (shift + v)
-- alt + k
vim.keymap.set('x', '˚', ':m-2<CR>gv=gv')

-- move selected lines down one line
-- select line (shift + v)
-- alt + j
vim.keymap.set('x', '∆', '::m\'>+<CR>gv=gv')

vim.g.closetag_filenames = '*.html,*.gohtml,*.tmpl,*.erb,*.jsx'
vim.g.closetag_xhtml_filenames = '*.html,*.jsx,*.gohtml,*.tmpl,*.erb'

-- autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
-- autoformat on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.formatting_sync()
  end
})

-- strip whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- let g:gutentags_ctags_executable_ruby = 'ripper-tags'
vim.g.gutentags_exclude_filetypes = { 'css' }
vim.g.loaded_netrwPlugin = 1
