_G.Cfg = {}

Cfg.maps = {}

Cfg.gen = {}

local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

local Deps = require('mini.deps')

Deps.setup {
  path = { package = path_package },
}

local H = {}

Deps.now(function()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'

  vim.o.autoindent = true

  require('n0.theme').set_global_opts()

  vim.o.statusline = '%<%f %{getbufvar(bufnr(), "minigit_summary_string")} %h%m%r %= %-14.(%l,%c%V%) %P'

  vim.filetype.add {
    extension = {
      templ = 'templ',
    },
  }

  vim.lsp.enable { 'gopls', 'luals', 'nixd', 'pyright', 'templ', 'texlab' }
end)

Deps.later(function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end,
  })
end)

Deps.later(function()
  require('mini.extra').setup()
end)

Deps.now(function()
  require('mini.visits').setup()
end)

Deps.later(function()
  require('mini.ai').setup {
    custom_textobjects = {
      -- default objs: b, q, t, f, a
      l = require('mini.extra').gen_ai_spec.line(),
      i = require('mini.extra').gen_ai_spec.indent(),
      g = require('mini.extra').gen_ai_spec.buffer(),
      c = require('mini.ai').gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
      d = require('mini.ai').gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
    },
  }
end)

Deps.later(function()
  local opts = {}
  opts = vim.tbl_deep_extend('error', opts, require('n0.theme').mini_pick())
  require('mini.pick').setup(opts)
end)

Deps.later(function()
  local opts = {
    options = { permanent_delete = false, use_as_default_explorer = false },
  }

  opts = vim.tbl_deep_extend('error', opts, require('n0.theme').mini_files())
  require('mini.files').setup(opts)
end)

Deps.later(function()
  local opts = {
    lsp_completion = {
      auto_setup = false,
      source_func = 'omnifunc',
      process_items = function(items, base)
        items = vim.tbl_filter(function(x)
          return x.kind ~= 1 and x.kind ~= 15
        end, items)
        return require('mini.completion').default_process_items(items, base)
      end,
    },
  }

  opts = vim.tbl_deep_extend('error', opts, require('n0.theme').mini_completion())
  require('mini.completion').setup(opts)
end)

Deps.later(function()
  require('mini.jump2d').setup()
end)

Deps.later(function()
  require('mini.diff').setup()
end)

Deps.later(function()
  require('mini.git').setup()
end)

Deps.later(function()
  require('mini.pairs').setup()
end)

Deps.later(function()
  require('mini.align').setup()
end)

Deps.later(function()
  require('mini.operators').setup()
end)

Deps.later(function()
  require('mini.surround').setup()
end)

Deps.later(function()
  require('mini.splitjoin').setup()
end)

Deps.later(function()
  Deps.add('nvim-treesitter/nvim-treesitter-textobjects')

  require('nvim-treesitter.configs').setup {
    ensure_installed = {},
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = function(_, buf)
        if not vim.bo[buf].modifiable then
          return false
        end
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > (250 * 1024)
      end,
    },
    indent = {
      enable = false,
    },
    textobjects = {
      enable = true,
    },
  }
end)

Deps.now(function()
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end)

Deps.later(function()
  Deps.add('stevearc/conform.nvim')

  require('conform').setup {
    formatters_by_ft = {
      go = { 'goimports', 'gofumpt' },
      lua = { 'stylua' },
      nix = { 'alejandra' },
      templ = { 'templ' },
      c = { 'clang-format' },
      json = { 'prettier' },
      markdown = { 'prettier' },
    },
  }
end)

Deps.later(function()
  local snippets = require('mini.snippets')
  snippets.setup {
    snippets = {
      snippets.gen_loader.from_lang(),
    },
  }
end)

Deps.later(function()
  require('mini.bracketed').setup()
end)

Deps.later(function()
  Deps.add('stevearc/quicker.nvim')
  require('quicker').setup()
end)

Cfg.maps.pick_files = function()
  require('mini.pick').builtin.cli { command = { 'fd', '--type=f' } }
end

Cfg.maps.pick_directories = function()
  require('mini.pick').builtin.cli { command = { 'fd', '--type=d' } }
end

Cfg.gen_stack = function()
  return {
    filter = function(path_data)
      return vim.fn.isdirectory(path_data.path) == 0
    end,
    sort = require('mini.visits').gen_sort.default { recency_weight = 1 },
  }
end

H.map_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end

Deps.now(function()
  vim.keymap.set('i', '<c-s>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
  vim.keymap.set('n', 'grn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
  vim.keymap.set({ 'n', 'x' }, 'gra', '<Cmd>lua vim.lsp.buf.code_action()<CR>')

  -- stylua: ignore start
  H.map_leader('en',  '<Cmd>lua MiniVisits.iterate_paths("backward", nil, Cfg.gen_stack())<CR>')
  H.map_leader('ep',  '<Cmd>lua MiniVisits.iterate_paths("forward", nil, Cfg.gen_stack())<CR>')

  H.map_leader('ef',  '<Cmd>lua Cfg.maps.pick_files()<CR>')
  H.map_leader('ed',  '<Cmd>lua Cfg.maps.pick_directories()<CR>')
  H.map_leader('eg',  '<Cmd>Pick grep_live<CR>')
  H.map_leader('eh',  '<Cmd>Pick help<CR>')
  H.map_leader('er',  '<Cmd>Pick visit_paths<CR>')
  H.map_leader('ex',  '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>')

  H.map_leader('gcc', '<Cmd>Git commit<CR>',                               'Create a commit.')
  H.map_leader('gca', '<Cmd>Git commit --amend<CR>',                       'Amend the last commit and edit the message.')
  H.map_leader('ghu', '<Cmd>Pick git_hunks scope="unstaged"<CR>',          'List unstaged hunks.')
  H.map_leader('ghU', '<Cmd>Pick git_hunks scope="unstaged" path="%"<CR>', 'List unstaged hunks of current file.')

  H.map_leader('lt',  '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
  H.map_leader('li',  '<Cmd>lua vim.lsp.buf.implementation()<CR>')
  H.map_leader('ls',  '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
  H.map_leader('lfo', '<Cmd>Pick lsp scope="document_symbol"<CR>')
  H.map_leader('lfr', '<Cmd>Pick lsp scope="references"<CR>')

  H.map_leader('dl',  '<Cmd>lua vim.diagnostic.setloclist()<CR>',          'List buffer diagnostics in location list.')
  H.map_leader('dq',  '<Cmd>lua vim.diagnostic.setqflist()<CR>',           'List global diagnostics in quickfix list.')
  H.map_leader('lfd', '<Cmd>Pick diagnostic scope="all"<CR>')
  H.map_leader('lfD', '<Cmd>Pick diagnostic scope="current"<CR>')
  -- stylua: ignore end
end)
