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

require("lazy").setup(require("plugins.treesitter"))
vim.o.wrap = true
vim.o.linebreak = true
vim.o.list = false
vim.o.breakindent = true
vim.diagnostic.config({
  virtual_text = false,
})
