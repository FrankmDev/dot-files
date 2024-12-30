return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      -- Definición de colores para el tema
      local colors = {
        blue = "#a86807",
        cyan = "#79dac8",
        black = "#080808",
        white = "#c6c6c6",
        red = "#ff5189",
        violet = "#430973",
        grey = "#080808",
      }

      -- Tema bubbles
      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.violet, bg = colors.grey },
          c = { fg = colors.white },
        },

        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.white },
        },
      }

      -- Configuración de Lualine
      require("lualine").setup({
        options = {
          theme = bubbles_theme, -- Usar el tema bubbles
          component_separators = "", -- Separadores vacíos
          section_separators = { left = "", right = "" }, -- Separadores con íconos
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "filename", "branch" },
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },

  {
    "kdheepak/lazygit.nvim",
    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
      },
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      {

        "<leader>d",
        "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
 ██████╗ ██████╗ ███████╗███╗   ███╗ ██████╗ ███████╗
██╔════╝██╔═══██╗██╔════╝████╗ ████║██╔═══██╗██╔════╝
██║     ██║   ██║███████╗██╔████╔██║██║   ██║███████╗
██║     ██║   ██║╚════██║██║╚██╔╝██║██║   ██║╚════██║
╚██████╗╚██████╔╝███████║██║ ╚═╝ ██║╚██████╔╝███████║
 ╚═════╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚══════
	         ]],
        },
      },
    },
  },
}
