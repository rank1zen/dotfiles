if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end

local hi = function(name, data) vim.api.nvim_set_hl(0, name, data) end

local p = {
  bg = ""
}

-- Standard syntax (affects treesitter)
-- stylua: ignore start
-- hi('Boolean',        { link = 'Constant' })
-- hi('Character',      { link = 'Constant' })
-- hi('Comment',        { fg = p.fg_mid2, bg = nil })
-- hi('Conditional',    { link = 'Statement' })
-- hi('Constant',       { fg = p.purple,  bg = nil })
-- hi('Debug',          { link = 'Special' })
-- hi('Define',         { link = 'PreProc' })
-- hi('Delimiter',      { fg = p.orange,  bg = nil })
-- hi('Error',          { fg = nil,       bg = p.red_bg })
-- hi('Exception',      { link = 'Statement' })
-- hi('Float',          { link = 'Constant' })
hi('Function',       { fg = '#000000',   bg = nil, italic = true })
-- hi('Identifier',     { fg = p.yellow,  bg = nil })
-- hi('Ignore',         { fg = nil,       bg = nil })
-- hi('Include',        { link = 'PreProc' })
-- hi('Keyword',        { link = 'Statement' })
-- hi('Label',          { link = 'Statement' })
-- hi('Macro',          { link = 'PreProc' })
-- hi('Number',         { link = 'Constant' })
-- hi('Operator',       { fg = p.fg,      bg = nil })
-- hi('PreCondit',      { link = 'PreProc' })
-- hi('PreProc',        { fg = p.blue,    bg = nil })
-- hi('Repeat',         { link = 'Statement' })
-- hi('Special',        { fg = p.cyan,    bg = nil })
-- hi('SpecialChar',    { link = 'Special' })
-- hi('SpecialComment', { link = 'Special' })
-- hi('Statement',      { fg = p.fg,      bg = nil,         bold = true })
-- hi('StorageClass',   { link = 'Type' })
-- hi('String',         { fg = p.green,   bg = nil })
-- hi('Structure',      { link = 'Type' })
-- hi('Tag',            { link = 'Special' })
-- hi('Todo',           { fg = p.accent,  bg = p.accent_bg, bold = true })
-- hi('Type',           { fg = p.fg,      bg = nil })
-- hi('Typedef',        { link = 'Type' })
-- stylua: ignore end

vim.g.colors_name = 'zoom'
