return {{
  'dstein64/vim-startuptime',
  cmd = "StartupTime",
  init = function()
    vim.g.startuptime_tries = 10
  end,
},
{
    "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
},
{
    'kylechui/nvim-surround',
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({

      })
    end
},
{
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "c", "cpp", "lua", "vim", "javascript", "html", "python", "c_sharp", "json", "toml", "csv", "rust" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      rainbow = { enable = true },
    })
  end
},
{
  'HiPhish/rainbow-delimiters.nvim',
    lazy=false,
  config = function()
    require('rainbow-delimiters.setup').setup {

    strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },}
  end
},
}

-- abots fadsf ahf asdfasdf adsfasdfad
