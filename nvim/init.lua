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

Deps.now(function()
  vim.cmd('colorscheme default')
end)

Deps.now(function()
  require('n0.keybinds')
end)

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
    pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
  }

  vim.lsp.enable { 'gopls', 'luals', 'nixd', 'pyright', 'templ', 'texlab' }
end)

Deps.later(function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end,
  })
end)

Deps.later(function()
  require('mini.extra').setup()
end)

Cfg.gen_stack = function()
  return {
    filter = function(path_data)
      return vim.fn.isdirectory(path_data.path) == 0
    end,
    sort = require('mini.visits').gen_sort.default { recency_weight = 1 },
  }
end

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

Deps.now(function()
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
  -- deps.add({
  --   source = 'nvim-treesitter/nvim-treesitter',
  --   checkout = 'master',
  --   monitor = 'main',
  --   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  -- })

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
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == 'go' then
        return { timeout_ms = 500, formatters = { 'goimports' } }
      end
      if vim.bo[bufnr].filetype == 'markdown' then
        return { timeout_ms = 500, formatters = { 'prettier' } }
      end
    end,
  }
end)

Deps.later(function()
  local snippets = require('mini.snippets')
  snippets.setup {
    snippets = {
      snippets.gen_loader.from_file('~/nix-cfg/nvim/snippets/global.json'),
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
