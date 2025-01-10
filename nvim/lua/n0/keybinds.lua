vim.keymap.set('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'Signature' })
vim.keymap.set('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>')
vim.keymap.set({ 'n', 'x' }, 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>')

local leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<space>' .. suffix, rhs, opts)
end

-- stylua: ignore start

leader('en',   '<cmd>lua MiniVisits.iterate_paths("backward", nil, Cfg.gen_stack())<cr>')
leader('ep',   '<cmd>lua MiniVisits.iterate_paths("forward", nil, Cfg.gen_stack())<cr>')
leader('ef',   '<cmd>Pick files<cr>',                                       'List directory files')
leader('eg',   '<cmd>Pick grep_live<cr>',                                   'Live grep')
leader('eh',   '<cmd>Pick help<cr>',                                        'Pick and go to help file')
leader('ed',   '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>', 'Open file explorer at current file')
leader('es',   '<cmd>Pick list scope="jump"<cr>',                           'List the jumplist')
leader('ec',   '<cmd>Pick history scope=":"<cr>',                           'List command history')
leader('er',   '<cmd>Pick visit_paths<cr>',                                 'List MRU file stack')
leader('eR',   '<cmd>Pick visit_paths filter="core"<cr>')
leader('et',   '<cmd>Pick visit_labels<cr>',                                'List MRU file stack')
leader('ek',   '<cmd>lua MiniVisits.add_label("core")<cr>')

leader('lt',   '<cmd>lua vim.lsp.buf.type_definition()<cr>',                'Type definition')
leader('li',   '<cmd>lua vim.lsp.buf.implementation()<cr>',                 'Implementation')
leader('ls',   '<cmd>lua vim.lsp.buf.signature_help()<cr>',                 'Signature')
leader('lu',   '<cmd>lua vim.lsp.buf.declaration()<cr>',                    'Declaration')
leader('lfo',  '<cmd>Pick lsp scope="document_symbol"<cr>',                 'Document symbol')
leader('lfw',  '<cmd>Pick lsp scope="workspace_symbol"<cr>',                'Workspace symbol')
leader('lfr',  '<cmd>Pick lsp scope="references"<cr>',                      'References')
leader('lfd',  '<cmd>Pick diagnostic scope="all"<cr>',                      'Diagnostic (all)')
leader('lfD',  '<cmd>Pick diagnostic scope="current"<cr>',                  'Diagnostic (current)')
leader('lar',  '<cmd>lua vim.lsp.buf.rename()<cr>',                         'Rename')
leader('las',  '<cmd>lua vim.lsp.buf.code_action()<cr>',                    'Code Action')
leader('lgt',  '<cmd>lua Cfg.maps.golang_test_file()<cr>',                  'Switch Go _test')
leader('lr',   '<cmd>lua vim.lsp.stop_client(vim.lsp.get_clients())',       'Stop all lsp clients')

leader('gcc',  '<cmd>Git commit<cr>',                                       'Create a commit')
leader('gca',  '<cmd>Git commit --amend<cr>',                               'Amend the last commit and edit the message')
leader('gbb',  '<cmd>vert Git blame -- %<cr>')
leader('gczz', '<cmd>Git stash<cr>',                                        'Push stash')
leader('gczw', '<cmd>Git stash --keep-index<cr>',                           'Push stash of the work-tree')
leader('ghu',  '<cmd>Pick git_hunks scope="unstaged"<cr>',                  'List unstaged hunks')
leader('ghU',  '<cmd>Pick git_hunks scope="unstaged" path="%"<cr>',         'List unstaged hunks of current file')
