Theme = {}

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowOpen',
  callback = function(args)
    local config = vim.api.nvim_win_get_config(args.data.win_id)
    config.border = 'solid'
    vim.api.nvim_win_set_config(args.data.win_id, config)
  end,
})

Theme.mini_pick = function()
  return {
    options = {
      content_from_bottom = true,
    },
    source = {
      show = function(buf_id, items, query)
        require('mini.pick').default_show(buf_id, items, query, {
          show_icons = true,
          icons = {
            directory = ' ',
            file = ' ',
            none = '  ',
          },
        })
      end,
    },
    window = {
      config = function()
        local h = math.floor(0.8 * vim.o.lines)
        local w = math.floor(0.6 * vim.o.columns)
        return {
          anchor = 'NW',
          row = math.floor(0.4 * (vim.o.lines - h)),
          col = math.floor(0.5 * (vim.o.columns - w)),
          height = h,
          width = w,
          border = 'solid',
        }
      end,
      -- prompt_cursor = ' <<<',
      prompt_prefix = '  ',
    },
  }
end

Theme.mini_files = function()
  return {
    content = {
      prefix = function(fs_entry)
        if fs_entry.fs_type == 'directory' then
          return ' ', 'MiniFilesDirectory'
        else
          return ' ', 'MiniFilesFile'
        end
      end,
    },
  }
end

Theme.mini_completion = function()
  return {
    window = {
      info = {
        border = 'solid',
      },
      signature = {
        border = 'solid',
      },
    },
  }
end

Theme.set_global_opts = function()
  vim.o.showmode = false
  vim.o.winblend = 7
  vim.o.pumheight = 10
end

return Theme
