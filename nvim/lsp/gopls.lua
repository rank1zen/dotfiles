--@type vim.lsp.Config
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  capabilites = {
    -- textDocument = {
    --   inlayHint = true,
    -- },
  },
  settings = {
    gopls = {
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      analyses = {
        unusedparams = true,
        unusedvariable = true,
        unusedwrite = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
