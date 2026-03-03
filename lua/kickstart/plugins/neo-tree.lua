-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        hide_dotfiles = false,
      },
    },
    default_component_configs = {
      icon = {
        -- Folder icons
        folder_closed = '▸',
        folder_open = '▾', -- optional: open variant to match look
        folder_empty = '▸', -- optional: empty closed folder
        folder_empty_open = '▾', -- optional: empty open folder

        -- File icons - use "*" for everything
        -- To ensure "*" shows for all files, disable devicons for files.
        -- neo-tree will use this `default` when no devicon is applied.
        default = '*',
        highlight = 'NeoTreeFileIcon', -- keep default highlight
      },
    },
  },
  config = function(_, opts)
    -- Disable devicons for files by telling neo-tree to not use nvim-web-devicons for file icons.
    -- This forces the `default_component_configs.icon.default = "*"` to be used.
    local devicons = require 'nvim-web-devicons'
    -- Clear/override all file icons so they fall back to "*"
    for name, _ in pairs(devicons.get_icons()) do
      devicons.set_icon {
        [name] = { icon = '*', color = nil, name = name },
      }
    end

    require('neo-tree').setup(opts)
  end,
}
