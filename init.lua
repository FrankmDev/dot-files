-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("lazy").setup({
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },
}, {})
vim.o.wrap = true
vim.o.linebreak = true
vim.o.list = false
vim.o.breakindent = true
