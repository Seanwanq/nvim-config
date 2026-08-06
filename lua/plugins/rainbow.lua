return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",

    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
        },
      }

      local function set_rainbow_colors()
        local palette = require("rose-pine.palette")

        vim.api.nvim_set_hl(0, "RainbowDelimiterRed", {
          fg = palette.love,
        })
        vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", {
          fg = palette.gold,
        })
        vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", {
          fg = palette.foam,
        })
        vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", {
          fg = palette.rose,
        })
        vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", {
          fg = palette.pine,
        })
        vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", {
          fg = palette.iris,
        })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "rose-pine*",
        callback = set_rainbow_colors,
      })

      set_rainbow_colors()
    end,
  },
}
