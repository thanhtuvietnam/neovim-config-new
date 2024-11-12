local colorschemes = {
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = true,
  --   -- priority = 1000,
  --   opts = {
  --     transparent = false,
  --   },
  -- },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "tiagovla/tokyodark.nvim",
    config = function(_, opts)
      require("tokyodark").setup(opts)
      -- vim.cmd([[colorscheme tokyodark]])
    end,
    opts = {
      transparent_background = true,
    },
  },
  -- {
  --   "bluz71/vim-moonfly-colors",
  --   name = "moonfly",
  --   lazy = false,
  --   -- priority = 1000,
  -- },
  {
    "2nthony/vitesse.nvim",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
    },
    config = function()
      require("vitesse").setup({
        transparent_background = false,
        transparent_float_background = true,
      })
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      -- vim.cmd("colorscheme github_dark")
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}

return colorschemes
