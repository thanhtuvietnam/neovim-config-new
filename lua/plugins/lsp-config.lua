return {
  --tools
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          --old
          "tsserver",
          "eslint",
          "html",
          "cssls",
          "tailwindcss",
          "emmet_ls",

          "stylua",
          "selene",
          "luacheck",
          "shellcheck",
          "shfmt",
          "tailwindcss-language-server",
          "typescript-language-server",
          "css-lsp",
        },
        automatic_installation = true,
      })
      --LSP server
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- local configs = require("lspconfig.configs")
      -- TypeScript/JavaScript
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        init_options = {
          preferences = {
            disableSuggestions = false,
          },
        },
      })
      -- ESLint
      lspconfig.eslint.setup({
        capabilities = capabilities,
      })

      -- HTML
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = {
          "templ",
          "html",
          "css",
          "javascriptreact",
          "typescriptreact",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
        },
      })
      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })

      -- Tailwind CSS
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = {
          "templ",
          "html",
          "css",
          "javascriptreact",
          "typescriptreact",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
        },
        root_dir = require("lspconfig").util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs",
          "postcss.config.mjs",
          "postcss.config.ts",
          "package.json",
          "node_modules",
          ".git"
        ),
      })
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "templ",
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
          "jsx",
          "tsx",
          "markdown",
          "javascript",
          "typescript",
        },
      })
      -- if not configs.ts_ls then
      --   configs.ts_ls = {
      --     default_config = {
      --       capabilties = capabilities,
      --       filetypes = {
      --         "javascript",
      --         "javascriptreact",
      --         "typescript",
      --         "typescriptreact",
      --         "html",
      --       },
      --     },
      --   }
      -- end

      require("lspconfig").clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--pch-storage=memory",
          "--all-scopes-completion",
          "--pretty",
          "--header-insertion=never",
          "-j=4",
          "--inlay-hints",
          "--header-insertion-decorators",
          "--function-arg-placeholders",
          "--completion-style=detailed",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require("lspconfig").util.root_pattern("src"),
        init_option = { fallbackFlags = { "-std=c++2a" } },
        capabilities = capabilities,
      })
    end,
  },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    -- opts = {
    --   inlay_hints = { enabled = false },
    --   ---@type lspconfig.options
    --   servers = {
    --     cssls = {},
    --     tailwindcss = {
    --       root_dir = function(...)
    --         return require("lspconfig.util").root_pattern(".git")(...)
    --       end,
    --     },
    --     tsserver = {
    --       root_dir = function(...)
    --         return require("lspconfig.util").root_pattern(".git")(...)
    --       end,
    --       single_file_support = false,
    --       settings = {
    --         typescript = {
    --           inlayHints = {
    --             includeInlayParameterNameHints = "literal",
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHints = false,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --           },
    --         },
    --         javascript = {
    --           inlayHints = {
    --             includeInlayParameterNameHints = "all",
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHints = true,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --           },
    --         },
    --       },
    --     },
    --     html = {},
    --     yamlls = {
    --       settings = {
    --         yaml = {
    --           keyOrdering = false,
    --         },
    --       },
    --     },
    --     lua_ls = {
    --       -- enabled = false,
    --       single_file_support = true,
    --       settings = {
    --         Lua = {
    --           workspace = {
    --             checkThirdParty = false,
    --           },
    --           completion = {
    --             workspaceWord = true,
    --             callSnippet = "Both",
    --           },
    --           misc = {
    --             parameters = {
    --               -- "--log-level=trace",
    --             },
    --           },
    --           hint = {
    --             enable = true,
    --             setType = false,
    --             paramType = true,
    --             paramName = "Disable",
    --             semicolon = "Disable",
    --             arrayIndex = "Disable",
    --           },
    --           doc = {
    --             privateName = { "^_" },
    --           },
    --           type = {
    --             castNumberToInteger = true,
    --           },
    --           diagnostics = {
    --             disable = { "incomplete-signature-doc", "trailing-space" },
    --             -- enable = false,
    --             groupSeverity = {
    --               strong = "Warning",
    --               strict = "Warning",
    --             },
    --             groupFileStatus = {
    --               ["ambiguity"] = "Opened",
    --               ["await"] = "Opened",
    --               ["codestyle"] = "None",
    --               ["duplicate"] = "Opened",
    --               ["global"] = "Opened",
    --               ["luadoc"] = "Opened",
    --               ["redefined"] = "Opened",
    --               ["strict"] = "Opened",
    --               ["strong"] = "Opened",
    --               ["type-check"] = "Opened",
    --               ["unbalanced"] = "Opened",
    --               ["unused"] = "Opened",
    --             },
    --             unusedLocalExclude = { "_*" },
    --           },
    --           format = {
    --             enable = false,
    --             defaultConfig = {
    --               indent_style = "space",
    --               indent_size = "2",
    --               continuation_indent_size = "2",
    --             },
    --           },
    --         },
    --       },
    --     },
    --   },
    --   setup = {},
    -- },
    opts = function()
      -- local border = {
      --   { "╭", "FloatBorder" },
      --   { "─", "FloatBorder" },
      --   { "╮", "FloatBorder" },
      --   { "│", "FloatBorder" },
      --   { "╯", "FloatBorder" },
      --   { "─", "FloatBorder" },
      --   { "╰", "FloatBorder" },
      --   { "│", "FloatBorder" },
      -- }
      -- Config hover
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = false,
          float = { border = "rounded" },
          -- virtual_text = {
          --   spacing = 4,
          --   source = "if_many",
          --   prefix = "●",
          --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          --   -- prefix = "icons",
          -- },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },

        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- Enable lsp cursor word highlighting
        document_highlight = {
          enabled = true,
        },

        -- add any global capabilities her

        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },

        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- setup autoformat
      LazyVim.format.register(LazyVim.lsp.formatter())

      -- setup keymaps
      LazyVim.lsp.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      LazyVim.lsp.setup()
      LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

      LazyVim.lsp.words.setup(opts.document_highlight)

      -- diagnostics signs
      if vim.fn.has("nvim-0.10.0") == 0 then
        if type(opts.diagnostics.signs) ~= "boolean" then
          for severity, icon in pairs(opts.diagnostics.signs.text) do
            local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
          end
        end
      end

      if vim.fn.has("nvim-0.10") == 1 then
        -- inlay hints
        if opts.inlay_hints.enabled then
          LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end)
        end

        -- code lens
        if opts.codelens.enabled and vim.lsp.codelens then
          LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end)
        end
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = LazyVim.config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = vim.tbl_deep_extend(
            "force",
            ensure_installed,
            LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
          ),
          handlers = { setup },
        })
      end

      if LazyVim.lsp.is_enabled("denols") and LazyVim.lsp.is_enabled("vtsls") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        LazyVim.lsp.disable("vtsls", is_deno)
        LazyVim.lsp.disable("denols", function(root_dir, config)
          if not is_deno(root_dir) then
            config.settings.deno.enable = false
          end
          return false
        end)
      end
    end,
  },
  -- Nvim lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        {
          "gd",
          function()
            -- DO NOT RESUSE WINDOW
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end,
          desc = "Goto Definition",
          has = "definition",
        },
      })
    end,
  },

  -- Fix clangd offset encodings
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },

  -- Using Eslint with Eslint-plugin-prettier
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
}
