-- Habilitar true colors para que los colores se rendericen correctamente
vim.opt.termguicolors = true

-- Cargar la configuración inicial de Lazy.nvim
require("config.lazy")
require("lazy").setup({
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },
}, {})

require("lazy").setup(require("plugins.treesitter"))
require("lazy").setup(require("plugins.lsp"))

-- Configuraciones generales de Neovim
vim.o.wrap = true
vim.o.linebreak = true
vim.o.list = false
vim.o.breakindent = true
vim.diagnostic.config({
  virtual_text = false,
})
vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment", force = true })
vim.opt.shortmess:append("c")

-- Configuraciones específicas para Neovide
if vim.g.neovide then
  -- Configuración general
  vim.g.neovide_fork = false
  vim.g.neovide_frame = "full"
  vim.g.neovide_no_idle = not true -- Equivalente a idle = true
  vim.g.neovide_maximized = false
  vim.g.neovide_mouse_cursor_icon = "arrow"
  vim.g.neovide_no_multigrid = false
  vim.g.neovide_srgb = false
  vim.g.neovide_tabs = true
  vim.g.neovide_theme = "dark"
  vim.g.neovide_title_hidden = true
  vim.g.neovide_vsync = true
  vim.g.neovide_wsl = false

  -- Configuración de la fuente
  vim.o.guifont = "Iosevka_Nerd_Font,Iosevka:h17:w0:b:#e-subpixelantialias:#h-slight"

  -- Configuración de espaciado entre líneas
  vim.opt.linespace = 0

  -- Configuración de opacidad
  vim.g.neovide_opacity = 0.6
  vim.g.neovide_normal_opacity = 0.6
  vim.g.transparency = nil -- Desactiva cualquier configuración de transparencia

  -- Decoraciones de ventana
  vim.g.neovide_window_decorations = "none"

  -- Animaciones del cursor
  vim.g.neovide_cursor_animation_length = 0.15
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 0.5
  vim.g.neovide_cursor_vfx_particle_density = 0.7
  vim.g.neovide_cursor_vfx_particle_speed = 10.0

  vim.g.neovide_title_background_color = "#070C08"
  vim.g.neovide_title_text_color = "white"
  vim.g.neovide_background_color = "#0f1117"

  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_opacity = 0.0
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  -- Animaciones de desplazamiento
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_scroll_animation_far_lines = 1

  -- Efectos de ventanas flotantes
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_floating_corner_radius = 0.2

  -- Configuraciones adicionales
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_underline_stroke_scale = 1.0
end

-- Establecer el fondo como #191724
vim.api.nvim_set_hl(0, "Normal", { bg = "#191724", force = true })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#191724", force = true })

-- Forzar el fondo al final para evitar que otros plugins lo sobrescriban
vim.cmd("highlight Normal guibg=#191724")
vim.cmd("highlight NormalNC guibg=#191724")

-- Usar un autocmd para forzar el fondo después de que Neovide se inicie
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.g.neovide then
      vim.api.nvim_set_hl(0, "Normal", { bg = "#191724", force = true })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#191724", force = true })
      vim.cmd("highlight Normal guibg=#191724")
      vim.cmd("highlight NormalNC guibg=#191724")
    end
  end,
})
