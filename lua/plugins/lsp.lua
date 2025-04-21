return {
  -- tools

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typescript-language-server",
        "tailwindcss-language-server",
        "css-lsp",
        "astro-language-server",
      })
    end,
  },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.nvim",
    },
    opts = {
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayhints = {
                includeinlayparameternamehints = "literal",
                includeinlayparameternamehintswhenargumentmatchesname = false,
                includeinlayfunctionparametertypehints = true,
                includeinlayvariabletypehints = false,
                includeinlaypropertydeclarationtypehints = true,
                includeinlayfunctionlikereturntypehints = true,
                includeinlayenummembervaluehints = true,
              },
            },
            javascript = {
              inlayhints = {
                includeinlayparameternamehints = "all",
                includeinlayparameternamehintswhenargumentmatchesname = false,
                includeinlayfunctionparametertypehints = true,
                includeinlayvariabletypehints = true,
                includeinlaypropertydeclarationtypehints = true,
                includeinlayfunctionlikereturntypehints = true,
                includeinlayenummembervaluehints = true,
              },
            },
          },
        },
        html = {},
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            lua = {
              workspace = {
                checkthirdparty = false,
              },
              completion = {
                workspaceword = true,
                callsnippet = "both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                settype = false,
                paramtype = true,
                paramname = "disable",
                semicolon = "disable",
                arrayindex = "disable",
              },
              doc = {
                privatename = { "^_" },
              },
              type = {
                castnumbertointeger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupseverity = {
                  strong = "warning",
                  strict = "warning",
                },
                groupfilestatus = {
                  ["ambiguity"] = "opened",
                  ["await"] = "opened",
                  ["codestyle"] = "none",
                  ["duplicate"] = "opened",
                  ["global"] = "opened",
                  ["luadoc"] = "opened",
                  ["redefined"] = "opened",
                  ["strict"] = "opened",
                  ["strong"] = "opened",
                  ["type-check"] = "opened",
                  ["unbalanced"] = "opened",
                  ["unused"] = "opened",
                },
                unusedlocalexclude = { "_*" },
              },
              format = {
                enable = false,
                defaultconfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      setup = {},
      config = function(_, opts)
        local lspconfig = require("lspconfig")
        for server, config in pairs(opts.servers) do
          -- Integrar las capacidades de blink.cmp con los servidores LSP
          config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end
      end,
    },
  },
  {
    "saghen/blink.nvim",
    dependencies = {
      "rafamadriz/friendly-snippets", -- Para soporte de snippets
    },
    opts = {
      completion = {
        menu = {
          auto_show = true, -- Mostrar el menú automáticamente mientras escribes
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        -- Desactivar el ghost text de blink.cmp
        ghost_text = {
          enabled = false, -- Solo SuperMaven mostrará sugerencias inline
          show_with_menu = false,
        },
        -- Configurar el comportamiento de la lista de autocompletado
        list = {
          selection = {
            preselect = true, -- Seleccionar automáticamente el primer elemento
            auto_insert = false, -- No insertar automáticamente una vista previa
          },
        },
        -- Configurar el comportamiento al aceptar una sugerencia
        accept = {
          auto_brackets = {
            enabled = true, -- Permitir que el LSP añada paréntesis automáticamente
          },
        },
        -- Configurar la documentación (mostrar solo cuando se selecciona un elemento)
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      -- Definir las fuentes de autocompletado
      sources = {
        default = { "lsp", "path", "buffer", "snippets" },
      },
      -- Configurar el fuzzy matcher (usar el predeterminado de Rust para mejor rendimiento)
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
      emmet = {
        enabled = true,
        show_abbreviations = false,
      },
    },
  },
}
