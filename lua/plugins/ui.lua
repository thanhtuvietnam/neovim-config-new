local Ui = {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  -- stylua: ignore
  keys = {
    { "<leader>sn", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
      -- Disable hover and signature help
      opts.lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
      }

      -- Customize notifications for Lazy.nvim
      opts.routes = vim.list_extend(opts.routes or {}, {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "Lazy",
          },
          opts = { skip = true },
        },
      })
    end,
  },

  -- filename
  {
    "b0o/incline.nvim",
    enabled = true,
    dependencies = {
      "folke/tokyodark.nvim",
      "nvim-tree/nvim-web-devicons",
      "tiagovla/tokyodark.nvim",
    },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("tokyodark").setup({
        style = "dark",
      })
      -- vim.cmd.colorscheme("tokyodark")

      local colors = require("solarized-osaka.colors").setup()
      if not colors then
        vim.notify("Failed to load tokyodark.colors", vim.log.levels.ERROR)
        colors = {
          magenta = "#FF00FF",
          violet = "#9900FF",
          base04 = "#003366",
          base03 = "#002244",
          bg = "#1E1E1E",
          bg_dark = "#101010",
          bglight = "#ebfaff",
        }
      end

      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.violet, guifg = colors.bg },
            InclineNormalNC = { guifg = colors.magenta, guibg = colors.bg_dark },
          },
        },
        window = {
          margin = { vertical = 0, horizontal = 0 },
          padding = { left = 1, right = 1 },
          zindex = 50,
        },
        hide = {
          cursorline = false,
          focused_win = false,
          only_win = true,
        },
        render = function(props)
          local buf = props.buf
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")

          if vim.bo[buf].modified then
            filename = "+ " .. filename
          end

          local ok, devicons = pcall(require, "nvim-web-devicons")
          local icon, color = "", "#ffffff"

          if ok then
            icon, color = devicons.get_icon_color(filename, vim.bo[buf].filetype, { default = true })
          end

          return {
            { icon, guifg = color },
            { " " },
            { filename },
          }
        end,
      })
    end,
  },

  -- Zenmode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- animations
  -- {
  --   "echasnovski/mini.animate",
  --   enabled = false,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     -- don't use animate when scrolling with the mouse
  --     local mouse_scrolled = false
  --     for _, scroll in ipairs({ "Up", "Down" }) do
  --       local key = "<ScrollWheel" .. scroll .. ">"
  --       vim.keymap.set({ "", "i" }, key, function()
  --         mouse_scrolled = true
  --         return key
  --       end, { expr = true })
  --     end
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = "grug-far",
  --       callback = function()
  --         vim.b.minianimate_disable = true
  --       end,
  --     })
  --
  --     Snacks.toggle({
  --       name = "Mini Animate",
  --       get = function()
  --         return not vim.g.minianimate_disable
  --       end,
  --       set = function(state)
  --         vim.g.minianimate_disable = not state
  --       end,
  --     }):map("<leader>ua")
  --
  --     local animate = require("mini.animate")
  --     return vim.tbl_deep_extend("force", opts, {
  --       resize = {
  --         timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
  --       },
  --       scroll = {
  --         timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
  --         subscroll = animate.gen_subscroll.equal({
  --           predicate = function(total_scroll)
  --             if mouse_scrolled then
  --               mouse_scrolled = false
  --               return false
  --             end
  --             return total_scroll > 1
  --           end,
  --         }),
  --       },
  --     })
  --   end,
  -- },
  -- mini icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },
  -- nui
  { "MunifTanjim/nui.nvim", lazy = true },

  -- mini-indent scope
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",
    opts = function(_, opts)
      opts.symbol = "│"
      opts.options = { try_as_border = true }
      opts.draw = {
        delay = 0.01,
        animation = require("mini.indentscope").gen_animation.none(),
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "Trouble",
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "notify",
          "snacks_dashboard",
          "snacks_notif",
          "snacks_terminal",
          "snacks_win",
          "toggleterm",
          "trouble",
        },
        callback = function()
          vim.b["miniindentscope_disable"] = true
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "SnacksDashboardOpened",
        callback = function(data)
          vim.b[data.buf].miniindentscope_disable = true
        end,
      })
    end,
  },

  -- indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      "nmac427/guess-indent.nvim",
      "HiPhish/rainbow-delimiters.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LazyFile",
    main = "ibl",
    opts = function()
      local hooks = require("ibl.hooks")

      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
        "CursorColumn",
        "Whitespace",
      }

      Snacks.toggle({
        name = "Indention Guides",
        get = function()
          return require("ibl.config").get_config(0).enabled
        end,
        set = function(state)
          require("ibl").setup_buffer(0, { enabled = state })
        end,
      }):map("<leader>ug")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      return {
        indent = {
          char = "│",
          tab_char = "│",
          smart_indent_cap = true,
        },
        whitespace = {
          remove_blankline_trail = false,
        },
        scope = {
          show_exact_scope = true,
          highlight = highlight,
          show_start = true,
          show_end = false,
          enabled = true,
        },
        exclude = {
          filetypes = {
            "Trouble",
            "alpha",
            "dashboard",
            "help",
            "lazy",
            "mason",
            "neo-tree",
            "notify",
            "snacks_dashboard",
            "snacks_notif",
            "snacks_terminal",
            "snacks_win",
            "toggleterm",
            "trouble",
          },
        },
      }
    end,
  },

  -- cursorline
  {
    "yamatsum/nvim-cursorline",
    enabled = false,
    opts = {
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      },
      cursorline = {
        enable = true,
      },
    },
  },
}
return Ui
