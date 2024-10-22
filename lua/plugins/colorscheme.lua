return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        -- transparent = true,
        transparent = false,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      -- transparent = true,
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
      vim.cmd([[colorscheme tokyodark]])
    end,
  },
}
