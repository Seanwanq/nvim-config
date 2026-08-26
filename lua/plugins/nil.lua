return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if vim.fn.has("win32") == 1 then
        opts.ensure_installed = vim.tbl_filter(function(pkg)
          return pkg ~= "nil"
        end, opts.ensure_installed or {})
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {
          enabled = vim.fn.has("win32") == 0,
        },
      },
    },
  },
}
