return {
    {
      'nvim-tree/nvim-web-devicons',
      lazy = true
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                options = {
                    icon_enabled = true,
                    theme = 'ayu_mirage',
                    -- theme = 'tokyonight',
                    -- component_separators = { left = '', right = ''},
                    -- section_separators = { left = '', right = ''},
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    },
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            })
        end,
    },
    {
      'nvim-tree/nvim-tree.lua',
      version = "*",
      lazy = false,
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        vim.opt.termguicolors = true

        vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<cr>", {silent = true, noremap = true})

        vim.api.nvim_create_autocmd("BufEnter", {
          group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
          pattern = "NvimTree_*",
          callback = function()
            local layout = vim.api.nvim_call_function("winlayout", {})
            if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
          end
})

        require('nvim-tree').setup {
          sort = {
            sorter = "case_sensitive",
          },
          view = {
            width = 30,
          },
          renderer = {
            group_empty = true,
          },
          filters = {
            dotfiles = true,
          },
        }
      end,
    },
    {
      'folke/which-key.nvim',
      event = "VeryLazy",
      opts = {
        preset = "helix",
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)"
        },
      },
    },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
    },
    config = function()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
  },
  {
    "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = true,
  keys = { -- load the plugin only when using it's keybinding:
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Open undo tree" },
  },
  },
  {
     'akinsho/toggleterm.nvim',
     config = true
  },
}
