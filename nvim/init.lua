_G.Cfg = {}

Cfg.leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end

Cfg.xeader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end

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

local deps = require('mini.deps')

deps.setup {
  path = { package = path_package },
}

deps.now(function()
  Cfg.borders = 'rounded'

  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'

  vim.o.autoindent = true
  vim.o.pumheight = 10
  vim.o.showmode = false

  vim.o.statusline = '%<%f %{getbufvar(bufnr(), "minigit_summary_string")} %h%m%r %= %-14.(%l,%c%V%) %P'

  vim.filetype.add {
    extension = {
      templ = 'templ',
    },
    pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
  }

  vim.diagnostic.config {
    virtual_text = {},
    float = { border = Cfg.borders, source = 'if_many' },
    signs = false,
  }

  -- vim.cmd('colorscheme zoom')
end)

deps.later(function() require('mini.extra').setup() end)

Cfg.gen_stack = function()
  return {
    filter = function(path_data) return vim.fn.isdirectory(path_data.path) == 0 end,
    sort = require('mini.visits').gen_sort.default { recency_weight = 1 },
  }
end

Cfg.gen_z = function()
  return {
    filter = function(path_data) return vim.fn.isdirectory(path_data.path) == 0 end,
    sort = require('mini.visits').gen_sort.z(),
  }
end

deps.now(function()
  Cfg.leader('en', '<cmd>lua MiniVisits.iterate_paths("backward", nil, Cfg.gen_stack())<cr>')
  Cfg.leader('ep', '<cmd>lua MiniVisits.iterate_paths("forward",  nil, Cfg.gen_stack())<cr>')
  -- stylua: ignore start
  Cfg.leader('ef', '<cmd>Pick files<cr>',                                         'List directory files')
  Cfg.leader('eg', '<cmd>Pick grep_live<cr>',                                     'Live grep')
  Cfg.leader('er', '<cmd>lua MiniExtra.pickers.visit_paths(Cfg.gen_stack())<cr>', 'List MRU file stack')
  Cfg.leader('et', '<cmd>lua MiniExtra.pickers.visit_paths(Cfg.gen_z())<cr>',     'List Z file stack')
  Cfg.leader('ec', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>',   'Open file explorer at current file')
  Cfg.leader('ed', '<cmd>lua MiniFiles.open()<cr>',                               'Open file explorer at CWD')
  Cfg.leader('eb', '<cmd>Pick buf_lines<cr>',                                     'Pick and go to line')
  Cfg.leader('ev', '<cmd>Pick help<cr>',                                          'Pick and go to help file')
  Cfg.leader('es', '<cmd>Pick list scope="jump"<cr>',                             'List the jumplist')
  Cfg.leader('ez', '<cmd>Pick resume<cr>',                                        'Resume most recent picker')
  Cfg.leader('ew', '<cmd>Pick grep pattern="<cword>"<cr>',                        'Grep current word')
  Cfg.leader('eq', '<cmd>Pick history scope=":"<cr>',                             'List command history')
  Cfg.leader('ex', '<cmd>Pick options<cr>',                                       'Pick and apply option')
  Cfg.leader('ea', '<cmd>Pick spellsuggest<cr>',                                  'Suggest spelling')
  -- stylua: ignore end
end)

deps.later(function() require('mini.visits').setup() end)

deps.later(function()
  require('mini.ai').setup {
    custom_textobjects = {
      -- default objs: b, q, t, f, a
      l = require('mini.extra').gen_ai_spec.line(),
      i = require('mini.extra').gen_ai_spec.indent(),
      g = require('mini.extra').gen_ai_spec.buffer(),
      c = require('mini.ai').gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
      d = require('mini.ai').gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
      p = require('mini.ai').gen_spec.treesitter { a = '@parameter.outer', i = '@parameter.inner' },
    },
  }
end)

deps.later(function()
  require('mini.pick').setup {
    options = { content_from_bottom = true, use_cache = false },
    source = { show = require('mini.pick').default_show },
    window = {
      config = function()
        return { height = math.floor(0.5 * vim.o.lines), width = vim.o.columns, row = 0, border = 'solid' }
      end,
      prompt_cursor = ' <<<',
      prompt_prefix = '',
    },
  }
end)

deps.later(function()
  require('mini.files').setup {
    content = { prefix = function() end },
    options = { permanent_delete = false, use_as_default_explorer = false },
  }

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local config = vim.api.nvim_win_get_config(args.data.win_id)
      config.border = 'solid'
      vim.api.nvim_win_set_config(args.data.win_id, config)
    end,
  })
end)

deps.now(function()
  local keys = {
    ['cr'] = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
    ['ctrl-y'] = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
    ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
  }

  _G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      local item_selected = vim.fn.complete_info()['selected'] ~= -1
      return item_selected and keys['ctrl-y_cr'] or keys['ctrl-y']
    else
      return require('mini.pairs').cr()
    end
  end

  vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
  vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
  vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })
end)

deps.later(function()
  require('mini.completion').setup {
    lsp_completion = {
      auto_setup = false,
      source_func = 'omnifunc',
      process_items = function(items, base)
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return require('mini.completion').default_process_items(items, base)
      end,
    },
    window = {
      info = { border = Cfg.borders },
      signature = { border = Cfg.borders },
    },
  }
end)

deps.later(function() require('mini.jump2d').setup() end)

deps.now(function()
  -- stylua: ignore start
  Cfg.leader('gcc',  '<cmd>Git commit<cr>',                               'Create a commit')
  Cfg.leader('gca',  '<cmd>Git commit --amend<cr>',                       'Amend the last commit and edit the message')

  Cfg.leader('gbb',  '<cmd>vert Git blame -- %<cr>')

  Cfg.leader('gczz', '<cmd>Git stash<cr>',                                'Push stash')
  Cfg.leader('gczw', '<cmd>Git stash --keep-index<cr>',                   'Push stash of the work-tree')

  Cfg.leader('ghu',  '<cmd>Pick git_hunks scope="unstaged"<cr>',          'List unstaged hunks')
  Cfg.leader('ghU',  '<cmd>Pick git_hunks scope="unstaged" path="%"<cr>', 'List unstaged hunks of current file')
  -- stylua: ignore end
end)

deps.later(function() require('mini.diff').setup() end)
deps.later(function() require('mini.git').setup() end)

deps.later(function() require('mini.pairs').setup() end)
deps.later(function() require('mini.align').setup() end)
deps.later(function() require('mini.operators').setup() end)
deps.later(function() require('mini.surround').setup() end)

deps.later(function() require('mini.splitjoin').setup() end)
deps.later(function() require('mini.trailspace').setup() end)

deps.later(function()
  -- deps.add({
  --   source = 'nvim-treesitter/nvim-treesitter',
  --   checkout = 'master',
  --   monitor = 'main',
  --   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  -- })

  deps.add('nvim-treesitter/nvim-treesitter-textobjects')

  require('nvim-treesitter.configs').setup {
    ensure_installed = {},
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = function(_, buf)
        if not vim.bo[buf].modifiable then return false end
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

deps.now(function()
  -- stylua: ignore start
  Cfg.leader('lq',  '<cmd>lua vim.lsp.buf.definition()<cr>',      'Definition')
  Cfg.leader('lt',  '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Type definition')
  Cfg.leader('lr',  '<cmd>Pick lsp scope="references"<cr>',       'References')
  Cfg.leader('li',  '<cmd>lua vim.lsp.buf.implementation()<cr>',  'Implementation')
  Cfg.leader('ls',  '<cmd>lua vim.lsp.buf.signature_help()<cr>',  'Signature')

  Cfg.leader('lfo', '<cmd>Pick lsp scope="document_symbol"<cr>',  'Document symbol')
  Cfg.leader('lfw', '<cmd>Pick lsp scope="workspace_symbol"<cr>', 'Workspace symbol')

  Cfg.leader('lfq', '<cmd>Pick lsp scope="definition"<cr>',       'Definition')
  Cfg.leader('lfi', '<cmd>Pick lsp scope="implementation"<cr>',   'Implementation')
  Cfg.leader('lfu', '<cmd>Pick lsp scope="declaration"<cr>',      'Declaration')
  Cfg.leader('lft', '<cmd>Pick lsp scope="type_definition"<cr>',  'Type definition')

  Cfg.leader('lfd', '<cmd>Pick diagnostic scope="all"<cr>',       'Diagnostic (all)')
  Cfg.leader('lfD', '<cmd>Pick diagnostic scope="current"<cr>',   'Diagnostic (current)')

  Cfg.leader('lar', '<cmd>lua vim.lsp.buf.rename()<cr>',          'Rename')
  Cfg.leader('las', '<cmd>lua vim.lsp.buf.code_action()<cr>',     'Code Action')

  Cfg.leader('laf', '<cmd>lua require("conform").format()<cr>',   'Format')
  Cfg.xeader('laf', '<cmd>lua require("conform").format()<cr>',   'Format Selection')

  Cfg.leader('lga', '<cmd>lua Cfg.maps.golang_test_file()<cr>',   'Switch Go _test')
  -- stylua: ignore end
end)

deps.later(function()
  deps.add('stevearc/conform.nvim')

  require('conform').setup {
    formatters_by_ft = {
      go = { 'goimports', 'gofumpt' },
      lua = { 'stylua' },
      nix = { 'alejandra' },
      templ = { 'templ' },
      c = { 'clang-format' },
    },
  }
end)

deps.later(function()
  deps.add('neovim/nvim-lspconfig')

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end,
  })

  require('lspconfig').ccls.setup {}
  require('lspconfig').gopls.setup {}
  require('lspconfig').lua_ls.setup {}
  require('lspconfig').pyright.setup {}
  require('lspconfig').templ.setup {}
  require('lspconfig').texlab.setup {}
  require('lspconfig').nixd.setup {}
end)

Cfg.maps.golang_test_file = function()
  local file = vim.fn.expand('%')
  if #file <= 1 then
    vim.notify('(cfg) no buffer name', vim.log.levels.ERROR)
    return
  end

  if string.find(file, '_test%.go$') then
    vim.cmd('edit ' .. string.gsub(file, '_test.go', '.go'))
  elseif string.find(file, '%.go$') then
    vim.cmd('edit ' .. vim.fn.expand('%:r') .. '_test.go')
  else
    vim.notify('(cfg) not a go file', vim.log.levels.ERROR)
  end
end
